enum MessageType { text, image, video, document }

enum MessageStatus { sending, sent, delivered, read }

class ChatMessage {
  final String id;
  final String chatId;
  final MessageType type;
  final bool isMe;
  final DateTime timestamp;
  MessageStatus status;

  /// Untuk pesan teks
  final String? text;

  /// Untuk pesan foto / video / dokumen
  final String? filePath;
  final String? fileName;
  final int? fileSizeBytes;

  /// Durasi video dalam detik (opsional, diisi setelah video dimuat)
  int? videoDurationSeconds;

  ChatMessage({
    required this.id,
    required this.chatId,
    required this.type,
    required this.isMe,
    required this.timestamp,
    this.status = MessageStatus.sending,
    this.text,
    this.filePath,
    this.fileName,
    this.fileSizeBytes,
    this.videoDurationSeconds,
  });

  factory ChatMessage.text({
    required String chatId,
    required String text,
    required bool isMe,
  }) {
    return ChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      chatId: chatId,
      type: MessageType.text,
      isMe: isMe,
      timestamp: DateTime.now(),
      text: text,
    );
  }

  factory ChatMessage.attachment({
    required String chatId,
    required MessageType type,
    required String filePath,
    required String fileName,
    required int fileSizeBytes,
    required bool isMe,
    String? caption,
  }) {
    return ChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      chatId: chatId,
      type: type,
      isMe: isMe,
      timestamp: DateTime.now(),
      filePath: filePath,
      fileName: fileName,
      fileSizeBytes: fileSizeBytes,
      text: caption,
    );
  }
}
