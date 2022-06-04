import 'package:food_ordering/data/repository/popular_product_repo.dart';
import 'package:food_ordering/data/repository/recomneded_product_repo.dart';
import 'package:food_ordering/models/product.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];

  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response res = await recommendedProductRepo.getRecommendedProduct();
    print(
        "------------------------- ${res.status.connectionError} -------------------------");
    if (res.statusCode == 200) {
      print("got recommended products");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(res.body).products);
      print("recommended Product List : $_recommendedProductList");
      _isLoaded = true;
      update(); /*update() == setState()*/
    } else {
      print("error:");
    }
  }
}
