import 'package:flutter/material.dart';
import 'package:food_ordering/controller/cart_controller.dart';
import 'package:food_ordering/data/repository/popular_product_repo.dart';
import 'package:food_ordering/models/product.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  late CartController _cartController;
  int _quantity = 0;

  int get quantity => _quantity;

  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    Response res = await popularProductRepo.getPopularProduct();
    print(
        "------------------------- ${res.status.connectionError} -------------------------");
    if (res.statusCode == 200) {
      print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(res.body).products);
      print("popular Product List : $_popularProductList");
      _isLoaded = true;
      update(); /*update() == setState()*/
    } else {
      print("error:");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      print("incremented $_quantity");
    } else {
      _quantity = checkQuantity(_quantity - 1);
      print("decremented $_quantity");
    }
    update();
  }

  checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item count", "You can't reduce more!",
          backgroundColor: Colors.green, colorText: Colors.white);
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item count", "You can't add more!",
          backgroundColor: Colors.green, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(Products product, CartController cartController) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;
    var exist = false;
    exist = _cartController.existInCart(product);
    //  if exist
    //  get from storage _inCartItem = 3
    print("exist oor not $exist");
    if (exist) {
      _inCartItems = _cartController.getQuantity(product);
    }
    print("The quantity in the cart is $_inCartItems}");
  }

  void addItem(Products product) {
    // if (_quantity > 0) {

      _cartController.addItem(product, _quantity);

      _quantity = 0;

      _inCartItems = _cartController.getQuantity(product);


      _cartController.items.forEach((key, value) {
        print("The id is ${value.id} and the quantity is ${value.quantity}");
      });
    // } else {
    //   Get.snackbar("Item count", "Please add at least one item",
    //       backgroundColor: Colors.green, colorText: Colors.white);
    // }
  }
}
