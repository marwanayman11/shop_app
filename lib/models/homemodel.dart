class HomeModel{
  late bool status;
  late HomeDataModel data;
  HomeModel.fromJSON(Map<String,dynamic> json)
  {
    status=json['status'];
    data =HomeDataModel.fromJSON(json['data']);
  }
}
class HomeDataModel{
  List<BannersDataModel>banners=[];
  List<ProductsDataModel>products=[];

  HomeDataModel.fromJSON(Map<String,dynamic> json)
  {
    json['banners'].forEach((element){
      banners.add(BannersDataModel.fromJSON(element));
    });

    json['products'].forEach((element){
      products.add(ProductsDataModel.fromJSON(element));
    });
  }

}
class BannersDataModel{
 late int id ;
 late String image;
 BannersDataModel.fromJSON(Map<String,dynamic> json)
 {
   id =json['id'];
   image =json['image'];
 }

}
class ProductsDataModel{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;
  late String description;
  ProductsDataModel.fromJSON(Map<String,dynamic> json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
    description=json['description'];

  }

}