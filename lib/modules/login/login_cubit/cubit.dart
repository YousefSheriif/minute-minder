import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minute_minder/modules/login/login_cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error)
    {
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));

    });
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  void changeEyeIcon() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialLoginChangeEyeIconState());
  }
}
