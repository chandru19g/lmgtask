import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../../models/article_model.dart';

class DetailPage extends StatelessWidget {
  final ArticleModel article;

  const DetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Daily News",
            style: TextStyle(
              fontSize: 24.0,
              letterSpacing: 1.0,
            ),
          ),
        ),
        elevation: 3.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: article.imageUrl,
              child: Image.network(
                article.imageUrl != ''
                    ? article.imageUrl
                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU",
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              child: Text(
                article.title,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.all(5.0),
              child: Text(
                article.date,
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                article.content,
                style: TextStyle(
                  color: Colors.grey[800],
                  //fontWeight: FontWeight,
                  fontSize: 17,
                ),
              ),
            ),
            article.readMoreUrl != ''
                ? GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 40.0,
                      ),
                      margin: const EdgeInsets.only(
                        bottom: 5.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Text(
                        'Read More',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                    onTap: () async {
                      FlutterWebBrowser.openWebPage(
                        url: article.readMoreUrl,
                        customTabsOptions: const CustomTabsOptions(
                          colorScheme: CustomTabsColorScheme.system,
                          darkColorSchemeParams: CustomTabsColorSchemeParams(
                            toolbarColor: Colors.amber,
                            secondaryToolbarColor: Colors.amber,
                            navigationBarColor: Colors.amber,
                            navigationBarDividerColor: Colors.amber,
                          ),
                          shareState: CustomTabsShareState.on,
                          instantAppsEnabled: true,
                          showTitle: true,
                          urlBarHidingEnabled: true,
                        ),
                      );
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
