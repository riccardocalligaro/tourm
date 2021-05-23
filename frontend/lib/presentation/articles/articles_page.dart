import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tourm_app/core/infrastructure/error/types/failures.dart';
import 'package:tourm_app/core/presentation/customization/no_glow.dart';
import 'package:tourm_app/core/presentation/customization/tm_colors.dart';
import 'package:tourm_app/core/presentation/customization/tm_image.dart';
import 'package:tourm_app/core/presentation/states/pm_failure_view.dart';
import 'package:tourm_app/core/presentation/states/pm_loading_view.dart';
import 'package:tourm_app/core_container.dart';
import 'package:tourm_app/data/model/remote/article_remote_model.dart';
import 'package:tourm_app/domain/repository/articles_repository.dart';
import 'package:tourm_app/presentation/articles/widget/article_vertical_card.dart';

class ArticlesPage extends StatefulWidget {
  ArticlesPage({Key key}) : super(key: key);

  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  ArticlesRepository articlesRepository;

  @override
  void initState() {
    articlesRepository = sl();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Either<Failure, List<ArticleRemoteModel>>>(
        future: articlesRepository.getArticles(),
        initialData: null,
        builder: (
          BuildContext context,
          AsyncSnapshot<Either<Failure, List<ArticleRemoteModel>>> snapshot,
        ) {
          if (snapshot.hasData) {
            return snapshot.data.fold(
              (f) => PMFailureView(failure: f),
              (articles) => _buildLoadedArticles(articles: articles),
            );
          } else {
            return TMLoadingView();
          }
        },
      ),
    );
  }

  Widget _buildLoadedArticles({
    @required List<ArticleRemoteModel> articles,
  }) {
    final highlightedArticles = articles.where((i) => i.highlighted).toList();
    final normalArticles = articles.where((i) => !i.highlighted).toList();

    return ArticlesLoadedState(
      articles: normalArticles,
      highlightedArticles: highlightedArticles,
    );
  }
}

class ArticlesLoadedState extends StatefulWidget {
  final List<ArticleRemoteModel> highlightedArticles;
  final List<ArticleRemoteModel> articles;

  const ArticlesLoadedState({
    Key key,
    @required this.articles,
    @required this.highlightedArticles,
  }) : super(key: key);

  @override
  _ArticlesLoadedStateState createState() => _ArticlesLoadedStateState();
}

class _ArticlesLoadedStateState extends State<ArticlesLoadedState> {
  TextEditingController _searchController;
  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    _searchController.addListener(() {
      // BlocProvider.of<SearchBloc>(context)
      //     .add(SearchArticle(query: _searchController.text));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        backgroundColor: TMColors.primary,
        color: Colors.white,
        onRefresh: () async {
          // BlocProvider.of<ArticlesUpdaterBloc>(context).add(UpdateArticles());
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildSearchBar(),
                if (_searchController.text.length < 2)
                  buildTopVisitedSection(
                    articles: widget.highlightedArticles,
                  ),
                if (_searchController.text.length < 2)
                  buildsAndExibitions(
                    articles: widget.articles,
                  ),
                // if (_searchController.text.length >= 2) buildResults()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildResults() {
  //   return BlocBuilder<SearchBloc, SearchState>(
  //     builder: (context, state) {
  //       if (state is SearchResultsLoaded) {
  //         return buildsAndExibitions(articles: state.results, search: true);
  //       }
  //       return CircularProgressIndicator();
  //     },
  //   );
  // }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: TMColors.primary,
        // borderRadius: BorderRadius.circular(16.0),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      Flexible(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 15,
                              bottom: 11,
                              top: 11,
                              right: 15,
                            ),
                            hintText: 'Search an article',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Material(
                borderRadius: BorderRadius.circular(8.0),
                child: Ink(
                  decoration: BoxDecoration(
                    color: TMColors.alternativeBackgroundColor,
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
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      // TODO: dialog
                      // showDialog(
                      //   context: context,
                      //   builder: (_) => AnimatedQRDialog(),
                      // );
                    },
                    child: Hero(
                      tag: 'qrcode',
                      child: Container(
                        padding: EdgeInsets.all(13.0),
                        decoration: BoxDecoration(
                          // color: TMColors.alternativeBackgroundColor,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Icon(
                          CupertinoIcons.qrcode_viewfinder,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildsAndExibitions({
    @required List<ArticleRemoteModel> articles,
    bool search = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (search)
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Text(
              'Results',
              style: TextStyle(
                fontSize: 18,
                color: TMColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        if (!search)
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Text(
              'News and exibitions',
              style: TextStyle(
                fontSize: 18,
                color: TMColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          shrinkWrap: true,
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return ArticleVerticalCard(article: article);
          },
        ),
      ],
    );
  }

  Widget buildTopVisitedSection({
    @required List<ArticleRemoteModel> articles,
  }) {
    // return Text(articles.map((e) => e.title).toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Row(
            children: [
              Text(
                'Highlights',
                style: TextStyle(
                  fontSize: 18,
                  color: TMColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (_) => Colors.transparent),
                ),
                onPressed: () {
                  // TODO: view all
                },
                child: Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 16,
                    color: TMColors.primary,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Text(articles.map((e) => e.title).toString()),
        SizedBox(
          height: 230,
          child: ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(articles.length, (index) {
                  final article = articles[index];
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: buildTopVisitedCard(article: article),
                    );
                  } else if (index == 15) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: buildTopVisitedCard(article: article),
                    );
                  }

                  return buildTopVisitedCard(article: article);
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTopVisitedCard({
    @required ArticleRemoteModel article,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0.0, 16.0, 8.0),
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
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              goToArticlePage(article);
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).cardColor.withOpacity(0.9),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Hero(
                          tag: 'article${article.id}',
                          child: TMImage(article.imageUrl),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      article.title,
                      style: TextStyle(
                        // fontWeight: FontWeight.w200,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      article.subtitle,
                      style: Theme.of(context).textTheme.caption,
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
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => ArticlePage(
    //       article: articleDomainModel,
    //     ),
    //   ),
    // );
  }
}
