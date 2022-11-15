import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home_screen.dart';
import 'package:shop_app/shared/strings.dart';
import 'package:shop_app/shared/themes.dart';
import 'package:shop_app/shared_pref.dart';

import 'busniss_logic/bloc_observer.dart';
import 'busniss_logic/shop/shop_app_cubit.dart';
import 'layouts/login_Screen.dart';
import 'layouts/on_boarding.dart';

// @dart=2.9
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await SharedPref.init();
  Widget widget;
  bool onBoarding = SharedPref.getData('onBoarding');
  print(onBoarding);
  token = SharedPref.getData('token');
  if (onBoarding != null) {
    if (token != null) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBaordingScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppCubit()..getHomeData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightTheme,
          home: startWidget),
    );
  }
}
