class UserModel {
  String? fName;
  String? lName;
  String? email;
  String? phone;
  String? uId;





  UserModel({
    this.fName,
    this.lName,
    this.email,
    this.phone,
    this.uId,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    fName = json['fName'];
    lName = json['lName'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];

  }

  Map<String, dynamic> toJson(){
    return {
      'fName':fName,
      'lName':lName,
      'email':email,
      'phone': phone,
      'uId': uId,
    };
  }
}
