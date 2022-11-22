import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/busniss_logic/shop/shop_app_cubit.dart';
import 'package:shop_app/busniss_logic/shop/shop_app_cubit.dart';

import '../web_services/models/categories_model.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildCategoryItem(cubit.categoriesModel.data.data[index]),
            separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: Colors.grey,
                ),
            itemCount: cubit.categoriesModel.data.data.length);
      },
    );
  }

  Widget buildCategoryItem(CategoriesDataDetailsModel model) {
    return Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 120,
          height: 120,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          model.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Spacer(),
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
      ],
    );
  }
}
