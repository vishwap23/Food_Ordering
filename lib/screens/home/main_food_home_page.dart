import 'package:flutter/material.dart';
import 'package:food_ordering/utils/dimensions.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:food_ordering/widgets/small_text.dart';
import 'food_page_body.dart';

class MainFoodHomePage extends StatefulWidget {
  const MainFoodHomePage({Key? key}) : super(key: key);

  @override
  State<MainFoodHomePage> createState() => _MainFoodHomePageState();
}

class _MainFoodHomePageState extends State<MainFoodHomePage> {
  @override
  Widget build(BuildContext context) {
    print(
        "Media height and width ${MediaQuery.of(context).size.height} and ${MediaQuery.of(context).size.width}");
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin:  EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
            padding:  EdgeInsets.only(right: Dimensions.height20, left: Dimensions.width20),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const BigText(
                        text: "country",
                        color: Colors.green,
                      ),
                      InkWell(
                        child: Row(
                          children: [
                            const SmallText(
                              text: "city",
                              color: Colors.black45,
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      height: Dimensions.height45,
                      width: Dimensions.width45,
                      child: Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: Dimensions.iconSize24,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(child: SingleChildScrollView(child: FoodPageBody()))
        ],
      ),
    );
  }
}
