import 'package:flutter/material.dart';
import 'news_api.dart';

class NewsScreen extends StatefulWidget {
  final String category;

  const NewsScreen({Key key, this.category}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Future<dynamic> _futureNews;

  @override
  void initState() {
    super.initState();
    _futureNews = NewsApi().getNews(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: FutureBuilder(
        future: _futureNews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Use the snapshot data to display news articles
            return ListView.builder(
              itemCount: snapshot.data["articles"].length,
              itemBuilder: (context, index) {
                var article = snapshot.data["articles"][index];
                return ListTile(
                  title: Text(article["title"]),
                  subtitle: Text(article["description"]),
                  onTap: () {
                    // Open the full article in a browser or WebView
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            // Handle errors
            return Text("Failed to load news");
          } else {
            // Show a loading spinner
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
