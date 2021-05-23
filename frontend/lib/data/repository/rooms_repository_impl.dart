import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tourm_app/core/infrastructure/error/handler.dart';
import 'package:tourm_app/core/infrastructure/error/types/failures.dart';
import 'package:tourm_app/data/datasource/tm_remote_datasource.dart';
import 'package:tourm_app/data/model/remote/room_remote_model.dart';
import 'package:tourm_app/domain/repository/rooms_repository.dart';

class RoomsRepositoryImpl implements RoomsRepository {
  final TMRemoteDatasource remoteDatasource;

  RoomsRepositoryImpl({
    @required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, List<RoomRemoteModel>>> getRooms() async {
    try {
      final remoteRooms = await remoteDatasource.getRooms();
      return Right(remoteRooms);
    } catch (e, s) {
      return Left(handleError(e, s));
    }
  }
}
