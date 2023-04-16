import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/article_model.dart';

abstract class NewsRepository {
  Future<List<ArticleModel>> fetchNews();

  Future<List<ArticleModel>> searchNews(String query);
}

class NewsRepositoryImpls implements NewsRepository {
  @override
  Future<List<ArticleModel>> fetchNews() async {
    var response = await http.get(
      Uri.parse(
        "https://inshorts.deta.dev/news?category=all",
      ),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<ArticleModel> articles = ApiResultModel.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<ArticleModel>> searchNews(query) async {
    var response = await http.get(
      Uri.parse(
        "https://inshorts.deta.dev/news?category=$query",
      ),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<ArticleModel> articles = ApiResultModel.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }
  }
}
