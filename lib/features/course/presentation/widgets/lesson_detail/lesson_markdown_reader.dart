import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:rental_car/core/theme/app_colors.dart';

class LessonMarkdownReader extends StatelessWidget {
  const LessonMarkdownReader({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    if (content.trim().isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        alignment: Alignment.center,
        child: const Text(
          'Nội dung bài học đang được cập nhật...',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textMuted,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return MarkdownBody(
      data: content,
      selectable: true,
      builders: {
        'code': CodeBlockBuilder(),
      },
      styleSheet: MarkdownStyleSheet(
        h1: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w900,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
          height: 1.4,
        ),
        h2: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w900,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
          height: 1.4,
        ),
        h3: const TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w800,
          color: AppColors.textDark,
          height: 1.35,
        ),
        p: const TextStyle(
          fontSize: 13,
          color: AppColors.textSecondaryDark,
          height: 1.65,
        ),
        code: const TextStyle(
          fontSize: 11.5,
          fontFamily: 'monospace',
          color: AppColors.primary,
        ),
        blockquote: const TextStyle(
          fontSize: 12.5,
          fontStyle: FontStyle.italic,
          color: AppColors.textDark,
          height: 1.5,
        ),
        blockquotePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        blockquoteDecoration: const BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          border: Border(left: BorderSide(color: AppColors.primary, width: 4)),
        ),
        tableBorder: TableBorder.all(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(12),
        ),
        tableHead: const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
        tableBody: const TextStyle(fontSize: 11.5, color: AppColors.textSecondaryDark),
      ),
    );
  }
}

/// Custom Markdown Builder phân tách và xử lý khối code chuyên nghiệp
class CodeBlockBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfterWithContext(
    BuildContext context,
    md.Element element,
    TextStyle? preferredStyle,
    TextStyle? parentStyle,
  ) {
    final text = element.textContent;
    final className = element.attributes['class'] ?? '';
    final isBlock = className.startsWith('language-') || text.contains('\n');

    if (isBlock) {
      String language = 'CODE';
      if (className.startsWith('language-')) {
        language = className.replaceFirst('language-', '').toUpperCase();
      }
      return ModernCodeBlockWidget(
        code: text.trimRight(),
        language: language,
      );
    }

    // Inline code pill tự nhiên, không bị vỡ layout
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11.5,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

/// Widget hiển thị khối Code phong cách IDE macOS / VS Code
class ModernCodeBlockWidget extends StatefulWidget {
  const ModernCodeBlockWidget({
    super.key,
    required this.code,
    required this.language,
  });

  final String code;
  final String language;

  @override
  State<ModernCodeBlockWidget> createState() => _ModernCodeBlockWidgetState();
}

class _ModernCodeBlockWidgetState extends State<ModernCodeBlockWidget> {
  bool _copied = false;
  Timer? _copyTimer;

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: widget.code));
    _copyTimer?.cancel();
    setState(() => _copied = true);
    _copyTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  void dispose() {
    _copyTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lines = widget.code.split('\n');
    final lineCount = lines.length;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A), // Dark slate IDE background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E293B)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Mac-style Top Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF1E293B),
              border: Border(
                bottom: BorderSide(color: Color(0xFF334155), width: 0.8),
              ),
            ),
            child: Row(
              children: [
                // 3 Mac window control dots
                Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle)),
                    const SizedBox(width: 5),
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFF59E0B), shape: BoxShape.circle)),
                    const SizedBox(width: 5),
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)),
                  ],
                ),
                const SizedBox(width: 10),
                // Language Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFF334155)),
                  ),
                  child: Text(
                    widget.language,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF38BDF8),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Spacer(),
                // Copy Button with tactile feedback
                InkWell(
                  onTap: _copyCode,
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _copied ? const Color(0xFF10B981) : const Color(0xFF334155),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _copied ? Icons.check_rounded : Icons.copy_rounded,
                          size: 12,
                          color: _copied ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _copied ? 'Đã chép' : 'Sao chép',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: _copied ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Code Body with Line Numbers & Horizontal Scroll
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Line Numbers Gutter
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0B1120),
                    border: Border(
                      right: BorderSide(color: Color(0xFF1E293B), width: 1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(
                      lineCount,
                      (index) => Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          height: 1.5,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ),
                  ),
                ),

                // Horizontally Scrollable Formatted Code
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    child: _buildSyntaxHighlightedText(widget.code),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Lightweight syntax highlighter (zero external dependencies)
  Widget _buildSyntaxHighlightedText(String code) {
    // Regex matching comments, strings, preprocessors, keywords, numbers
    final regex = RegExp(
      r'(//.*?$|/\*[\s\S]*?\*/|--.*?$|#.*?$)|("(?:\\.|[^"\\])*"|\x27(?:\\.|[^\x27\\])*\x27)|(@\w+|#\w+)|(\b(?:int|void|float|double|char|bool|boolean|return|if|else|for|while|do|switch|case|break|continue|default|struct|class|public|private|protected|static|final|new|this|super|package|import|include|try|catch|finally|throw|throws|extends|implements|interface|SELECT|FROM|WHERE|JOIN|LEFT|RIGHT|INNER|GROUP|BY|ORDER|HAVING|INSERT|INTO|UPDATE|SET|DELETE|CREATE|TABLE|DROP|ALTER|PRIMARY|KEY|FOREIGN|REFERENCES|NOT|NULL|AND|OR|AS|IN|def|from|lambda|elif|True|False|None)\b)|(\b\d+(?:\.\d+)?\b)',
      multiLine: true,
    );

    final List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final match in regex.allMatches(code)) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: code.substring(lastIndex, match.start),
          style: const TextStyle(color: Color(0xFFE2E8F0)),
        ));
      }

      final text = match.group(0)!;
      if (match.group(1) != null) {
        // Comment
        spans.add(TextSpan(
          text: text,
          style: const TextStyle(color: Color(0xFF64748B), fontStyle: FontStyle.italic),
        ));
      } else if (match.group(2) != null) {
        // String
        spans.add(TextSpan(
          text: text,
          style: const TextStyle(color: Color(0xFF4ADE80)),
        ));
      } else if (match.group(3) != null) {
        // Preprocessor / Annotation
        spans.add(TextSpan(
          text: text,
          style: const TextStyle(color: Color(0xFFC084FC), fontWeight: FontWeight.w600),
        ));
      } else if (match.group(4) != null) {
        // Keyword
        spans.add(TextSpan(
          text: text,
          style: const TextStyle(color: Color(0xFF38BDF8), fontWeight: FontWeight.w600),
        ));
      } else if (match.group(5) != null) {
        // Number
        spans.add(TextSpan(
          text: text,
          style: const TextStyle(color: Color(0xFFFB923C)),
        ));
      }

      lastIndex = match.end;
    }

    if (lastIndex < code.length) {
      spans.add(TextSpan(
        text: code.substring(lastIndex),
        style: const TextStyle(color: Color(0xFFE2E8F0)),
      ));
    }

    return SelectableText.rich(
      TextSpan(
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          height: 1.5,
          color: Color(0xFFE2E8F0),
        ),
        children: spans.isEmpty
            ? [TextSpan(text: code, style: const TextStyle(color: Color(0xFFE2E8F0)))]
            : spans,
      ),
    );
  }
}
