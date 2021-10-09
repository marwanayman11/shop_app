import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/shop_register/cubit/states.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterShopCubit extends Cubit<RegisterShopStates> {
  RegisterShopCubit() : super(RegisterInitialState());
  static RegisterShopCubit get(context) => BlocProvider.of(context);
  bool passVis = true;
  void changePassVis() {
    passVis = !passVis;
    emit(RegisterChangePassVisState());
  }

  late ShopLoginModel registerModel;
  void register(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    emit(RegisterLoadingState());
    await DioHelper.postData1(lang: 'en', url: register1, data: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone
    }).then((value) {
      registerModel = ShopLoginModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }
}
