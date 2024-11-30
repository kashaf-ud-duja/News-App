

import 'package:http/http.dart';
import 'package:news_app/Models/news_channels_headlines_model.dart';
import 'package:news_app/Repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();


  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesAPI() async{
final response = await _repo.fetchNewsChannelHeadlinesAPI();
return response;
  }
}