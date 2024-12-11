import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';

/// Pagination does not get triggered when initial message list is empty or does not fill the view
class PaginationNotLoading extends StatefulWidget {
  const PaginationNotLoading({
    super.key,
    required this.pageSize,
  });
  final int pageSize;

  @override
  State<PaginationNotLoading> createState() => _PaginationNotLoadingState();
}

class _PaginationNotLoadingState extends State<PaginationNotLoading> {
  late final ChatController chatController;

  @override
  void initState() {
    super.initState();
    final initialMessageList = List.generate(
        widget.pageSize, (index) => Message(message: 'message_$index', createdAt: DateTime.now(), sentBy: 'userA'));
    chatController = ChatController(
      initialMessageList: initialMessageList,
      scrollController: ScrollController(),
      otherUsers: [],
      currentUser: ChatUser(id: 'userA', name: 'userA'),
    );
  }

  Future<void> loadMoreData() async {
    final messages = List.generate(
        widget.pageSize, (index) => Message(message: 'message_$index', createdAt: DateTime.now(), sentBy: 'userA'));
    chatController.loadMoreData(messages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination Not Loading'),
      ),
      body: ChatView(
        chatController: chatController,
        chatViewState: ChatViewState.hasMessages,
        isLastPage: false,
        featureActiveConfig: const FeatureActiveConfig(enablePagination: true),
        loadMoreData: loadMoreData,
      ),
    );
  }
}
