import 'package:food_ordering/utils/constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = "";
    _mainHeaders = {
      'content-type': 'application/json; charset = UTF-8 ',
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri) async {
    try {
      Response res = await get(uri);

      print("URI : ${uri}");

      print("Response : ${res.hasError}");

      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
