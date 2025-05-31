import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/conversation.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const ConversationTile({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[300],
            child:
                conversation.avatarUrl.isNotEmpty
                    ? ClipOval(
                      child: Image.network(
                        conversation.avatarUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Text(
                            conversation.contactName.isNotEmpty
                                ? conversation.contactName[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    )
                    : Text(
                      conversation.contactName.isNotEmpty
                          ? conversation.contactName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
          ),
          if (conversation.unreadCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                child: Text(
                  conversation.unreadCount > 99
                      ? '99+'
                      : conversation.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      title: Text(
        conversation.contactName,
        style: TextStyle(
          fontWeight:
              conversation.unreadCount > 0
                  ? FontWeight.bold
                  : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        conversation.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color:
              conversation.unreadCount > 0 ? Colors.black87 : Colors.grey[600],
          fontWeight:
              conversation.unreadCount > 0
                  ? FontWeight.w500
                  : FontWeight.normal,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _formatTimestamp(conversation.timestamp),
            style: TextStyle(
              color:
                  conversation.unreadCount > 0
                      ? Theme.of(context).primaryColor
                      : Colors.grey[600],
              fontSize: 12,
              fontWeight:
                  conversation.unreadCount > 0
                      ? FontWeight.bold
                      : FontWeight.normal,
            ),
          ),
          if (conversation.unreadCount > 0) const SizedBox(height: 4),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    try {
      if (difference.inDays == 0) {
        // Aujourd'hui - afficher l'heure
        return DateFormat('HH:mm').format(timestamp);
      } else if (difference.inDays == 1) {
        // Hier
        return 'Hier';
      } else if (difference.inDays < 7) {
        // Cette semaine - afficher le jour
        try {
          return DateFormat('EEEE', 'fr_FR').format(timestamp);
        } catch (e) {
          // Fallback si la localisation française n'est pas disponible
          return DateFormat('EEEE').format(timestamp);
        }
      } else {
        // Plus ancien - afficher la date
        return DateFormat('dd/MM/yy').format(timestamp);
      }
    } catch (e) {
      // Fallback en cas d'erreur de formatage
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }
}
