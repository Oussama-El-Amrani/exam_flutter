import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'conversation_event.dart';
import 'conversation_state.dart';
import '../models/conversation.dart';
import '../models/message.dart';
import '../services/mock_data.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(const ConversationInitial()) {
    on<LoadConversations>(_onLoadConversations);
    on<SendMessage>(_onSendMessage);
    on<ReceiveMessage>(_onReceiveMessage);
    on<SelectConversation>(_onSelectConversation);
    on<CreateNewConversation>(_onCreateNewConversation);
    on<MarkConversationAsRead>(_onMarkConversationAsRead);
  }

  Future<void> _onLoadConversations(
    LoadConversations event,
    Emitter<ConversationState> emit,
  ) async {
    emit(const ConversationLoading());
    
    try {
      // Simuler un délai de chargement
      await Future.delayed(const Duration(milliseconds: 500));
      
      final conversations = MockData.getMockConversations();
      final messages = MockData.getMockMessages();
      
      emit(ConversationLoaded(
        conversations: conversations,
        messages: messages,
      ));
    } catch (e) {
      emit(ConversationError(message: 'Erreur lors du chargement: $e'));
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ConversationState> emit,
  ) async {
    if (state is ConversationLoaded) {
      final currentState = state as ConversationLoaded;
      
      // Créer le nouveau message
      final newMessage = Message(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: event.conversationId,
        content: event.content,
        isMe: true,
        timestamp: DateTime.now(),
      );
      
      // Mettre à jour les messages
      final updatedMessages = Map<String, List<Message>>.from(currentState.messages);
      final conversationMessages = List<Message>.from(
        updatedMessages[event.conversationId] ?? [],
      );
      conversationMessages.add(newMessage);
      updatedMessages[event.conversationId] = conversationMessages;
      
      // Mettre à jour la conversation avec le dernier message
      final updatedConversations = currentState.conversations.map((conv) {
        if (conv.id == event.conversationId) {
          return conv.copyWith(
            lastMessage: event.content,
            timestamp: DateTime.now(),
          );
        }
        return conv;
      }).toList();
      
      emit(currentState.copyWith(
        conversations: updatedConversations,
        messages: updatedMessages,
      ));
      
      // Simuler une réponse automatique après 2 secondes
      _simulateAutoReply(event.conversationId);
    }
  }

  Future<void> _onReceiveMessage(
    ReceiveMessage event,
    Emitter<ConversationState> emit,
  ) async {
    if (state is ConversationLoaded) {
      final currentState = state as ConversationLoaded;
      
      // Mettre à jour les messages
      final updatedMessages = Map<String, List<Message>>.from(currentState.messages);
      final conversationMessages = List<Message>.from(
        updatedMessages[event.message.conversationId] ?? [],
      );
      conversationMessages.add(event.message);
      updatedMessages[event.message.conversationId] = conversationMessages;
      
      // Mettre à jour la conversation
      final updatedConversations = currentState.conversations.map((conv) {
        if (conv.id == event.message.conversationId) {
          final newUnreadCount = conv.id == currentState.selectedConversationId 
              ? conv.unreadCount 
              : conv.unreadCount + 1;
          
          return conv.copyWith(
            lastMessage: event.message.content,
            timestamp: event.message.timestamp,
            unreadCount: newUnreadCount,
          );
        }
        return conv;
      }).toList();
      
      emit(currentState.copyWith(
        conversations: updatedConversations,
        messages: updatedMessages,
      ));
    }
  }

  Future<void> _onSelectConversation(
    SelectConversation event,
    Emitter<ConversationState> emit,
  ) async {
    if (state is ConversationLoaded) {
      final currentState = state as ConversationLoaded;
      
      emit(currentState.copyWith(
        selectedConversationId: event.conversationId,
      ));
      
      // Marquer la conversation comme lue
      add(MarkConversationAsRead(conversationId: event.conversationId));
    }
  }

  Future<void> _onCreateNewConversation(
    CreateNewConversation event,
    Emitter<ConversationState> emit,
  ) async {
    if (state is ConversationLoaded) {
      final currentState = state as ConversationLoaded;
      
      final newConversation = Conversation(
        id: 'conv_${DateTime.now().millisecondsSinceEpoch}',
        contactName: event.contactName,
        lastMessage: 'Nouvelle conversation',
        timestamp: DateTime.now(),
        unreadCount: 0,
        avatarUrl: 'https://i.pravatar.cc/150?img=${currentState.conversations.length + 1}',
      );
      
      final updatedConversations = [newConversation, ...currentState.conversations];
      final updatedMessages = Map<String, List<Message>>.from(currentState.messages);
      updatedMessages[newConversation.id] = [];
      
      emit(currentState.copyWith(
        conversations: updatedConversations,
        messages: updatedMessages,
        selectedConversationId: newConversation.id,
      ));
    }
  }

  Future<void> _onMarkConversationAsRead(
    MarkConversationAsRead event,
    Emitter<ConversationState> emit,
  ) async {
    if (state is ConversationLoaded) {
      final currentState = state as ConversationLoaded;
      
      final updatedConversations = currentState.conversations.map((conv) {
        if (conv.id == event.conversationId) {
          return conv.copyWith(unreadCount: 0);
        }
        return conv;
      }).toList();
      
      emit(currentState.copyWith(conversations: updatedConversations));
    }
  }

  void _simulateAutoReply(String conversationId) {
    Timer(const Duration(seconds: 2), () {
      final responses = [
        'Merci pour ton message !',
        'Je vais y réfléchir',
        'Bonne idée !',
        'D\'accord avec toi',
        'On en reparle bientôt',
      ];
      
      final randomResponse = responses[DateTime.now().millisecond % responses.length];
      
      final autoReply = Message(
        id: 'auto_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: conversationId,
        content: randomResponse,
        isMe: false,
        timestamp: DateTime.now(),
      );
      
      add(ReceiveMessage(message: autoReply));
    });
  }
}
