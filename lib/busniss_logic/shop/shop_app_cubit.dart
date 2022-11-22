import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/web_services/api_manager.dart';
import 'package:shop_app/web_services/models/categories_model.dart';
import 'package:shop_app/web_services/models/home_model/home_model.dart';

import '../../screens/favourite_screen.dart';
import '../../screens/product_screen.dart';
import '../../screens/category_screen.dart';
import '../../screens/settings_screen.dart';
import '../../shared/strings.dart';
import '../../web_services/dio_helper.dart';

part 'shop_app_state.dart';

class ShopAppCubit extends Cubit<ShopAppState> {
  ShopAppCubit() : super(ShopAppInitial());
  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    ProductScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    SettingsScreen()
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(BootomNavBarState());
  }

  HomeModel homeModel = HomeModel();

  void getHomeData() {
    DioHelper.getData(
      url: 'https://student.valuxapps.com/api/home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.data!.products![0].name);
      print(homeModel.data!.products![0].image);
      print(homeModel.data!.products![0].description);

      emit(SuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeDataState());
    });
  }

  late CategoriesModel categoriesModel;

  void getCategoryData() {
    DioHelper.getData(
      url: 'https://student.valuxapps.com/api/categories',
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessCategoroiesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCategoroiesDataState());
    });
  }
  /*
  HomeModel? homeModel;
  void getHomeData() {
    emit(LoadingHomeDataState());
    print('ok');
    ApiManager.getData(token: token).then((value) {
      print('sjklafklsdjfkl');
      emit(SuccessHomeDataState());
      HomeModel homeModel = HomeModel.fromJson(value.data);
      print(homeModel.status);
    }).catchError((error) {
      ErrorHomeDataState();
    });
  }*/
}
