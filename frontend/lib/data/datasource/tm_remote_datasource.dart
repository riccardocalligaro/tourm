import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tourm_app/data/model/remote/article_remote_model.dart';
import 'package:tourm_app/data/model/remote/audioguide_remote_model.dart';
import 'package:tourm_app/data/model/remote/room_remote_model.dart';

class TMRemoteDatasource {
  final Dio dio;

  TMRemoteDatasource({
    @required this.dio,
  });

  Future<List<ArticleRemoteModel>> getArticles() async {
    String path = '/articles';
    final response = await dio.get(path);
    List<ArticleRemoteModel> articles = List<ArticleRemoteModel>.from(
      response.data.map(
        (i) => ArticleRemoteModel.fromJson(i),
      ),
    );

    return articles;
  }

  Future<List<RoomRemoteModel>> getRooms() async {
    String path = '/rooms';
    final response = await dio.get(path);
    List<RoomRemoteModel> rooms = List<RoomRemoteModel>.from(
      response.data.map(
        (i) => RoomRemoteModel.fromJson(i),
      ),
    );

    return rooms;
  }

  Future<List<AudioguideRemoteModel>> getAudioguides() async {
    String path = '/audioguides';
    final response = await dio.get(path);
    List<AudioguideRemoteModel> audioguides = List<AudioguideRemoteModel>.from(
      response.data.map(
        (i) => AudioguideRemoteModel.fromJson(i),
      ),
    );

    return audioguides;
  }
}
