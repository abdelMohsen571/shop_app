part of 'shop_app_cubit.dart';

@immutable
abstract class ShopAppState {}

class ShopAppInitial extends ShopAppState {}

class BootomNavBarState extends ShopAppState {}

class LoadingHomeDataState extends ShopAppState {}

class SuccessHomeDataState extends ShopAppState {}

class ErrorHomeDataState extends ShopAppState {}

class SuccessCategoroiesDataState extends ShopAppState {}

class ErrorCategoroiesDataState extends ShopAppState {}

class SuccessChangeFavouriteDataState extends ShopAppState {
  final ChangeFavouriteModel changeFavouriteModel;

  SuccessChangeFavouriteDataState(this.changeFavouriteModel);
}

class SuccessChangeDataState extends ShopAppState {}

class ErrorChangeFavouriteDataState extends ShopAppState {}

class LoadingGetFavouriteDataState extends ShopAppState {}

class SuccessGetFavouriteDataState extends ShopAppState {}

class ErrorGetFavouriteDataState extends ShopAppState {}

class LoadingUserDataState extends ShopAppState {}

class SuccessUsereDataState extends ShopAppState {
  SuccessUsereDataState();
}

class ErrorUserDataState extends ShopAppState {}

class LoadingUpdateUserDataState extends ShopAppState {}

class SuccessUpdateUsereDataState extends ShopAppState {
  SuccessUpdateUsereDataState();
}

class ErrorUpdateUserDataState extends ShopAppState {}
