import 'package:flutter/material.dart';

class NewsDetailScreen extends StatefulWidget {
  String newsTitle, newsImage, newsDate, author, description, content, source;

  NewsDetailScreen({
    Key? key,
    required this.newsTitle,
    required this.newsImage,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
  }): super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsSState();
}

class _NewsSState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
