class WallpaperModel{
  int? page;
  int? perPage;
  List<Photos> photos = [];
  int? totalResult;
  String? nextPage;

  WallpaperModel.fromJson(Map<String,dynamic> json){
    page = json['page'];
    perPage = json['per_page'];
    if(json['photos'] != null){
      photos = <Photos>[];
      json['photos'].forEach((element){
        photos.add(Photos.fromJson(element));
      });
    }
  }
}

class Photos{
   int? id;
   Src? src;

   Photos.fromJson(Map<String,dynamic> json){
     id = json['id'];
     src = json['src'] != null ? Src.fromJson(json['src']) : null;
   }
}

class Src{
  String? originalImage;
  String? smallImage;

  Src.fromJson(Map<String,dynamic> json){
    smallImage = json['small'];
    originalImage = json['original'];
  }
}