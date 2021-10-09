import 'package:shop_app/models/login_model.dart';

abstract class LoginShopStates {}

class LoginInitialState extends LoginShopStates {}

class LoginLoadingState extends LoginShopStates {}

class LoginSuccessState extends LoginShopStates {
  late final ShopLoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginShopStates {
  late final String error;
  LoginErrorState(this.error);
}

class ChangePassVisState extends LoginShopStates {}
