import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../web_services/models/LoginModel.dart';
import '../../web_services/api_manager.dart';

part 'shop_login_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitial());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  UserModel? loginModel;
  void userLogin({
    @required String? email,
    @required String? password,
  }) {
    emit(loginLoadingState());

    ApiManager.postData(data: {'email': email, 'password': password})
        .then((value) {
      loginModel = UserModel.fromJson(value.data);
      emit(loginScucessState(loginModel!));

      print(loginModel?.data?.name);
      print(loginModel?.message);
      print(value);
    }).catchError((error) {
      emit(loginErrorState(error.toString()));
      print(error);
    });
  }

  bool opscurePass = true;
  Widget suffixIcon = Icon(Icons.visibility_off);
  void changeSuffixicon() {
    opscurePass = !opscurePass;
    if (!opscurePass) {
      suffixIcon = Icon(Icons.visibility_outlined);
    } else {
      suffixIcon = Icon(Icons.visibility_off);
    }
    emit(changeSuffixiconState());
  }
}
