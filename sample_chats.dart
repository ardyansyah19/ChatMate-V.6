import '../models/chat.dart';
import '../models/message.dart';
import '../theme/app_colors.dart';

/// Data awal (dummy) supaya daftar chat tidak kosong saat pertama dibuka.
/// Semua chat ini tetap bisa dipakai kirim teks/foto/video/dokumen sungguhan.
List<ChatContact> buildSampleChats() {
  final now = DateTime.now();

  ChatMessage txt(String chatId, String text, bool isMe, DateTime time,
      {MessageStatus status = MessageStatus.read}) {
    return ChatMessage(
      id: '${chatId}_${time.microsecondsSinceEpoch}',
      chatId: chatId,
      type: MessageType.text,
      isMe: isMe,
      timestamp: time,
      text: text,
      status: status,
    );
  }

  final chats = <ChatContact>[
    ChatContact(
      id: 'bestie',
      name: 'Bestie',
      avatarColor: AppColors.avatarPalette[0],
      isGroup: true,
      isPinned: true,
      messages: [
        txt('bestie', 'Untuk malam ini kita jadi ya', false,
            now.subtract(const Duration(hours: 3))),
      ],
    ),
    ChatContact(
      id: 'joni',
      name: 'Joni Malik',
      avatarColor: AppColors.avatarPalette[1],
      isOnline: true,
      unreadCount: 4,
      messages: [
        txt('joni', 'Stiker', false, now.subtract(const Duration(hours: 5))),
      ],
    ),
    ChatContact(
      id: 'maya',
      name: 'Maya Tiara',
      avatarColor: AppColors.avatarPalette[2],
      messages: [
        txt('maya', 'Mau makan malam? 🍜', false,
            now.subtract(const Duration(hours: 6))),
      ],
    ),
    ChatContact(
      id: 'lillian',
      name: 'Lillian Eka',
      avatarColor: AppColors.avatarPalette[3],
      isOnline: true,
      unreadCount: 2,
      messages: [
        txt('lillian', 'Hai kamu!', false,
            now.subtract(const Duration(hours: 8))),
        txt(
            'lillian',
            'Sudah lama nggak ketemu. Nggak sabar nunggu ketemuan Sabtu besok.',
            false,
            now.subtract(const Duration(hours: 8))),
      ],
    ),
    ChatContact(
      id: 'cristian',
      name: 'Cristian Alvin',
      avatarColor: AppColors.avatarPalette[4],
      messages: [
        txt('cristian', 'kamu mengikuti Saluran SingleCatClub ya 😊', false,
            now.subtract(const Duration(days: 1))),
      ],
    ),
    ChatContact(
      id: 'keluarga',
      name: 'Keluarga Hendrik',
      avatarColor: AppColors.avatarPalette[5],
      isGroup: true,
      messages: [
        txt('keluarga', 'Mama: Apa ini 10 tahun lalu??', false,
            now.subtract(const Duration(days: 1))),
      ],
    ),
  ];

  return chats;
}
