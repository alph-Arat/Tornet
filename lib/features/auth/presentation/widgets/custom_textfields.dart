import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tornet_assignment/features/auth/presentation/bloc/password_visibility_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyles.dart';

class CustomTextfields extends StatelessWidget {
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextfields({
    super.key,
    required this.isPassword,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    if (isPassword) {
      return BlocProvider(
        create: (_) => PasswordVisibilityCubit(),
        child: BlocBuilder<PasswordVisibilityCubit, bool>(
          builder: (context, isObscured) {
            return TextFormField(
              controller: controller,
              obscureText: isObscured,
              keyboardType: TextInputType.visiblePassword,
              style: AppTextstyles.placeholder16,
              validator: validator,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: AppTextstyles.placeholder16,
                filled: true,
                fillColor: AppColors.inputBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.focusedBorder,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.placeholder,
                  ),
                  onPressed: () {
                    context.read<PasswordVisibilityCubit>().toggle();
                  },
                ),
              ),
            );
          },
        ),
      );
    }

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: AppTextstyles.placeholder16,
      validator: validator,
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: AppTextstyles.placeholder16,
        filled: true,
        fillColor: AppColors.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.focusedBorder,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
