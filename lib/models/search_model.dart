class SearchModel {
  late bool status;
  late DataModel data;
  SearchModel.fromJSON(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJSON(json['data']);
  }
}

class DataModel {
  List<SearchProductsDataModel> data1=[];
  late int currentPage;
  DataModel.fromJSON(Map<String, dynamic> json) {
    currentPage=json['current_page'];
    json['data'].forEach((element) {
      data1.add(SearchProductsDataModel.fromJSON(element));
    });
  }
}

class SearchProductsDataModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  late bool inFavorites;

  SearchProductsDataModel.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description=json['description'];
    inFavorites=json['in_favorites'];

  }
}
