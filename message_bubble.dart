import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import '../models/message.dart';
import '../screens/image_viewer_screen.dart';
import '../screens/video_player_screen.dart';
import '../theme/app_colors.dart';
import '../utils/date_formatter.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  Color _bubbleColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (message.isMe) {
      return isDark ? AppColors.darkBubbleMe : AppColors.lightBubbleMe;
    }
    return isDark ? AppColors.darkBubbleOther : AppColors.lightBubbleOther;
  }

  Widget _statusTicks() {
    if (!message.isMe) return const SizedBox.shrink();
    IconData icon;
    Color color;
    switch (message.status) {
      case MessageStatus.sending:
        icon = Icons.access_time;
        color = Colors.black45;
        break;
      case MessageStatus.sent:
        icon = Icons.done;
        color = Colors.black45;
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        color = Colors.black45;
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = AppColors.blueTick;
        break;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Icon(icon, size: 15, color: color),
    );
  }

  Widget _metaRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormatter.bubbleTime(message.timestamp),
            style: const TextStyle(fontSize: 11, color: Colors.black45),
          ),
          _statusTicks(),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (message.type) {
      case MessageType.text:
        return Text(message.text ?? '', style: const TextStyle(fontSize: 15.5));

      case MessageType.image:
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ImageViewerScreen(filePath: message.filePath!),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              File(message.filePath!),
              width: 220,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 220,
                height: 220,
                color: Colors.grey.shade300,
                child: const Icon(Icons.broken_image),
              ),
            ),
          ),
        );

      case MessageType.video:
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VideoPlayerScreen(filePath: message.filePath!),
              ),
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.movie, color: Colors.white38, size: 50),
              ),
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow,
                    color: Colors.white, size: 32),
              ),
            ],
          ),
        );

      case MessageType.document:
        final ext = (message.fileName ?? '').split('.').last.toUpperCase();
        return GestureDetector(
          onTap: () => OpenFilex.open(message.filePath!),
          child: Container(
            width: 230,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.tealGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    ext.length > 4 ? 'FILE' : ext,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.fileName ?? 'Dokumen',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13.5, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        DateFormatter.fileSize(message.fileSizeBytes ?? 0),
                        style:
                            const TextStyle(fontSize: 11.5, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final align =
        message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = message.isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        padding: EdgeInsets.symmetric(
          horizontal: message.type == MessageType.text ? 10 : 6,
          vertical: message.type == MessageType.text ? 8 : 6,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: _bubbleColor(context),
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: align,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildContent(context),
            _metaRow(context),
          ],
        ),
      ),
    );
  }
}
