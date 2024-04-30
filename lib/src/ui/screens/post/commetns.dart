import 'package:app_merchants_association/src/ui/widgets/card/comments_card.dart';
import 'package:flutter/material.dart';
import '../../../model/comment.dart';
import '../../../model/forums.dart';
import '../../../model/post.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key, required this.post, required this.forum});

  final Forums forum;
  final Post post;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {

  List<Comment> commentsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comentarios"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: commentsList.length,
        itemBuilder: (BuildContext context, int index) {
          return CommentCard(comment: commentsList[index], post: widget.post, forum: widget.forum);
        }
      ),
    );
  }
}
