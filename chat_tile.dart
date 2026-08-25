import 'package:flutter/material.dart';
import '../models/chat.dart';
import '../models/message.dart';
import '../theme/app_colors.dart';
import '../utils/date_formatter.dart';
import 'avatar_circle.dart';

class ChatTile extends StatelessWidget {
  final ChatContact chat;
  final VoidCallback onTap;

  const ChatTile({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subtitleColor =
        isDark ? AppColors.darkSubtitle : AppColors.lightSubtitle;
    final lastMsg = chat.lastMessage;
    final hasUnread = chat.unreadCount > 0;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarCircle(
              initials: chat.initials,
              color: chat.avatarColor,
              showOnlineDot: chat.isOnline,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.5,
                          ),
                        ),
                      ),
                      if (chat.isPinned)
                        Icon(Icons.push_pin,
                            size: 15, color: subtitleColor),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      if (lastMsg != null && lastMsg.isMe)
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Icon(
                            lastMsg.status == MessageStatus.read
                                ? Icons.done_all
                                : Icons.done,
                            size: 16,
                            color: lastMsg.status == MessageStatus.read
                                ? AppColors.blueTick
                                : subtitleColor,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          chat.previewText(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: hasUnread ? null : subtitleColor,
                            fontWeight:
                                hasUnread ? FontWeight.w600 : FontWeight.normal,
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  lastMsg == null
                      ? ''
                      : DateFormatter.chatListTime(lastMsg.timestamp),
                  style: TextStyle(
                    fontSize: 12.5,
                    color: hasUnread ? AppColors.primaryGreen : subtitleColor,
                    fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 6),
                if (hasUnread)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6.5, vertical: 2),
                    decoration: const BoxDecoration(
                      color: AppColors.unreadBadge,
                      shape: BoxShape.circle,
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 20, minHeight: 20),
                    child: Text(
                      '${chat.unreadCount}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
