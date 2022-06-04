import 'package:food_ordering/screens/food/popular_food_details_page.dart';
import 'package:food_ordering/screens/food/recommended_food_details.dart';
import 'package:food_ordering/screens/home/main_food_home_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RoutesHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";

  static String getInitial() => '$initial';

  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';

  static String getRecommendedFood(int pageId) => '$recommendedFood?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodHomePage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId =  Get.parameters['pageId'];
          return PopularFoodDetailsPage(pageId:int.parse(pageId!),);
        },
        transition: Transition.cupertino),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId =  Get.parameters['pageId'];
          return RecommendedFoodDetails(pageId : int.parse(pageId!));
        },
        transition: Transition.cupertino)
  ];
}
