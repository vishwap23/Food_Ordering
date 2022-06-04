import 'package:flutter/material.dart';
import 'package:food_ordering/controller/popular_product_controller.dart';
import 'package:food_ordering/controller/recommended_product_controller.dart';
import 'package:food_ordering/routes/routes_helper.dart';
import 'package:food_ordering/screens/food/recommended_food_details.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;
import 'screens/home/main_food_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
     initialRoute: RoutesHelper.initial,
      getPages: RoutesHelper.routes,
      home: const MainFoodHomePage(),
      // home: const RecommendedFoodDetails(),
    );
  }
}
