import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

/// Trình phát video bài giảng nhúng trực tiếp (Inline Embedded Player)
/// Hỗ trợ phát video YouTube ngay trên màn hình bài học chuẩn Cinema Mode như Coursera / Udemy.
/// Tự động fallback an toàn trên mọi nền tảng (Android, iOS, Web, Windows).
class LessonVideoPlayerBox extends StatefulWidget {
  const LessonVideoPlayerBox({
    super.key,
    required this.estimatedMinutes,
    this.videoUrl,
    this.title,
    this.isCinemaMode = true,
    this.autoFullScreen = false,
  });

  final int estimatedMinutes;
  final String? videoUrl;
  final String? title;
  final bool isCinemaMode;
  final bool autoFullScreen;

  @override
  State<LessonVideoPlayerBox> createState() => _LessonVideoPlayerBoxState();
}

class _LessonVideoPlayerBoxState extends State<LessonVideoPlayerBox> {
  YoutubePlayerController? _controller;
  bool _isPlayingInline = false;

  bool get _isWebViewAvailable {
    try {
      return WebViewPlatform.instance != null;
    } catch (_) {
      return false;
    }
  }

  String? get _youtubeVideoId {
    if (widget.videoUrl == null || widget.videoUrl!.trim().isEmpty) return null;
    final url = widget.videoUrl!.trim();
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    if (uri.host.contains('youtube.com')) {
      if (uri.queryParameters.containsKey('v')) {
        return uri.queryParameters['v'];
      }
      if (uri.pathSegments.contains('embed')) {
        final index = uri.pathSegments.indexOf('embed');
        if (index + 1 < uri.pathSegments.length) {
          return uri.pathSegments[index + 1];
        }
      }
    } else if (uri.host.contains('youtu.be')) {
      if (uri.pathSegments.isNotEmpty) {
        return uri.pathSegments.first;
      }
    }
    return null;
  }

  String? get _thumbnailUrl {
    final videoId = _youtubeVideoId;
    if (videoId != null && videoId.isNotEmpty) {
      return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _initControllerIfNeeded();
  }

  @override
  void didUpdateWidget(covariant LessonVideoPlayerBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller?.close();
      _controller = null;
      _isPlayingInline = false;
      _initControllerIfNeeded();
    }
  }

  void _initControllerIfNeeded() {
    if (!_isWebViewAvailable) {
      _controller = null;
      return;
    }

    final videoId = _youtubeVideoId;
    if (videoId != null && videoId.isNotEmpty) {
      try {
        _controller = YoutubePlayerController.fromVideoId(
          videoId: videoId,
          autoPlay: true,
          params: const YoutubePlayerParams(
            showControls: true,
            showFullscreenButton: true,
            mute: false,
            enableCaption: true,
            playsInline: true,
          ),
        );
      } catch (_) {
        _controller = null;
      }
    }
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  Future<void> _openExternal(BuildContext context) async {
    final url = widget.videoUrl;
    if (url == null || url.trim().isEmpty) return;

    final uri = Uri.tryParse(url.trim());
    if (uri != null) {
      try {
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (!launched) {
          await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Không thể mở liên kết: $url'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final thumb = _thumbnailUrl;
    final hasValidUrl =
        widget.videoUrl != null && widget.videoUrl!.trim().isNotEmpty;
    final canPlayInline = _controller != null && _isWebViewAvailable;

    final borderRadius = widget.isCinemaMode
        ? BorderRadius.zero
        : BorderRadius.circular(20);

    // 1. Trạng thái đang phát inline (Inline Player)
    if (_isPlayingInline && canPlayInline) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: borderRadius,
          border: widget.isCinemaMode ? null : Border.all(color: AppColors.border),
          boxShadow: widget.isCinemaMode
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.textPrimary.withValues(alpha: 0.15),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayer(
              controller: _controller!,
              aspectRatio: 16 / 9,
              autoFullScreen: widget.autoFullScreen,
              enableFullScreenOnVerticalDrag: false,
            ),
          ),
        ),
      );
    }

    // 2. Trạng thái hiển thị Poster xem trước (Tap to Play)
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: borderRadius,
        border: widget.isCinemaMode ? null : Border.all(color: AppColors.border),
        boxShadow: widget.isCinemaMode
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Material(
          color: Colors.black,
          child: InkWell(
            onTap: () {
              if (canPlayInline) {
                setState(() => _isPlayingInline = true);
              } else {
                _openExternal(context);
              }
            },
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Poster Thumbnail
                  if (thumb != null)
                    Image.network(
                      thumb,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _buildFallbackBackground(),
                    )
                  else
                    _buildFallbackBackground(),

                  // Lớp phủ tối điện ảnh
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.35),
                          Colors.black.withValues(alpha: 0.15),
                          Colors.black.withValues(alpha: 0.8),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),

                  // Nút Play Cinema
                  Center(
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE11D48),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                          BoxShadow(
                            color: const Color(0xFFE11D48).withValues(alpha: 0.4),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                    ),
                  ),

                  // Header Badges
                  Positioned(
                    top: 12,
                    left: 14,
                    right: 14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE11D48),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.play_arrow_rounded,
                                size: 12,
                                color: Colors.white,
                              ),
                              SizedBox(width: 3),
                              Text(
                                'VIDEO BÀI GIẢNG',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${widget.estimatedMinutes} phút',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom info banner
                  Positioned(
                    bottom: 12,
                    left: 14,
                    right: 14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            canPlayInline
                                ? 'Chạm để phát video ngay trên màn hình'
                                : (hasValidUrl
                                    ? 'Chạm để mở trên ứng dụng YouTube'
                                    : 'Bài giảng lý thuyết'),
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (canPlayInline)
                          const Text(
                            'Inline HD',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackBackground() {
    return Container(
      color: const Color(0xFF0F172A),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.ondemand_video_rounded,
              size: 40,
              color: Colors.white38,
            ),
            const SizedBox(height: 6),
            Text(
              widget.title ?? 'Video bài giảng',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
