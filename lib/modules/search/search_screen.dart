import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/layout/home_layout.dart';
import 'package:zetaton_task/models/search_model.dart';
import 'package:zetaton_task/modules/wallpaper/wallpaper_screen.dart';
import 'package:zetaton_task/provider/app_provider.dart';
import 'package:zetaton_task/shared/components/components.dart';
import 'package:zetaton_task/shared/style/colors.dart';

class SearchScreen extends StatelessWidget {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return WillPopScope(
      onWillPop: () async{
        navigateToAndFinish(context, HomeLayout());
        return false;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Text('Search Screen',style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: whiteColor,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: defaultTextFormField(controller: searchController, textInputType: TextInputType.text,hintText: 'search',onSubmit: (value) {
                  provider.search(search: searchController.text);
                },),
              ),
              provider.searchModel != null ? Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) => _search(context: context,index: index ,searchModel: provider.searchModel!),
                  itemCount: provider.searchModel!.photos.length,
                ),
              ): Container()
            ],
          ),
        ),
      ),
    );
  }
  Widget _search({
    required context,
    required index,
    required SearchModel searchModel
  }) =>    GestureDetector(
    onTap: () {
      navigateToAndFinish(context,  WallpaperScreen(originalImage: searchModel.photos[index].src!.originalImage!,));
    },
    child: Container(
      width: MediaQuery.sizeOf(context).width / 2,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            '${searchModel.photos[index].src!.smallImage}',
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'images/no_image.png',
              );
            },
          )),
    ),
  );
}
