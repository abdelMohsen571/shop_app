import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/busniss_logic/shop/shop_app_cubit.dart';
import 'package:shop_app/busniss_logic/shop/shop_app_cubit.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/web_services/models/home_model/home_model.dart';

import '../web_services/models/categories_model.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SuccessChangeFavouriteDataState) {
          if (state.changeFavouriteModel.status == false) {
            showToast(state.changeFavouriteModel.message, ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (context) => productBuilder(cubit.homeModel as HomeModel,
                cubit.categoriesModel as CategoriesModel, context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productBuilder(
          HomeModel homeModel, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: homeModel.data!.banners!
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    viewportFraction: 1,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal)),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => builldCategoryItem(
                            categoriesModel.data.data[index]),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10),
                        itemCount: categoriesModel.data.data.length),
                  ),
                  Text(
                    'New Product',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.59,
                children: List.generate(
                  homeModel.data!.products!.length,
                  (index) =>
                      builldGridItem(homeModel.data!.products![index], context),
                ),
              ),
            ),
          ],
        ),
      );
  Widget builldGridItem(Products productsModel, context) => Container(
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage('${productsModel.image}'),
                width: double.infinity,
                height: 200,
              ),
              if (productsModel.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.red,
                  child: Text(
                    'Discount',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${productsModel.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, height: 1.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  '${productsModel.price!.round()}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.pink),
                ),
                SizedBox(
                  width: 5,
                ),
                if (productsModel.discount != 0)
                  Text(
                    '${productsModel.oldPrice!.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      ShopAppCubit.get(context)
                          .changeFavourite(productsModel.id as int);
                      // print(productsModel.id);
                    },
                    icon: CircleAvatar(
                        backgroundColor: ShopAppCubit.get(context)
                                    .favourites[productsModel.id] ??
                                true
                            ? Colors.pink
                            : Colors.grey,
                        radius: 15,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        )))
              ],
            ),
          ),
        ]),
      );

  Widget builldCategoryItem(CategoriesDataDetailsModel model) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 100,
            width: 100,
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(.8),
            child: Text(
              model.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      );
}
