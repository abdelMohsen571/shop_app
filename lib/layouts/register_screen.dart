import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/busniss_logic/register/shop_login_cubit.dart';
import 'package:shop_app/layouts/login_Screen.dart';

import '../shared/component.dart';
import '../shared/strings.dart';
import '../shared_pref.dart';
import 'home_screen.dart';

class RegisterScreem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is RegisterScucessState) {
            if (state.RegisterModel.status!) {
              print(state.RegisterModel.data!.token);
              print(state.RegisterModel.message!);
              showToast(state.RegisterModel.message!, ToastState.SUCCES);
              SharedPref.putData('token', state.RegisterModel.data!.token)
                  .then((value) {
                token = state.RegisterModel.data!.token as String;
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              });
            } else {
              print(state.RegisterModel.message!);
              showToast(state.RegisterModel.message!, ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28),
                        ),
                        Text(
                          'Register to ower shop to bla bla bal',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: userController,
                          keyboardType: TextInputType.text,
                          validator: (text) {
                            if (text!.isEmpty || text == null) {
                              return "please enter your name";
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            labelText: "user name",
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                                icon: ShopRegisterCubit.get(context).suffixIcon,
                                onPressed: () {
                                  ShopRegisterCubit.get(context)
                                      .changeSuffixicon();
                                }),
                            border: OutlineInputBorder(),
                            labelText: "password",
                          ),
                          obscureText:
                              (ShopRegisterCubit.get(context).opscurePass
                                  ? true
                                  : false),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (text) {
                            if (text!.isEmpty || text == null) {
                              return "please inter your phone";
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                            labelText: "phone",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: ConditionalBuilder(
                            condition: state
                                is! RegisterLoadingState, // state is! loginLoadingState,
                            builder: (context) => ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        userName: userController.text);
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
                            Text("Already have account :) "),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text(
                                  "login",
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
