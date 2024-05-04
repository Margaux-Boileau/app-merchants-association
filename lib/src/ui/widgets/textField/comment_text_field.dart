import 'package:flutter/material.dart';
import '../../../api/api_client.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_styles.dart';
import '../../../model/forums.dart';
import '../../../model/post.dart';

class CommentTextField extends StatefulWidget {
  const CommentTextField({super.key, required this.forum, required this.post, required this.updateScreen});

  final Forums forum;
  final Post post;
  final Function updateScreen;

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15.0,
      shadowColor: AppColors.black,
      child: SizedBox(
        width: double.infinity,
        child: Container(
          constraints: const BoxConstraints(maxHeight: 200),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            reverse: true,
            child: TextField(
              minLines: 1,
              maxLines: null,
              controller: messageController,
              keyboardType: TextInputType.multiline,
              style: AppStyles.textTheme.bodyMedium!.copyWith(
                color: AppColors.black,
              ),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Comentar...",
                hintStyle: AppStyles.textTheme.bodyMedium!.copyWith(
                  color: AppColors.appGrey,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: AppColors.primaryBlue),
                  onPressed: publishComment,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  publishComment() async {
    if (messageController.text.isNotEmpty) {
      bool response = await ApiClient().publishComment(forumId: widget.forum.id,
          postId: widget.post.id,
          content: messageController.text);

      if (response) {
        widget.updateScreen();
        messageController.clear();
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }
    }
  }
}