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
  List<Comment> commentsList = [];

  getComments() async {
    try {
      var response = await ApiClient()
          .getComments(forumId: widget.forum.id, postId: widget.post.id);
      commentsList = response!.map((json) => Comment.fromJson(json)).toList();
      commentsList = commentsList.reversed.toList();
      setState(() {});
    } catch (e) {
      print(".: Error at load comments $e");
    }
  }

  @override
  void initState() {
    getComments();
    super.initState();
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
