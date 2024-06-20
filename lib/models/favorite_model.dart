class FavoriteModel{
  String? image;

  FavoriteModel({this.image});
  FavoriteModel.fromJson(Map<String,dynamic> json){
    image = json['image'];
  }

  Map<String,dynamic> toJson(){
    return {
      'image' : image
    };
  }
}