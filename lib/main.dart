import 'package:flutter_developer_test/view/product.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'global.dart';

Future<void> main()async{

  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.72, 856.72),
      builder: (context, child) => const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Product(),
      ),
    );
  }
}
