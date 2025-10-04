import 'package:dartz/dartz.dart';
import 'package:tornet_assignment/core/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
