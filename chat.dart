import 'package:flutter/material.dart';
import 'message.dart';

class ChatContact {
  final String id;
  final String name;
  final Color avatarColor;
  final bool isOnline;
  final bool isGroup;
  bool isPinned;

  final List<ChatMessage> messages;
  int unreadCount;

  ChatContact({
    required this.id,
    required this.name,
    required this.avatarColor,
    this.isOnline = false,
    this.isGroup = false,
    this.isPinned = false,
    List<ChatMessage>? messages,
    this.unreadCount = 0,
  }) : messages = messages ?? [];

  ChatMessage? get lastMessage =>
      messages.isEmpty ? null : messages.last;

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

    String get initials {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

    String get initials {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
  String previewText() {
    final msg = lastMessage;
    if (msg == null) return '';
    switch (msg.type) {
      case MessageType.text:
        return '${msg.isMe ? '' : ''}${msg.text ?? ''}';
      case MessageType.image:
        return '📷 Foto';
      case MessageType.video:
        return '🎥 Video';
      case MessageType.document:
        return '📄 ${msg.fileName ?? 'Dokumen'}';
    }
  }
}
