import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Models/news_channels_headlines_model.dart';


//this class will fetch the data from API's
class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesAPI() async{
    //you need to secure this API key(apiKey=fe86a331cd7b43269acd5d8381cdcc00) because if it got in other hands it will be miss used 
String url = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=fe86a331cd7b43269acd5d8381cdcc00';
final response = await http.get(Uri.parse(url));
if (kDebugMode) {
  print(response.body);
}
if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
return NewsChannelsHeadlinesModel.fromJson(body);
}throw Exception("ERROR");
  }
}