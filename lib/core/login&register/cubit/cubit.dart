//cubit for login screen
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lun_talabaty_app/core/login&register/model/user_model.dart';
import 'package:lun_talabaty_app/share/remote/dio_helper.dart';
import 'package:lun_talabaty_app/share/remote/end_points.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  HexColor color = HexColor('#C4C4C4');
  void changePasswordVisibility() {
    isPassword = !isPassword;
    color = isPassword ? HexColor('#C4C4C4') : HexColor('#F5504C');
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

  UserModel? userModel;
  String phoneNumber = '';

  void userLogin({
    required String phone,
    required String password,
  }) {
    emit(LoginLoadingState());
    try {
      Api.post(
        path: LOGIN,
        data: {
          'phone': phone,
          'password': password,
        },
      ).then((value) {
        userModel = UserModel.fromJson(value.data);
        if (userModel!.success == true) {
          emit(LoginSuccessState(userModel!));
        } else {
          emit(LoginErrorState(userModel!.message!));
        }
      }).catchError((error) {
        emit(LoginErrorState(error.toString()));
      });
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}
