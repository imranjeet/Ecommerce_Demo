import 'package:flutter/material.dart';

import '../misc/colors.dart';
import '../providers/product.dart';
import '../screens/Selected_item_screen.dart';
import 'app_large_text.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.loadedProduct,
  }) : super(key: key);

  final Product loadedProduct;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SelectedItem(loadedProduct: loadedProduct)));
      },
      child: Container(
        height: size.height * 0.2,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppLargeText(
                text: loadedProduct.title,
                size: 22,
                // color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "unit price: ${loadedProduct.price}",
                    style: const TextStyle(
                      color: AppColors.mainTextColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    "special price: ${loadedProduct.sp}",
                    style: const TextStyle(
                      color: AppColors.mainTextColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Icon(Icons.shopping_cart, color: AppColors.mainColor),
            // ),
          ],
        ),
      ),
    );
  }
}
