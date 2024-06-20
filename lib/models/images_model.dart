class ImagesModel{
  List<Images> images = [];

  ImagesModel.fromJson(Map<String,dynamic> json){
    if(json['images'] != null){
      images = <Images>[];
      json['images'].forEach((element){
        images.add(Images.fromJson(element));
      });
    }
  }
}

class Images{
  String? image;

  Images.fromJson(Map<String,dynamic> json){
    image = json['image'];
  }
}