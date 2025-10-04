import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tornet_assignment/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tornet_assignment/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tornet_assignment/features/auth/domain/usecases/login_usecase.dart';
import 'package:tornet_assignment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tornet_assignment/features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AuthBloc(
          loginUseCase: LoginUseCase(
            AuthRepositoryImpl(
              remoteDataSource: AuthRemoteDataSourceImpl(
                client: http.Client(),
              ),
            ),
          ),
        ),
        child: const LoginPage(),
      ),
    );
  }
}
