
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/layout/home_layout.dart';
import 'package:zetaton_task/models/images_model.dart';
import 'package:zetaton_task/network/local/cache_helper.dart';
import 'package:zetaton_task/shared/components/components.dart';
import 'package:zetaton_task/shared/components/constatn.dart';
import 'package:zetaton_task/shared/style/colors.dart';

import '../../provider/app_provider.dart';

class FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return WillPopScope(
      onWillPop: () async{
        navigateToAndFinish(context, const HomeLayout());
        return false;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Text('Favorite Screen',style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: whiteColor,
          elevation: 0.0,
        ),
   body:
       provider.imagesModel != null ?
   Padding(
     padding: const EdgeInsets.all(20.0),
     child: GridView.builder(
       physics: const BouncingScrollPhysics(),
       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         crossAxisSpacing: 10.0,
         mainAxisSpacing: 10.0,
       ),
       itemBuilder: (context, index) => _favorite(context: context,index: index ,imagesModel: provider.imagesModel!,),
       itemCount:provider.imagesModel!.images.length,
     ),
   ) : const Center(child: CircularProgressIndicator(),),
      ),
    );
  }
  Widget _favorite({
    required context,
    required index,
    required ImagesModel imagesModel
  }) =>    Container(
    width: MediaQuery.sizeOf(context).width / 2,
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imagesModel.images[index].image!,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'images/no_image.png',
            );
          },
        )),
  );
}
