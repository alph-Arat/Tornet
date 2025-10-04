import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tornet_assignment/core/constants/app_colors.dart';
import 'package:tornet_assignment/core/constants/app_images.dart';
import 'package:tornet_assignment/core/constants/app_textstyles.dart';
import 'package:tornet_assignment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tornet_assignment/features/auth/presentation/bloc/auth_event.dart';
import 'package:tornet_assignment/features/auth/presentation/bloc/auth_state.dart';
import 'package:tornet_assignment/features/auth/presentation/widgets/custom_textfields.dart';
import 'package:tornet_assignment/features/matches/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            LoginButtonPressed(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            ),
          );
    }
  }

  void navigateToHome(BuildContext context, String token) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(token: token),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Welcome ${state.user.fullName}!'),
                backgroundColor: Colors.green,
              ),
            );
            navigateToHome(context, state.user.token);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.background),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        gradient: const RadialGradient(
                          center: Alignment(0.51, -0.73),
                          radius: 0.86,
                          colors: [
                            Color(0xFFBBFF93),
                            Color(0xFFEAFF98),
                            Color(0xFFD3FF9A),
                          ],
                          stops: [0.0, 0.725, 1.0],
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Gap(32),
                          const Text(
                            "Welcome back!!!",
                            style: AppTextstyles.headlineH6,
                          ),
                          const Gap(4),
                          const Text(
                            "Easier login from now on.",
                            style: AppTextstyles.content14,
                          ),
                          const Gap(24),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 32),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: AppColors.mainBackground,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomTextfields(
                                    isPassword: false,
                                    controller: _emailController,
                                    validator: _validateEmail,
                                  ),
                                  const Gap(12),
                                  CustomTextfields(
                                    isPassword: true,
                                    controller: _passwordController,
                                    validator: _validatePassword,
                                  ),
                                  const Gap(24),
                                  BlocBuilder<AuthBloc, AuthState>(
                                    builder: (context, state) {
                                      final isLoading = state is AuthLoading;

                                      return Container(
                                        decoration: BoxDecoration(
                                          gradient: AppColors.buttonGradient,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap:
                                                isLoading ? null : _handleLogin,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              alignment: Alignment.center,
                                              child: isLoading
                                                  ? const SizedBox(
                                                      height: 24,
                                                      width: 24,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: AppColors
                                                            .buttonText,
                                                      ),
                                                    )
                                                  : const Text("Login",
                                                      style: AppTextstyles
                                                          .button16),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Terms & Conditions",
                            style: AppTextstyles.textLink),
                        const Gap(20),
                        Text("Privacy Policy", style: AppTextstyles.textLink),
                      ],
                    ),
                    const Gap(10),
                    const Text(
                      "Copyright © 2024 Torliga Ltd. All Rights Reserved.",
                      style: AppTextstyles.content12,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
