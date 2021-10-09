import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/shop_login/cubit/states.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginShopCubit extends Cubit<LoginShopStates> {
  LoginShopCubit() : super(LoginInitialState());
  static LoginShopCubit get(context) => BlocProvider.of(context);
  bool passVis = true;
  void changePassVis() {
    passVis = !passVis;
    emit(ChangePassVisState());
  }

  late ShopLoginModel loginModel;
  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    await DioHelper.postData1(lang: 'en', url: login1, data: {
      "email": email,
      "password": password,
    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }
}
