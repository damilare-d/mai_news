import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HackerNewsPage extends StatefulWidget {
  @override
  _HackerNewsPageState createState() => _HackerNewsPageState();
}

class _HackerNewsPageState extends State<HackerNewsPage> {
  List<dynamic> _stories = [];

  @override
  void initState() {
    super.initState();
    _fetchTopStories();
  }

  void _fetchTopStories() async {
    final response = await http.get(Uri.parse(
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty'));
    if (response.statusCode == 200) {
      final List<dynamic> storyIds = jsonDecode(response.body);
      final List<dynamic> stories = [];
      for (var i = 0; i < 10; i++) {
        final storyResponse = await http.get(Uri.parse(
            'https://hacker-news.firebaseio.com/v0/item/${storyIds[i]}.json?print=pretty'));
        if (storyResponse.statusCode == 200) {
          stories.add(jsonDecode(storyResponse.body));
        }
      }
      setState(() {
        _stories = stories;
      });
    } else {
      throw Exception('Failed to load top stories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News'),
      ),
      body: ListView.builder(
        itemCount: _stories.length,
        itemBuilder: (context, index) {
          final story = _stories[index];
          return ListTile(
            title: Text(story['title']),
            subtitle: Text(story['by']),
            onTap: () {
              Navigator.pushNamed(context, '/story', arguments: story);
            },
          );
        },
      ),
    );
  }
}
