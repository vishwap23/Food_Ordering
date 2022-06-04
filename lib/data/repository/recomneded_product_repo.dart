import 'package:food_ordering/data/api/api_client.dart';
import 'package:food_ordering/utils/constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient}) ;

  Future<Response> getRecommendedProduct() async {
    return await apiClient.getData(Constants.RECOMMENDED_PRODUCT_URI);
  }
}
