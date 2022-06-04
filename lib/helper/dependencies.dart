import 'package:food_ordering/controller/cart_controller.dart';
import 'package:food_ordering/controller/popular_product_controller.dart';
import 'package:food_ordering/controller/recommended_product_controller.dart';
import 'package:food_ordering/data/api/api_client.dart';
import 'package:food_ordering/data/repository/cart_repo.dart';
import 'package:food_ordering/data/repository/popular_product_repo.dart';
import 'package:food_ordering/data/repository/recomneded_product_repo.dart';
import 'package:food_ordering/utils/constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  //apiClient
  Get.lazyPut(() => ApiClient(appBaseUrl: Constants.BASE_URL));
  //repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());
  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
