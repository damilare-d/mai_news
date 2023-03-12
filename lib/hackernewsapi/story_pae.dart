import 'package:flutter/material.dart';
import 'dart:async';
import 'hacker_news_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> fetchStoryBody(int storyId) async {
  final response = await http.get(
      Uri.parse('https://hacker-news.firebaseio.com/v0/item/$storyId.json'));
  if (response.statusCode == 200) {
    final story = jsonDecode(response.body);
    return story['text'] ?? '';
    // return the story body or an empty string if it's null
  } else {
    throw Exception('Failed to load story');
  }
}

class StoryScreen extends StatelessWidget {
  final int storyId;

  StoryScreen({required this.storyId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: fetchStoryBody(storyId),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Story'),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(snapshot.data!),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(
              child: Text('Failed to load story body'),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Loading'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News'),
      ),
      body: ListView.builder(
        itemCount: 10, // display the top 10 stories
        itemBuilder: (BuildContext context, int index) {
          final storyId = index + 1; // the ID of the story to display
          return ListTile(
            title: FutureBuilder<String>(
              future: fetchStoryBody(storyId),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!);
                } else {
                  return Text('Loading...');
                }
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoryScreen(storyId: storyId)),
              );
            },
          );
        },
      ),
    );
  }
}
