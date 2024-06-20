import 'package:dio/dio.dart';
import 'package:zetaton_task/network/key/api_key.dart';

class DioHelper{

   static Dio? dio;
   //the init data for dio
   static init() {
     dio = Dio(
         BaseOptions(
           baseUrl: 'https://api.pexels.com/v1/',
           receiveDataWhenStatusError: true,
           responseType: ResponseType.json,
           validateStatus: (status) {
             if(status == null){
               return false;
             }
             if(status == 401){ // your http status code
               return true;
             }else{
               return status >= 200 ;
             }
           },
         ),
     );
   }

   //get request with dio
  static Future<Response> getData({
     required String path,
     Map<String, dynamic>? query,
    String? token,
}) async{
     dio!.options.headers = {
       'Authorization': apiKey,
     };
    return await dio!.get(
      path,
      queryParameters: query,
    );
   }



}