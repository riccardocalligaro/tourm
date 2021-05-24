import 'package:flutter/material.dart';
import 'package:tourm_app/core/data/remote/tm_api_config.dart';
import 'package:tourm_app/core/presentation/customization/tm_image.dart';
import 'package:tourm_app/data/model/remote/article_remote_model.dart';

import '../article_page.dart';

class ArticleVerticalCard extends StatefulWidget {
  final ArticleRemoteModel article;
  final bool fromHome;
  final bool disableHero;

  ArticleVerticalCard({
    Key key,
    @required this.article,
    this.fromHome = true,
    this.disableHero = false,
  }) : super(key: key);

  @override
  _ArticleVerticalCardState createState() => _ArticleVerticalCardState();
}

class _ArticleVerticalCardState extends State<ArticleVerticalCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.zero,
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              goToArticlePage(widget.article);
            },
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: TMImage(
                            '${getBaseUrl()}/${widget.article.imageUrl}'),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.article.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(widget.article.subtitle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void goToArticlePage(ArticleRemoteModel articleDomainModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ArticlePage(
          article: articleDomainModel,
        ),
      ),
    );
  }
}
