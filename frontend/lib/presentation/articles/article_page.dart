import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:share/share.dart';
import 'package:tourm_app/core/data/remote/tm_api_config.dart';
import 'package:tourm_app/core/presentation/customization/tm_image.dart';
import 'package:tourm_app/data/model/remote/article_remote_model.dart';

class ArticlePage extends StatefulWidget {
  final ArticleRemoteModel article;
  final bool fromHome;

  ArticlePage({
    Key key,
    @required this.article,
    this.fromHome = true,
  }) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  double top = 0.0;

  @override
  Widget build(BuildContext context) {
    final article = widget.article;

    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        brightness: Brightness.dark,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(
                '${article.title}\n${article.subtitle}\nScarica gratuitamente museo Zuccante per leggere l\'articolo completo!',
              );
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Container(
              height: 300,
              padding: EdgeInsets.only(top: max(top, 0)),
              width: double.infinity,
              child: TMImage(
                '${getBaseUrl()}/${widget.article.imageUrl}',
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Scritto da ${article.name} ${article.surname}'),
          ),
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Text('Scritto da ${article.id}'),
          // ),

          Markdown(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            data: article.body,
          )
        ],
      ),
    );
  }
}
