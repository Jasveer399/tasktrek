import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/features/todo/pages/home_page.dart';
import 'package:tasktrek/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const ProviderScope(child: MyApp()));
}

late Size mq;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final defaultlightcolorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final defaultdarkcolorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: Size(375, 825),
        minTextAdapt: true,
        builder: (context, child) {
          return DynamicColorBuilder(
              builder: (lightcolorscheme, darkcolorscheme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                scaffoldBackgroundColor: AppConst.KBkdark,
                colorScheme: lightcolorscheme??defaultlightcolorScheme,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                scaffoldBackgroundColor: AppConst.KBkdark,
                colorScheme: darkcolorscheme??defaultdarkcolorScheme,
                useMaterial3:true,
              ),
              home: const Homepage(),
            );
          });
        });
  }
}
