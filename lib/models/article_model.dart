class ApiResultModel {
  String category;
  bool success;
  List<ArticleModel> articles = [];

  ApiResultModel(
    this.category,
    this.success,
    this.articles,
  );

  factory ApiResultModel.fromJson(Map<String, dynamic> json) {
    final category = json['category'];
    final success = json['success'];

    final List<ArticleModel> articles = [];
    if(success) {
      if (json['data'] != null) {
        json['data'].forEach((v) {
          articles.add(ArticleModel.fromJson(v));
        });
      }
    }

    return ApiResultModel(category, success, articles);
  }
}

class ArticleModel {
  String id;
  String author;
  String title;
  String url;
  String imageUrl;
  String date;
  String content;
  String readMoreUrl;
  String time;

  ArticleModel(
    this.id,
    this.author,
    this.title,
    this.url,
    this.imageUrl,
    this.date,
    this.content,
    this.readMoreUrl,
    this.time,
  );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] ?? '';
    final author = json['author'] ?? '';
    final title = json['title'] ?? '';
    final url = json['url'] ?? '';
    final imageUrl = json['imageUrl'] ?? '';
    final date = json['date'] ?? '';
    final content = json['content'] ?? '';
    final readMoreUrl = json['readMoreUrl'] ?? '';
    final time = json['time'] ?? '';

    return ArticleModel(id, author, title, url, imageUrl, date,
        content, readMoreUrl, time);
  }
}
