import 'package:flutter/material.dart';
import 'widgets/post_field.dart';
import 'widgets/post_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum APP'),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostField(
              hintText: 'what do you want to ask?',
              controller: _postController,
            ),
            // const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
              ),
              onPressed: () {},
              child: const Text('Post'),
            ),
            const SizedBox(height: 30),
            Text('Posts'),
            const SizedBox(height: 20),
            PosttData(),
          ],
        ),
      ),
    );
  }
}
