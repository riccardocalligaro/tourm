import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tourm_app/core/infrastructure/error/types/failures.dart';
import 'package:tourm_app/data/model/remote/room_remote_model.dart';

mixin RoomsRepository {
  Future<Either<Failure, List<RoomRemoteModel>>> getRooms();
}
