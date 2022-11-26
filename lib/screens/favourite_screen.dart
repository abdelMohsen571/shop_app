import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/busniss_logic/shop/shop_app_cubit.dart';
import 'package:shop_app/busniss_logic/shop/shop_app_cubit.dart';

import '../web_services/models/get_fav_model.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! LoadingGetFavouriteDataState,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildFavouriteItem(
                  ShopAppCubit.get(context)
                      .getFavouriteModel!
                      .data!
                      .data![index],
                  context),
              separatorBuilder: (context, index) => Container(
                    color: Colors.grey,
                    height: 2,
                  ),
              itemCount: ShopAppCubit.get(context)
                  .getFavouriteModel!
                  .data!
                  .data!
                  .length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Padding buildFavouriteItem(favouriteData model, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 120,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image(
                    image: NetworkImage(model.product!.image as String),
                    fit: BoxFit.fitWidth,
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      color: Colors.red,
                      child: Text(
                        'Discount',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${model.product!.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          height: 1.1),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                        Text(
                          '${model.product!.price}',
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
                        if (8 != 0)
                          Text(
                            '${model.product!.oldPrice}',
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
                                  .changeFavourite(model.product!.id as int);
                              // print(productsModel.id);
                            },
                            icon: CircleAvatar(
                                backgroundColor: ShopAppCubit.get(context)
                                            .favourites[model.product!.id] ??
                                        false
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
