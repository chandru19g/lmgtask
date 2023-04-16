import 'package:flutter/material.dart';

import '../../../models/article_model.dart';
import '../../screens/detail_page.dart';

Widget buildNewsList(List<ArticleModel> articles) {
  return articles.isEmpty
      ? const Center(
          child: Text("No results Found"),
        )
      : ListView.builder(
          itemCount: articles.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2.0,
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DetailPage(article: articles[index]);
                    }));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Hero(
                          tag: articles[index].imageUrl,
                          child: Center(
                            child: Image.network(
                              articles[index].imageUrl != ''
                                  ? articles[index].imageUrl
                                  : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          articles[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          bottom: 16.0,
                          top: 4.0,
                          left: 12.0,
                          right: 10.0,
                        ),
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          articles[index].content,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
}


Future validationAlert(BuildContext context, String title, String message) {
  return showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              style: ButtonStyle(
                overlayColor:
                MaterialStateProperty.resolveWith<
                    Color>((
                    Set<MaterialState> states) {
                  if (states
                      .contains(
                      MaterialState.focused)) {
                    return Colors.transparent;
                  }
                  if (states
                      .contains(
                      MaterialState.hovered)) {
                    return Colors.transparent;
                  }
                  if (states
                      .contains(
                      MaterialState.pressed)) {
                    return Colors.transparent;
                  }
                  return Colors
                      .transparent; // Defer to the widget's default.
                }),
              ),
              child: const Text('Ok'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
  );
}