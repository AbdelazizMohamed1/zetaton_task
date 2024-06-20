import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/models/wallpaper_model.dart';
import 'package:zetaton_task/modules/favorite/favorite_screen.dart';
import 'package:zetaton_task/modules/login/login_screen.dart';
import 'package:zetaton_task/modules/search/search_screen.dart';
import 'package:zetaton_task/modules/wallpaper/wallpaper_screen.dart';
import 'package:zetaton_task/network/local/cache_helper.dart';
import 'package:zetaton_task/provider/app_provider.dart';
import 'package:zetaton_task/shared/components/components.dart';
import 'package:zetaton_task/shared/components/constatn.dart';
import 'package:zetaton_task/shared/style/colors.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return WillPopScope(
      onWillPop: () async{
        showDialog
          (context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm Exit'),
              content: const Text('Are you sure you want to exit ?'),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('no'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('yes'),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            );
          },);
        return false;
      },
      child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            title: Text(
              'Wallpapers',
              style: TextStyle(color: blackColor),
            ),
            leading:  IconButton(
              padding: const EdgeInsets.only(left: 20),
              onPressed: () async{
                showDialog
                  (context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Confirm Logout'),
                      content: const Text('Are you sure you want to logout ?'),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('no'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('yes'),
                          onPressed: () {
                            CacheHelper.clearData(key: 'uId').then((value){
                              navigateToAndFinish(context, LoginScreen());
                            });
                          },
                        ),
                      ],
                    );
                  },);

              },
              icon: Icon(
                Icons.logout,
                color: blackColor,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  provider.getFavoriteImages(uId!).then((onValue){
                    navigateToAndFinish(context,  FavoriteScreen( ));
                  });
                },
                icon: Icon(
                  Icons.favorite,
                  color: blackColor,
                ),
              ),
              IconButton(
                padding: const EdgeInsets.only(right: 20),
                onPressed: () {

                  navigateToAndFinish(context,  SearchScreen());
                },
                icon: Icon(
                  Icons.search,
                  color: blackColor,
                ),
              )
            ],
            elevation: 0.0,
            backgroundColor: whiteColor,
          ),
          body: provider.wallpaperModel != null ?
          Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) => _wallpaper(context: context,index: index ,wallpaperModel: provider.wallpaperModel!),
              itemCount: provider.wallpaperModel!.photos.length,
            ),
          ) : const Center(child: CircularProgressIndicator())

      ),
    );
  }
  
  Widget _wallpaper({
    required context,
    required WallpaperModel wallpaperModel,
    required index
}) =>    GestureDetector(
    onTap: () {
      navigateToAndFinish(context,  WallpaperScreen(originalImage: wallpaperModel.photos[index].src!.originalImage!,));
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
            '${wallpaperModel.photos[index].src!.smallImage}',
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
