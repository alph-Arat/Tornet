import 'package:dartz/dartz.dart';
import 'package:tornet_assignment/core/errors/failures.dart';
import 'package:tornet_assignment/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tornet_assignment/features/auth/domain/entities/user.dart';
import 'package:tornet_assignment/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
