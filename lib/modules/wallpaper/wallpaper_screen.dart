import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/layout/home_layout.dart';
import 'package:zetaton_task/network/local/cache_helper.dart';
import 'package:zetaton_task/provider/app_provider.dart';
import 'package:zetaton_task/shared/components/components.dart';
import 'package:zetaton_task/shared/components/constatn.dart';
import 'package:zetaton_task/shared/style/colors.dart';

class WallpaperScreen extends StatelessWidget {
  final String originalImage;

  const WallpaperScreen({super.key, required this.originalImage});

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
          backgroundColor: whiteColor,
          elevation: 0.0,
          title: Text('Wallpaper',style: TextStyle(color: blackColor),),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  originalImage,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'images/no_image.png',
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: (MediaQuery.sizeOf(context).width /2 )- 50,
              child: defaultMaterialButton(title: 'Download',onPressed: () {
                _downloadFile(originalImage, context);
              },),
            ),
            Positioned(
              bottom: 40,
              left: (MediaQuery.sizeOf(context).width /2 )- 70,
              child: defaultMaterialButton(title: 'Add To Favourite',onPressed: () {
               provider.addToFavorite(imageUrl: originalImage);
              },),
            )
          ],
        ),
      ),
    );
  }
  Future<void> _downloadFile(String url, BuildContext context) async {
    final String uri = url;
    try {
      final tempDir = await getTemporaryDirectory();
      final path = '${tempDir.path}/temp_file${_getFileExtension(uri)}';
      await Dio().download(uri, path);
      if (uri.contains('.mp4')) {
        await GallerySaver.saveVideo(path, toDcim: true);
        _showSnackBar(context, 'Video saved to gallery!');
      } else if (uri.contains('.jpg') || uri.contains('.png')||uri.contains('.jpeg')) {
        await GallerySaver.saveImage(path, toDcim: true);
        _showSnackBar(context, 'Image saved to gallery!');
      } else {
        _showSnackBar(context, 'Unsupported file type');
      }
    } catch (e) {
      _showSnackBar(context, 'Error saving file: $e');
    }
  }

  String _getFileExtension(String uri) {
    return uri.substring(uri.lastIndexOf('.'));
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }


}
