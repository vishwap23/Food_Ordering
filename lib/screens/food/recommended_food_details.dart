import 'package:flutter/material.dart';
import 'package:food_ordering/controller/recommended_product_controller.dart';
import 'package:food_ordering/models/product.dart';
import 'package:food_ordering/routes/routes_helper.dart';
import 'package:food_ordering/utils/constants.dart';
import 'package:food_ordering/utils/dimensions.dart';
import 'package:food_ordering/widgets/app_icon.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:get/get.dart';

class RecommendedFoodDetails extends StatelessWidget {
  int pageId;

  RecommendedFoodDetails({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Products product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            collapsedHeight: 70,
            elevation: 0,
            toolbarHeight: 60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: AppIcon(icon: Icons.close, size: 40),
                  onTap: () {
                    Get.toNamed(RoutesHelper.getInitial());
                  },
                ),
                // BigText(
                //   text: product.name.toString(),
                //   size: 20,
                //   color: Colors.black,
                // ),
                AppIcon(icon: Icons.shopping_cart, size: 40)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20))),
                // padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
              ),
            ),
            pinned: true,
            expandedHeight: 270,
            backgroundColor: Colors.green,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                Constants.BASE_URL+"/uploads/"+product.img!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                BigText(text: product.name!,size: 20,color: Colors.green,),
                Container(
                  child: Text(product.description!),
                  padding: EdgeInsets.all(Dimensions.height20),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(top: Dimensions.height15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppIcon(
                icon: Icons.remove,
                iconColor: Colors.white,
                size: 40,
                backgroundColor: Colors.green,
              ),
              BigText(
                text: "\$ ${product.price} X 0 ",
                color: Colors.black54,
              ),
              AppIcon(
                icon: Icons.add,
                iconColor: Colors.white,
                size: 40,
                backgroundColor: Colors.green,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 120,
            padding: EdgeInsets.only(
                top: Dimensions.height10 * 3,
                bottom: Dimensions.height20,
                right: Dimensions.width20,
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
                  width: 70,
                  height: 55,
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.green,
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
                  child: BigText(
                    text: "Add to Cart",
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.green),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
