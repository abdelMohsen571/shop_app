part of 'shop_login_cubit.dart';

@immutable
abstract class ShopRegisterState {}

class ShopRegisterInitial extends ShopRegisterState {}

class RegisterLoadingState extends ShopRegisterState {}

class RegisterScucessState extends ShopRegisterState {
  final UserModel RegisterModel;

  RegisterScucessState(this.RegisterModel);
}

class RegisterErrorState extends ShopRegisterState {
  final String error;

  RegisterErrorState(this.error);
}

class changeSuffixiconState extends ShopRegisterState {}
