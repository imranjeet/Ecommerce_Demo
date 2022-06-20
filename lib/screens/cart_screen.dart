import 'package:ecom_app/models/cart_data.dart';
import 'package:ecom_app/providers/cart.dart';
import 'package:ecom_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../misc/colors.dart';
import '../widgets/app_large_text.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cartItems = Provider.of<Carts>(context, listen: false);
    var cart = cartItems.cartList.toList();
    var totalAmount = cartItems.totalAmount;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: "Cart",
          color: Colors.white,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.8,
            width: double.maxFinite,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: cartItems.itemCount,
                itemBuilder: (_, index) {
                  CartData crt = cart[index];
                  return Container(
                    height: size.height * 0.3,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                            text: crt.title,
                            size: 22,
                            // color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                  txt1: "Quantity:", txt2: "${crt.quantity}"),
                              SizedBox(height: size.height * 0.015),
                              TextWidget(
                                  txt1: "Price:",
                                  txt2: "${crt.price * crt.quantity}"),
                              SizedBox(height: size.height * 0.015),
                              TextWidget(txt1: "Size:", txt2: crt.size),
                              SizedBox(height: size.height * 0.015),
                              TextWidget(txt1: "Color:", txt2: crt.color),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              cartItems.deleteItem(index);
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete,
                                color: Colors.red, size: 25)),
                      ],
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Total Amount: $totalAmount",
                  style: const TextStyle(fontSize: 16)),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: AppColors.mainColor,
                child: const Text(
                  "Place Order",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.txt2,
    required this.txt1,
  }) : super(key: key);

  final String txt2;
  final String txt1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt1,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            txt2 == null ? "S" : txt2,
            style: const TextStyle(
              color: AppColors.mainTextColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
