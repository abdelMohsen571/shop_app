import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/web_services/api_manager.dart';
import 'package:shop_app/web_services/models/search_model.dart';

import '../../shared/strings.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel = SearchModel();
  void getSearchData({required String txt}) {
    emit(LoadingSearchState());

    ApiManager.postData(
        url: 'https://student.valuxapps.com/api/products/search',
        token: token,
        data: {'text': txt}).then((value) {
      //  print(value.data);
      searchModel = SearchModel.fromJson(value.data);
      print(value.data);
      emit(SuccessSearchState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorSearchState());
    });
  }
}
