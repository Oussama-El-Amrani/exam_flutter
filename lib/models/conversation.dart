import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  final String id;
  final String contactName;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final String avatarUrl;

  const Conversation({
    required this.id,
    required this.contactName,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.avatarUrl = '',
  });

  @override
  List<Object?> get props => [
        id,
        contactName,
        lastMessage,
        timestamp,
        unreadCount,
        avatarUrl,
      ];

  Conversation copyWith({
    String? id,
    String? contactName,
    String? lastMessage,
    DateTime? timestamp,
    int? unreadCount,
    String? avatarUrl,
  }) {
    return Conversation(
      id: id ?? this.id,
      contactName: contactName ?? this.contactName,
      lastMessage: lastMessage ?? this.lastMessage,
      timestamp: timestamp ?? this.timestamp,
      unreadCount: unreadCount ?? this.unreadCount,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  String toString() {
    return 'Conversation(id: $id, contactName: $contactName, lastMessage: $lastMessage, timestamp: $timestamp, unreadCount: $unreadCount, avatarUrl: $avatarUrl)';
  }
}
