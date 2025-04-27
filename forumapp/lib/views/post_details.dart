import 'package:flutter/material.dart';
import './widgets/post_data.dart';
import './widgets/input_widget.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  // final PostModel post;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text('Post Details', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          PostData(),
          const SizedBox(
            height: 10,
          ),
              InputWidget(
                obscureText: false,
                hintText: 'Write a comment...',
                controller: _commentController,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                ),
                onPressed: () async {},
                child: const Text('Comment'),
              )
        ],
      ),
    );
  }
}