import 'package:dartz/dartz.dart';
import 'package:tornet_assignment/core/errors/failures.dart';
import 'package:tornet_assignment/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
}
