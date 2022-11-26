import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/web_services/api_manager.dart';
import 'package:shop_app/web_services/models/LoginModel.dart';
import 'package:shop_app/web_services/models/categories_model.dart';
import 'package:shop_app/web_services/models/get_fav_model.dart';
import 'package:shop_app/web_services/models/home_model/home_model.dart';
import 'package:shop_app/web_services/user_model.dart';

import '../../screens/favourite_screen.dart';
import '../../screens/product_screen.dart';
import '../../screens/category_screen.dart';
import '../../screens/settings_screen.dart';
import '../../shared/strings.dart';
import '../../web_services/dio_helper.dart';
import '../../web_services/models/change_favourite_model.dart';

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
  Map<int, bool> favourites = {};
  void getHomeData() {
    DioHelper.getData(
      url: 'https://student.valuxapps.com/api/home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //  print(homeModel.data!.products![0].name);
      //print(homeModel.data!.products![0].image);
      //print(homeModel.data!.products![0].description);
      homeModel!.data!.products!.forEach((element) {
        favourites.addAll({element.id as int: element.inFavorites as bool});
      });
      print(favourites.toString());
      emit(SuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoryData() {
    DioHelper.getData(
            url: 'https://student.valuxapps.com/api/categories', token: '')
        .then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessCategoroiesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCategoroiesDataState());
    });
  }

  ChangeFavouriteModel? changeFavouriteModel;
  bool x = false;
  void changeFavourite(int product_id) {
    x = !x;
    favourites[product_id] = x;

    emit(SuccessChangeDataState());

    ApiManager.postData(
        url: 'https://student.valuxapps.com/api/favorites',
        token: token,
        data: {'product_id': product_id}).then((value) {
      changeFavouriteModel = ChangeFavouriteModel.formJson(value.data);
      //  print(value.data);
      if (changeFavouriteModel!.status = false) {
        x = !x;
        favourites[product_id] = x;
      } else {
        getFavouriteData();
      }

      emit(SuccessChangeFavouriteDataState(
          changeFavouriteModel as ChangeFavouriteModel));
    }).catchError((error) {
      print(error.toString());
      if (changeFavouriteModel!.status = false) x = !x;
      favourites[product_id] = x;
      emit(ErrorChangeFavouriteDataState());
    });
  }

  GetFavouriteModel? getFavouriteModel;
  void getFavouriteData() {
    emit(LoadingGetFavouriteDataState());
    DioHelper.getData(
      url: 'https://student.valuxapps.com/api/favorites',
      token: token,
    ).then((value) {
      getFavouriteModel = GetFavouriteModel.fromJson(value.data);
      print('getfavoutite');
      print(value.data.toString());
      emit(SuccessGetFavouriteDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetFavouriteDataState());
    });
  }

  UserModel? userModel;
  void getUserData() {
    emit(LoadingUserDataState());
    DioHelper.getData(
            url: 'https://student.valuxapps.com/api/profile', token: token)
        .then((value) {
      userModel = UserModel.fromJson(value.data);
      print("proflio");
      print(value.data);
      emit(SuccessUsereDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUserDataState());
    });
  }

  UserModel? updateuser;
  void updateUser({
    @required String? email,
    @required String? phone,
    @required String? userName,
  }) {
    emit(LoadingUpdateUserDataState());

    DioHelper.putData(
        url: 'https://student.valuxapps.com/api/update-profile',
        token: token,
        data: {'email': email, 'name': userName, 'phone': phone}).then((value) {
      updateuser = UserModel.fromJson(value.data);
      print(updateuser!.data!.name);

      emit(SuccessUpdateUsereDataState());
    }).catchError((error) {
      print(error);

      emit(ErrorUpdateUserDataState());
    });
  }
}
