import 'package:flutter/material.dart';
import 'package:food_ordering/controller/cart_controller.dart';
import 'package:food_ordering/controller/popular_product_controller.dart';
import 'package:food_ordering/models/product.dart';
import 'package:food_ordering/routes/routes_helper.dart';
import 'package:food_ordering/utils/constants.dart';
import 'package:food_ordering/utils/dimensions.dart';
import 'package:food_ordering/widgets/app_icon.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:food_ordering/widgets/expandable_text_widget.dart';
import 'package:food_ordering/widgets/icon_text_widget.dart';
import 'package:food_ordering/widgets/small_text.dart';
import 'package:get/get.dart';

class PopularFoodDetailsPage extends StatelessWidget {
  int pageId;

  PopularFoodDetailsPage({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Products product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    print("page id is $pageId");
    print("Product name is :${product.name}");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background Image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            Constants.BASE_URL + "/uploads/" + product.img!),
                        fit: BoxFit.cover)),
              )),
          //Icon widget app bar
          Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      child: AppIcon(icon: Icons.arrow_back, size: 40),
                      onTap: () {
                        Get.toNamed(RoutesHelper.getInitial());
                      }),
                  AppIcon(icon: Icons.shopping_cart_outlined, size: 40)
                ],
              )),
          //Review and food details
          Positioned(
              left: 0,
              right: 0,
              top: 300,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: product.name.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 15,
                                  )),
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        SmallText(text: "4.5"),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        SmallText(
                          text: "1287",
                          color: Colors.black87,
                        ),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        SmallText(text: "Comments")
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconTextWidget(
                            icon: Icons.circle_sharp,
                            text: "Normal",
                            textColor: Colors.black45,
                            iconColor: Colors.orange),
                        SizedBox(
                          width: Dimensions.width15,
                        ),
                        IconTextWidget(
                            icon: Icons.location_on_rounded,
                            text: "1.5 km",
                            textColor: Colors.black45,
                            iconColor: Colors.green),
                        SizedBox(
                          width: Dimensions.width15,
                        ),
                        IconTextWidget(
                            icon: Icons.access_time_outlined,
                            text: "30 min",
                            textColor: Colors.black45,
                            iconColor: Colors.red)
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(text: "introduce"),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableTextWidget(
                                text: product.description.toString())))
                  ],
                ),
              )),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
          height: 120,
          padding: EdgeInsets.only(
              top: Dimensions.height10 * 3,
              bottom: Dimensions.height20,
              right: Dimensions.height20,
              left: Dimensions.width20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2)),
            color: Colors.black12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                height: 55,
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.black45,
                      ),
                    ),
                    BigText(
                      text: popularProduct.inCartItems.toString(),
                      color: Colors.black87,
                    ),
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(true);
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.height20,
                    right: Dimensions.height20,
                    top: 17,
                    bottom: 17),
                child: GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: BigText(
                    text: "\$ ${product.price} | Add to Cart",
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.green),
              )
            ],
          ),
        );
      }),
    );
  }
}
