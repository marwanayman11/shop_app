import 'package:shop_app/models/login_model.dart';

abstract class RegisterShopStates {}

class RegisterInitialState extends RegisterShopStates {}

class RegisterLoadingState extends RegisterShopStates {}

class RegisterSuccessState extends RegisterShopStates {
  late final ShopLoginModel registerModel;
  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterShopStates {
  late final String error;
  RegisterErrorState(this.error);
}

class RegisterChangePassVisState extends RegisterShopStates {}
