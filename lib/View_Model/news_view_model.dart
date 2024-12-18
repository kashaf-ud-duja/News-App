

import 'package:http/http.dart';
import 'package:news_app/Models/categories_news_model.dart';
import 'package:news_app/Models/news_channels_headlines_model.dart';
import 'package:news_app/Repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();


  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesAPI(String channelName, ) async{
final response = await _repo.fetchNewsChannelHeadlinesApi(channelName);
return response;
  }

Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{
final response = await _repo.fetchCategoriesNewsApi(category);
return response;
  }
}