import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  void productSearch(String text) {
    emit(LoadingSearchState());
    DioHelper.postData(url: search, data: {
      'text': text
    }, token: token).then((value) {
      searchModel = SearchModel.fromJSON(value.data);
      emit(SuccessSearchState());
    }).catchError((error) {
      emit(ErrorSearchState(error.toString()));
    });
  }
}
