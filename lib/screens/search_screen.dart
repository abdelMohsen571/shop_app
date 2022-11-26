import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/web_services/models/home_model/home_model.dart';

import '../busniss_logic/search/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var search = TextEditingController();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: search,
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text!.isEmpty || text == null) {
                          return "password is to short";
                        }
                      },
                      onChanged: (text) {
                        SearchCubit.get(context).getSearchData(txt: text);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        labelText: "email address",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is LoadingSearchState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                        itemBuilder: (context, index) => buildSearchItem(
                            SearchCubit.get(context)
                                .searchModel
                                .data!
                                .data![index],
                            context),
                        separatorBuilder: (context, index) => Container(
                              height: 1,
                            ),
                        itemCount: SearchCubit.get(context)
                            .searchModel
                            .data!
                            .data!
                            .length)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding buildSearchItem(model, context) {
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
                    image: NetworkImage(model.image as String),
                    fit: BoxFit.fitWidth,
                  ),
                  if (model.discount != 0)
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
                      '${model.name}',
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
                          '${model.price}',
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
                            '${model.oldPrice}',
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
                              model.id;
                              // print(productsModel.id);
                            },
                            icon: CircleAvatar(
                                backgroundColor: model.inFavorites == true
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
