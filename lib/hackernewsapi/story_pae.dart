import 'package:flutter/material.dart';

class StoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final story =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    if (story != null) {
      String title = story['title'];
      String author = story['by'];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(story['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              story['url'],
              style: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(story['url']),
          ],
        ),
      ),
    );
  }
}
