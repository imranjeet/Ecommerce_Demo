import 'dart:developer';

import 'package:ecom_app/misc/colors.dart';
import 'package:ecom_app/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import '../widgets/badge.dart';
import '../widgets/product_list.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var cartItems = Provider.of<Carts>(context, listen: false).getItem();
    return Scaffold(
      appBar: AppBar(
        title: AppText(text: "Ecommerce App", color: Colors.white),
        backgroundColor: AppColors.mainColor,
        actions: [
          
          Consumer<Carts>(
            builder: (_, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              color: Colors.red,
              child: ch!,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
               
                Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const CartScreen()));
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: Future.wait([
            Provider.of<Products>(context, listen: false).fetchAndSetProducts(),
          ]),
          builder: (
            ctx,
            dataSnapshot,
          ) {
            try {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Theme(
                  data: ThemeData.light(),
                  child: const CupertinoActivityIndicator(
                    animating: true,
                    radius: 20,
                  ),
                ));

                // } else if (dataSnapshot.hasData == null) {
                //   return EmptyBoxScreen();
              } else {
                var loadedProducts = Provider.of<Products>(
                  context,
                  listen: false,
                ).items;
                return ListView.builder(
                  itemCount: loadedProducts.length,
                  itemBuilder: (_, index) {
                    var loadedProduct = Provider.of<Products>(
                      context,
                      listen: false,
                    ).items[index];
                    return ProductList(loadedProduct: loadedProduct);
                  },
                );
              }
            } catch (error) {
              log(error.toString());
              return AlertDialog(
                title: const Text('An error occurred!'),
                content: const Text('Something went wrong.'),
                actions: [
                  FlatButton(
                    child: const Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              );
            }
          }),
    );
  }
}
