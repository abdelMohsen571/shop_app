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
