part of 'shop_login_cubit.dart';

@immutable
abstract class ShopLoginState {}

class ShopLoginInitial extends ShopLoginState {}

class loginLoadingState extends ShopLoginState {}

class loginScucessState extends ShopLoginState {
  final LoginModel loginModel;

  loginScucessState(this.loginModel);
}

class loginErrorState extends ShopLoginState {
  final String error;

  loginErrorState(this.error);
}

class changeSuffixiconState extends ShopLoginState {}
