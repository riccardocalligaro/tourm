import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tourm_app/core/infrastructure/error/handler.dart';
import 'package:tourm_app/core/infrastructure/error/types/failures.dart';
import 'package:tourm_app/data/datasource/tm_remote_datasource.dart';
import 'package:tourm_app/data/model/remote/article_remote_model.dart';
import 'package:tourm_app/domain/repository/articles_repository.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  final TMRemoteDatasource remoteDatasource;

  ArticlesRepositoryImpl({
    @required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, List<ArticleRemoteModel>>> getArticles() async {
    try {
      final remoteLocations = await remoteDatasource.getArticles();
      return Right(remoteLocations);
    } catch (e, s) {
      return Left(handleError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<ArticleRemoteModel>>> getArticlesForRoom({
    String roomId,
  }) {
    // TODO: implement getArticlesForRoom
    throw UnimplementedError();
  }
}
