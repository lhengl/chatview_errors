import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';

/// Loading chat view with list causes slight UI stutter
class InitialMessagesLag extends StatefulWidget {
  const InitialMessagesLag({super.key});

  @override
  State<InitialMessagesLag> createState() => _InitialMessagesLagState();
}

class _InitialMessagesLagState extends State<InitialMessagesLag> {
  late final ChatController chatController;

  ChatViewState chatState = ChatViewState.hasMessages;

  @override
  void initState() {
    super.initState();
    final initialMessageList = List.generate(
      20,
      (index) => Message(message: 'message_$index', createdAt: DateTime.now(), sentBy: 'userA'),
    );
    chatController = ChatController(
      initialMessageList: initialMessageList,
      scrollController: ScrollController(),
      otherUsers: [],
      currentUser: ChatUser(id: 'userA', name: 'userA'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScrollController Error'),
      ),
      body: ChatView(
        chatController: chatController,
        chatViewState: chatState,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    chatState = ChatViewState.loading;
                  });
                },
                child: const Text('loading'),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    chatState = ChatViewState.hasMessages;
                  });
                },
                child: const Text('hasMessages'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
