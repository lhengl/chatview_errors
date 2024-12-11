import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';

/// This page demonstrates the following errors:
/// 1. Setting state of the parent widget dismounts [ChatListWidget] which disposes scroll controller prematurely.
///
/// 2. Loading chat view with a large initial/existing list in the controller causes UI stutter
///    This exposes the poor performance of column widget used. Suggest moving to ListView.builder.
///
/// To replicate, simply tap "loading" or "hasMessages" to change states
class ScrollControllerError extends StatefulWidget {
  const ScrollControllerError({super.key});

  @override
  State<ScrollControllerError> createState() => _ScrollControllerErrorState();
}

class _ScrollControllerErrorState extends State<ScrollControllerError> {
  late final ChatController chatController;

  ChatViewState chatState = ChatViewState.hasMessages;

  @override
  void initState() {
    super.initState();
    final initialMessageList = List.generate(
      100,
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
