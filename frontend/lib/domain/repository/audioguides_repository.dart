import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tourm_app/core/infrastructure/error/types/failures.dart';
import 'package:tourm_app/data/model/remote/audioguide_remote_model.dart';

abstract class AudioguidesRepository {
  Future<Either<Failure, List<AudioguideRemoteModel>>> getAudioguidesForBeacon({
    @required String beaconId,
  });

  Future<Either<Failure, List<AudioguideRemoteModel>>> getAudioguides();
}
