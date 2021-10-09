import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  late final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  late final String error;
  ShopErrorCategoriesState(this.error);
}

class ShopSuccessChangeFavoritesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavouritesState extends ShopStates {
  late final String error;
  ShopErrorChangeFavouritesState(this.error);
}

class ShopLoadingFavoritesDataState extends ShopStates {}

class ShopSuccessFavoritesDataState extends ShopStates {}

class ShopErrorFavoritesDataState extends ShopStates {
  late final String error;
  ShopErrorFavoritesDataState(this.error);
}

class ShopLoadingSettingsDataState extends ShopStates {}

class ShopSuccessSettingsDataState extends ShopStates {}

class ShopErrorSettingsDataState extends ShopStates {
  late final String error;
  ShopErrorSettingsDataState(this.error);
}

class ShopLoadingUpdateDataState extends ShopStates {}

class ShopSuccessUpdateDataState extends ShopStates {
  late final ShopLoginModel model;
  ShopSuccessUpdateDataState(this.model);
}

class ShopErrorUpdateDataState extends ShopStates {
  late final String error;
  ShopErrorUpdateDataState(this.error);
}
