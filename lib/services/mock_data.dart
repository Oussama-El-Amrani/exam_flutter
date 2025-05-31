import '../models/conversation.dart';
import '../models/message.dart';

class MockData {
  static List<Conversation> getMockConversations() {
    final now = DateTime.now();
    
    return [
      Conversation(
        id: '1',
        contactName: 'Sara EL Amrani',
        lastMessage: 'Salut ! Comment ça va ?',
        timestamp: now.subtract(const Duration(minutes: 5)),
        unreadCount: 2,
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
      ),
      Conversation(
        id: '2',
        contactName: 'Mehdi EL Amrani',
        lastMessage: 'On se voit demain ?',
        timestamp: now.subtract(const Duration(hours: 1)),
        unreadCount: 0,
        avatarUrl: 'https://i.pravatar.cc/150?img=2',
      ),
      Conversation(
        id: '3',
        contactName: 'Zineb EL Amrani',
        lastMessage: 'Merci pour ton aide !',
        timestamp: now.subtract(const Duration(hours: 3)),
        unreadCount: 1,
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
      ),
      Conversation(
        id: '4',
        contactName: 'Ayman Benani',
        lastMessage: 'À bientôt 👋',
        timestamp: now.subtract(const Duration(days: 1)),
        unreadCount: 0,
        avatarUrl: 'https://i.pravatar.cc/150?img=4',
      ),
      Conversation(
        id: '5',
        contactName: 'Mountasir jr',
        lastMessage: 'Super idée !',
        timestamp: now.subtract(const Duration(days: 2)),
        unreadCount: 3,
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
      ),
    ];
  }

  static Map<String, List<Message>> getMockMessages() {
    final now = DateTime.now();
    
    return {
      '1': [
        Message(
          id: 'm1',
          conversationId: '1',
          content: 'Salut Sara ! Ça va très bien et toi ?',
          isMe: true,
          timestamp: now.subtract(const Duration(minutes: 10)),
        ),
        Message(
          id: 'm2',
          conversationId: '1',
          content: 'Salut ! Comment ça va ?',
          isMe: false,
          timestamp: now.subtract(const Duration(minutes: 5)),
        ),
        Message(
          id: 'm3',
          conversationId: '1',
          content: 'Tu es libre ce weekend ?',
          isMe: false,
          timestamp: now.subtract(const Duration(minutes: 4)),
        ),
      ],
      '2': [
        Message(
          id: 'm4',
          conversationId: '2',
          content: 'Salut Mehdi !',
          isMe: true,
          timestamp: now.subtract(const Duration(hours: 2)),
        ),
        Message(
          id: 'm5',
          conversationId: '2',
          content: 'On se voit demain ?',
          isMe: false,
          timestamp: now.subtract(const Duration(hours: 1)),
        ),
      ],
      '3': [
        Message(
          id: 'm6',
          conversationId: '3',
          content: 'De rien, c\'était avec plaisir !',
          isMe: true,
          timestamp: now.subtract(const Duration(hours: 4)),
        ),
        Message(
          id: 'm7',
          conversationId: '3',
          content: 'Merci pour ton aide !',
          isMe: false,
          timestamp: now.subtract(const Duration(hours: 3)),
        ),
      ],
      '4': [
        Message(
          id: 'm8',
          conversationId: '4',
          content: 'À bientôt Mohamed !',
          isMe: true,
          timestamp: now.subtract(const Duration(days: 1, hours: 1)),
        ),
        Message(
          id: 'm9',
          conversationId: '4',
          content: 'À bientôt 👋',
          isMe: false,
          timestamp: now.subtract(const Duration(days: 1)),
        ),
      ],
      '5': [
        Message(
          id: 'm10',
          conversationId: '5',
          content: 'J\'ai une proposition à te faire',
          isMe: true,
          timestamp: now.subtract(const Duration(days: 2, hours: 1)),
        ),
        Message(
          id: 'm11',
          conversationId: '5',
          content: 'Super idée !',
          isMe: false,
          timestamp: now.subtract(const Duration(days: 2)),
        ),
        Message(
          id: 'm12',
          conversationId: '5',
          content: 'On en parle bientôt ?',
          isMe: false,
          timestamp: now.subtract(const Duration(days: 2)),
        ),
        Message(
          id: 'm13',
          conversationId: '5',
          content: 'Dis-moi quand tu es libre',
          isMe: false,
          timestamp: now.subtract(const Duration(days: 2)),
        ),
      ],
    };
  }
}
