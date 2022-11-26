import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../web_services/models/LoginModel.dart';
import '../../web_services/api_manager.dart';

part 'shop_login_state.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitial());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  late UserModel RegisterModel;
  void userRegister({
    @required String? email,
    @required String? password,
    @required String? phone,
    @required String? userName,
  }) {
    emit(RegisterLoadingState());

    ApiManager.postData(
        url: 'https://student.valuxapps.com/api/register',
        data: {
          'email': email,
          'password': password,
          'name': userName,
          'phone': phone
        }).then((value) {
      RegisterModel = UserModel.fromJson(value.data);
      emit(RegisterScucessState(RegisterModel));

      print(RegisterModel.data?.name);
      print(RegisterModel.message);
      print(value);
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
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
