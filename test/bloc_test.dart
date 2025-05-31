import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:exam_flutter/bloc/conversation_bloc.dart';
import 'package:exam_flutter/bloc/conversation_event.dart';
import 'package:exam_flutter/bloc/conversation_state.dart';

void main() {
  group('ConversationBloc', () {
    late ConversationBloc conversationBloc;

    setUp(() {
      conversationBloc = ConversationBloc();
    });

    tearDown(() {
      conversationBloc.close();
    });

    test('initial state is ConversationInitial', () {
      expect(conversationBloc.state, equals(const ConversationInitial()));
    });

    blocTest<ConversationBloc, ConversationState>(
      'emits [ConversationLoading, ConversationLoaded] when LoadConversations is added',
      build: () => conversationBloc,
      act: (bloc) => bloc.add(const LoadConversations()),
      wait: const Duration(milliseconds: 600),
      expect: () => [const ConversationLoading(), isA<ConversationLoaded>()],
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits updated state when SendMessage is added',
      build: () => conversationBloc,
      seed: () => const ConversationLoaded(conversations: [], messages: {}),
      act:
          (bloc) => bloc.add(
            const SendMessage(conversationId: '1', content: 'Test message'),
          ),
      expect: () => [isA<ConversationLoaded>()],
    );
  });
}
