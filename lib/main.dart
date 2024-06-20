import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/firebase_options.dart';
import 'package:zetaton_task/layout/home_layout.dart';
import 'package:zetaton_task/network/local/cache_helper.dart';
import 'package:zetaton_task/network/remote/dio_helper.dart';
import 'package:zetaton_task/provider/app_provider.dart';
import 'package:zetaton_task/modules/login/login_screen.dart';
import 'package:zetaton_task/shared/components/constatn.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  //String uId = CacheHelper.getData('uId');
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  uId = CacheHelper.getData('uId');
  Widget widget;
  if(uId == null){
    widget = LoginScreen();
  }else{
    widget = HomeLayout();
  }
  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget) : super();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    uId = CacheHelper.getData('uId');
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider()..getWallpapers(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
        //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home: widget,
      ),
    );
  }
}

