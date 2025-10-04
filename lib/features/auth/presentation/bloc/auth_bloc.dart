import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tornet_assignment/features/auth/domain/usecases/login_usecase.dart';
import 'package:tornet_assignment/features/auth/presentation/bloc/auth_event.dart';
import 'package:tornet_assignment/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      LoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(const AuthFailure(message: 'Login failed. Please try again.')),
      (user) => emit(AuthSuccess(user: user)),
    );
  }
}
