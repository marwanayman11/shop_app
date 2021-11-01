import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/homemodel.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/modules/favorites/favorites.dart';
import 'package:shop_app/modules/products/products.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
        ),
        label: 'Favorites'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings')
  ];
  List screens = [
    const ProductsScreen(),
    const FavoritesScreen(),
    SettingsScreen()
  ];
  void changeBottomNavIndex(int index) {
    currentIndex = index;
    if(index==0){
      getHomeData();
    }
    else if(index==1){
      getFavoritesData();
    }
    else{
      getSettingsData();
    }
    emit(ShopBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, dynamic> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJSON(value.data);
      for (var element in homeModel!.data.products) {
        favorites.addAll({element.id: element.inFavorites});
      }
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(url: categories, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
            url: favorite, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavouritesState(error.toString()));
      showToast(message: "Something's wrong", state: toastStates.error);
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(ShopLoadingFavoritesDataState());
    DioHelper.getData(url: favorite, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJSON(value.data);
      emit(ShopSuccessFavoritesDataState());
    }).catchError((error) {
      emit(ShopErrorFavoritesDataState(error.toString()));
    });
  }

  ProfileModel? profileModel;
  void getSettingsData() {
    emit(ShopLoadingSettingsDataState());
    DioHelper.getData(url: profile, token: token).then((value) {
      profileModel = ProfileModel.fromJSON(value.data);
      emit(ShopSuccessSettingsDataState());
    }).catchError((error) {
      emit(ShopErrorSettingsDataState(error.toString()));
    });
  }

  ShopLoginModel? updateModel;
  void updateData(
      {required String name, required String email, required String phone}) {
    emit(ShopLoadingUpdateDataState());
    DioHelper.updateData(
            data: {'name': name, 'email': email, 'phone': phone},
            url: update,
            token: token)
        .then((value) {
      updateModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateDataState(updateModel!));
    }).catchError((error) {
      emit(ShopErrorUpdateDataState(error.toString()));
    });
  }
}
