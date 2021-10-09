class ProfileModel{
  bool?status;
  String? message;
  ProfileUserData? data;
  ProfileModel.fromJSON(Map<String,dynamic> json){
    status= json['status'];
    message = json['message'];
    data = json['data']!=null?ProfileUserData.fromJSON(json['data']):null;
  }
}
class ProfileUserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  ProfileUserData.fromJSON(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];


  }
}