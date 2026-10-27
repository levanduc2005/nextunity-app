import 'package:flutter/material.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';

/// Extension định nghĩa giao diện (nhãn, emoji, màu sắc) ở tầng Presentation cho các loại reaction
extension ReactionTypeUiX on ReactionType {
  String get label => switch (this) {
    ReactionType.like => 'Thích',
    ReactionType.love => 'Yêu thích',
    ReactionType.haha => 'Haha',
    ReactionType.wow => 'Wow',
    ReactionType.sad => 'Buồn',
    ReactionType.angry => 'Phẫn nộ',
  };

  String get emoji => switch (this) {
    ReactionType.like => '👍',
    ReactionType.love => '❤️',
    ReactionType.haha => '😆',
    ReactionType.wow => '😮',
    ReactionType.sad => '😢',
    ReactionType.angry => '😡',
  };

  Color get color => switch (this) {
    ReactionType.like => const Color(0xFF1877F2),
    ReactionType.love => const Color(0xFFFA3E3E),
    ReactionType.haha => const Color(0xFFF7B125),
    ReactionType.wow => const Color(0xFFF7B125),
    ReactionType.sad => const Color(0xFFF7B125),
    ReactionType.angry => const Color(0xFFE25026),
  };
}
