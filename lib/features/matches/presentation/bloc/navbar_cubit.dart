import 'package:flutter_bloc/flutter_bloc.dart';

class NavbarCubit extends Cubit<int> {
  NavbarCubit() : super(1);

  void changeIndex(int index) {
    emit(index);
  }
}
