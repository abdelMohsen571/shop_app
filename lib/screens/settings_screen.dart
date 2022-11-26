import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/busniss_logic/shop/shop_app_cubit.dart';
import 'package:shop_app/busniss_logic/shop/shop_app_cubit.dart';
import 'package:shop_app/shared/strings.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var model = ShopAppCubit.get(context).userModel;
        nameController.text = model!.data!.name as String;
        emailController.text = model.data!.email as String;
        phoneController.text = model.data!.phone as String;

        return ConditionalBuilder(
          condition: true,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile:_ ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 24),
                    ),
                    if (state is LoadingUpdateUserDataState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (text) {
                        if (text!.isEmpty || text == null) {
                          return "please enter your name";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (text) {
                        if (text!.isEmpty || text == null) {
                          return "please enter your name";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "email",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      validator: (text) {
                        if (text!.isEmpty || text == null) {
                          return "please enter your name";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "phone",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ShopAppCubit.get(context).updateUser(
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  userName: nameController.text);
                            }
                            ShopAppCubit.get(context).getUserData();
                          },
                          child: Text(
                            "Update ",
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ButtonStyle()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.red,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            sinOut(context);
                          },
                          child: Text(
                            "LogOut ",
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ButtonStyle()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
