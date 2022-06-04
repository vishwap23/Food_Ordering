import 'package:food_ordering/data/api/api_client.dart';
import 'package:food_ordering/utils/constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient}) ;

  Future<Response> getPopularProduct() async {
    return await apiClient.getData(Constants.POPULAR_PRODUCT_URI);
  }
}
