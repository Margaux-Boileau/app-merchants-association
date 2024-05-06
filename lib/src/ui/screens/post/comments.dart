import 'package:app_merchants_association/src/api/api_client.dart';
import 'package:app_merchants_association/src/ui/widgets/card/comments_card.dart';
import 'package:flutter/material.dart';
import '../../../model/comment.dart';
import '../../../model/forums.dart';
import '../../../model/post.dart';
import '../../widgets/textField/comment_text_field.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key, required this.post, required this.forum});

  final Forums forum;
  final Post post;


  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  List<Comment> commentsList = [];

  getComments() async {
    try {
      var response = await ApiClient()
          .getComments(forumId: widget.forum.id, postId: widget.post.id, page: currentPage);
      commentsList = response!.map((json) => Comment.fromJson(json)).toList();
      commentsList = commentsList.reversed.toList();
      setState(() {});
    } catch (e) {
      print(".: Error at load comments $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreComments();
      }
    });

    getComments();
  }

  Future<void> _getMoreComments() async {
    print("GETTING MORE COMMENTS");
    if (widget.post.id != null) {
      currentPage++;
      List<dynamic>? response = await ApiClient().getComments(forumId: widget.forum.id, postId: widget.post.id, page: currentPage);
      if (response != null) {
        List<Comment> newComments = response.map((item) => Comment.fromJson(item)).toList();
        setState(() {
          commentsList.addAll(newComments);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comentarios"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,

                itemCount: commentsList.length,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: CommentCard(
                        comment: commentsList[index],
                        post: widget.post,
                        forum: widget.forum),
                  );
                }),
          ),
          CommentTextField(
            forum: widget.forum,
            post: widget.post,
            updateScreen: getComments,
          ),
        ],
      ),
    );
  }
}
