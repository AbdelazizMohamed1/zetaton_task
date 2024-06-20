
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zetaton_task/layout/home_layout.dart';
import 'package:zetaton_task/models/favorite_model.dart';
import 'package:zetaton_task/models/images_model.dart';
import 'package:zetaton_task/models/search_model.dart';
import 'package:zetaton_task/models/user_model.dart';
import 'package:zetaton_task/models/wallpaper_model.dart';
import 'package:zetaton_task/network/local/cache_helper.dart';
import 'package:zetaton_task/network/remote/dio_helper.dart';
import 'package:zetaton_task/shared/components/components.dart';
import 'package:zetaton_task/shared/components/constatn.dart';

class AppProvider with ChangeNotifier{

  //login with email and password and save the uId in shared pref
  bool isLoginIn = false;
  void login({
    required String email,
    required String password,
    required context
}){
    isLoginIn = true;
    notifyListeners();
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((response){
      print(response.user!.uid);
      isLoginIn = false;
      CacheHelper.saveData(key: 'uId', value: response.user!.uid);
      uId = CacheHelper.getData('uId');
      navigateTo(context, HomeLayout());
      notifyListeners();
    }).catchError((error){
      isLoginIn = false;
      notifyListeners();
      print(error);
    });
  }



  //register new user and save uId in shared pref and then store user data in firebase
  bool isRegistered = false;
  void register({
    required String fName,
    required String lName,
    required String email,
    required String phone,
    required String password,
    required context
  }){
    isRegistered = true;
    notifyListeners();
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((response){
      isRegistered = false;
      CacheHelper.saveData(key: 'uId', value: response.user!.uid);
      uId = CacheHelper.getData('uId');
      _createUser(fName: fName, lName: lName, phone: phone, email: email, uId: response.user!.uid,context: context);
      notifyListeners();
    }).catchError((error){
      isRegistered = false;
      notifyListeners();
      print(error.toString());
    });
  }

//store user data in Firebase
  void _createUser({
    required String fName,
    required String lName,
    required String phone,
    required String email,
    required String uId,
    required context
  }) {
    UserModel model = UserModel(
      fName: fName,
      lName: lName,
      phone: phone,
      email: email,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      navigateTo(context, HomeLayout());
    }).catchError((error) {
      print(error.toString());
    });
  }



  //get home wallpapers images
  WallpaperModel? wallpaperModel;
  void getWallpapers(){
    DioHelper.getData(path: 'search',query: {
      'query' : 'wallpapers'
    }).then((value){
      wallpaperModel = WallpaperModel.fromJson(value.data);
      notifyListeners();
    }).catchError((error){
      print(error.toString());
      notifyListeners();
    });
  }



  //add Image To Firebase
   ImagesModel? imagesModel;
  void addToFavorite({
    required String imageUrl,
})async{
    FavoriteModel model = FavoriteModel(
      image: imageUrl
    );
    FirebaseFirestore fireStore = FirebaseFirestore.instance;;
    DocumentReference userDocRef = fireStore.collection('favorites').doc(uId);
    DocumentSnapshot docSnapshot = await userDocRef.get();
    if (docSnapshot.exists) {
      userDocRef.update({
        'images': FieldValue.arrayUnion([model.toJson()]),
      });
    } else {
      userDocRef.set({
        'images': [model.toJson()],
      });
    }
  }





  //get favoriteImages From Firebase
  Future<List<Map<String, String>>> getFavoriteImages(String uId) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    DocumentReference userDocRef = fireStore.collection('favorites').doc(uId);
    DocumentSnapshot docSnapshot = await userDocRef.get();


    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      if (data != null && data['images'] != null) {
        List<dynamic> imagesList = data['images'];
        imagesModel = ImagesModel.fromJson(data);
        return List<Map<String, String>>.from(imagesList.map((item) => Map<String, String>.from(item)));
      }
    }
    return [];
  }




  //get search data images
  SearchModel? searchModel;
  void search({
    required String search
}){
    DioHelper.getData(path: 'search',query: {
      'query' : 'wallpapers + $search'
    }).then((value){
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.photos.length);
      notifyListeners();
    }).catchError((error){
      print(error.toString());
      notifyListeners();
    });
  }
}