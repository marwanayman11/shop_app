class FavoritesModel {
   late bool status;
   late DataModel data;
  FavoritesModel.fromJSON(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJSON(json['data']);
  }
}

class DataModel {
  List<FavoritesDataModel> data1=[];
  late int currentPage;
  DataModel.fromJSON(Map<String, dynamic> json) {
    currentPage=json['current_page'];
    json['data'].forEach((element) {
      data1.add(FavoritesDataModel.fromJSON(element));
    });
  }
}

class FavoritesDataModel {
  late int id;
  late FavoritesProductsDataModel product;
  FavoritesDataModel.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    product = FavoritesProductsDataModel.fromJSON(json['product']);
  }
}

class FavoritesProductsDataModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;

  FavoritesProductsDataModel.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description=json['description'];
  }
}
