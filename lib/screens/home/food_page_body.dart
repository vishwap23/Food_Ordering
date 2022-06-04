import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/controller/popular_product_controller.dart';
import 'package:food_ordering/controller/recommended_product_controller.dart';
import 'package:food_ordering/routes/routes_helper.dart';
import 'package:food_ordering/screens/food/popular_food_details_page.dart';
import 'package:food_ordering/utils/constants.dart';
import 'package:food_ordering/utils/dimensions.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:food_ordering/widgets/icon_text_widget.dart';
import 'package:food_ordering/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../models/product.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.82);
  var _currPageValue = 0.0;
  double height = Dimensions.containerHeight;
  final double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        print("Current Value is $_currPageValue");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //popular food
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : CircularProgressIndicator();
        }),
        //dots
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return DotsIndicator(
            dotsCount: popularProduct.popularProductList.isEmpty
                ? 1
                : popularProduct.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: Colors.red,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //recommendedvheading
        Container(
            margin: EdgeInsets.all(Dimensions.width20),
            child: Row(
              children: [
                BigText(text: "Recommended"),
                SizedBox(
                  width: 5,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5, left: 5),
                  child: BigText(
                    text: ".",
                    color: Colors.black26,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, left: 5),
                    child: SmallText(text: "Food Pairing")),
              ],
            )),
        //recommended food list
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    Products recommendedProductModel;
                    recommendedProductModel =
                        recommendedProduct.recommendedProductList[index];

                    print("${recommendedProductModel.name}");
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutesHelper.getRecommendedFood(index));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.height20,
                            right: Dimensions.height20,
                            bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.red,
                                  image: DecorationImage(
                                      image: NetworkImage(Constants.BASE_URL +
                                          "/uploads/" +
                                          recommendedProductModel.img!),
                                      fit: BoxFit.cover)),
                              width: Dimensions.listViewImg,
                              height: Dimensions.listViewImg,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 3),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.height10,
                                      right: Dimensions.height10),
                                  child: Column(
                                    children: [
                                      BigText(
                                          text: recommendedProductModel.name!),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SmallText(
                                          text: recommendedProductModel
                                              .description!),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconTextWidget(
                                              iconSize: Dimensions.radius20,
                                              icon: Icons.circle_sharp,
                                              text: "Normal",
                                              textColor: Colors.black45,
                                              iconColor: Colors.orange),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          IconTextWidget(
                                              iconSize: Dimensions.radius20,
                                              icon: Icons.location_on_rounded,
                                              text: "1.5km",
                                              textColor: Colors.black45,
                                              iconColor: Colors.green),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          IconTextWidget(
                                              iconSize: Dimensions.radius20,
                                              icon: Icons.access_time_outlined,
                                              text: "30min",
                                              textColor: Colors.black45,
                                              iconColor: Colors.red)
                                        ],
                                      )
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ),
                                height: 110,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            Dimensions.radius20),
                                        bottomRight: Radius.circular(
                                            Dimensions.radius20))),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, Products popularProduct) {
    Matrix4 matrix4 = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RoutesHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.containerHeight,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        Constants.BASE_URL + "/uploads/" + popularProduct.img!),
                  ),
                  color: Color(0xFF69c5df)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.textContainerHeight,
              margin: EdgeInsets.only(left: 25, right: 25, bottom: 35),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: popularProduct.name!),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: Dimensions.height15,
                                  )),
                        ),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        SmallText(text: "4.5"),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        SmallText(
                          text: "1287",
                          color: Colors.black87,
                        ),
                        SizedBox(
                          width: Dimensions.height10 / 2,
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
                          width: Dimensions.height10,
                        ),
                        IconTextWidget(
                            icon: Icons.location_on_rounded,
                            text: "1.5 km",
                            textColor: Colors.black45,
                            iconColor: Colors.green),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        IconTextWidget(
                            icon: Icons.access_time_outlined,
                            text: "30 min",
                            textColor: Colors.black45,
                            iconColor: Colors.red)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
