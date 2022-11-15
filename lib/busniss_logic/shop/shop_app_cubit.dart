import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/web_services/api_manager.dart';
import 'package:shop_app/web_services/models/home_model/home_model.dart';

import '../../screens/favourite_screen.dart';
import '../../screens/product_screen.dart';
import '../../screens/category_screen.dart';
import '../../screens/settings_screen.dart';
import '../../shared/strings.dart';

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

  HomeModel? homeModel;
  void getHomeData() {
    emit(LoadingHomeDataState());
    print('ok');
    ApiManager.getData(token: token).then((value) {
      print('sjklafklsdjfkl');
      HomeModel homeModel = HomeModel.fromJson(value.data);

      print(homeModel.data!.products![0].name);
      emit(SuccessHomeDataState());
    }).catchError((error) {
      ErrorHomeDataState();
    });
  }
}
