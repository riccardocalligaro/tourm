import 'package:dartz/dartz.dart';
import 'package:tourm_app/core/infrastructure/error/types/failures.dart';

mixin TicketsRepository {
  Future<Either<Failure, TicketValidOrNot>> checkTicket();
}

class TicketValidOrNot {
  bool valid;

  bool get isValid => valid;
}
