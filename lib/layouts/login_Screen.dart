import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layouts/home_screen.dart';
import 'package:shop_app/layouts/register_screen.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared_pref.dart';

import '../busniss_logic/login/shop_login_cubit.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is loginScucessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.data!.token);
              print(state.loginModel.message!);
              showToast(state.loginModel.message!, ToastState.SUCCES);
              SharedPref.putData('token', state.loginModel.data!.token)
                  .then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              });
            } else {
              print(state.loginModel.message!);
              showToast(state.loginModel.message!, ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          //  bool obscurepass = ShopLoginCubit.get(context).opscurePass;
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28),
                        ),
                        Text(
                          'login to ower shop to bla bla bal',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (text!.isEmpty || text == null) {
                              return "password is to short";
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                            labelText: "email address",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (text) {
                            if (text!.isEmpty || text == null) {
                              return "password is to short";
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffix: IconButton(
                                icon: ShopLoginCubit.get(context).suffixIcon,
                                onPressed: () {
                                  ShopLoginCubit.get(context)
                                      .changeSuffixicon();
                                }),
                            border: OutlineInputBorder(),
                            labelText: "password",
                          ),
                          obscureText: (ShopLoginCubit.get(context).opscurePass
                              ? true
                              : false),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: ConditionalBuilder(
                            condition: state is! loginLoadingState,
                            builder: (context) => ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                child: Text(
                                  'Login ',
                                  style: TextStyle(),
                                ),
                                style: ButtonStyle()),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Didn't have accunt? "),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreem()));
                                },
                                child: Text(
                                  "REGISTER",
                                  style: TextStyle(color: Colors.pink),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
