import 'package:flutter/material.dart';

import '../layouts/login_Screen.dart';
import '../shared_pref.dart';

void sinOut(context) {
  SharedPref.clearData('token').then((value) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => (LoginScreen())));
  });
}

String token = '';
