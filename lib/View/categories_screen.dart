import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/View/home_screen.dart';
import 'package:news_app/View_Model/news_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MM DD ,YYYY');
  String categryName = 'general';

  List<String> CategoriesList = [
    'General',
    'Sports',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
