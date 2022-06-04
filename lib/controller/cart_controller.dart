import 'package:flutter/material.dart';
import 'package:food_ordering/data/repository/cart_repo.dart';
import 'package:food_ordering/models/cart_model.dart';
import 'package:food_ordering/models/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  void addItem(Products product, int quantity) {
    var totalQuantity = 0;

    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString());

      });
      if(totalQuantity <=0){
        _items.remove(product.id);
      }
    } else {
      print("length of the  items is ${_items.length}");
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          print(
              "adding item to the cart ${product.id} and quantity is $quantity");
          _items.forEach((key, value) {
            print("quantity is ${value.quantity}");
          });
          return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString());
        });
      } else {
        Get.snackbar("Item count", "Please add at least one item",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    }
  }

  bool existInCart(Products product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(Products product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }
}
