import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

import '../misc/colors.dart';
import '../models/cart_data.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../widgets/app_large_text.dart';
import '../widgets/app_text.dart';
import 'cart_screen.dart';

class SelectedItem extends StatefulWidget {
  const SelectedItem({
    Key? key,
    required this.loadedProduct,
  }) : super(key: key);

  final Product loadedProduct;

  @override
  State<SelectedItem> createState() => _SelectedItemState();
}

class _SelectedItemState extends State<SelectedItem> {
  int count = 1;
  String sizeValue = 'S';
  String colorValue = 'Red';
  List<S2Choice<String>> sizes = [
    S2Choice<String>(value: 'flu', title: 'S'),
    S2Choice<String>(value: 'ion', title: 'M'),
    S2Choice<String>(value: 'rel', title: 'L'),
    S2Choice<String>(value: 'tur', title: 'XL'),
  ];
  List<S2Choice<String>> colors = [
    S2Choice<String>(value: 'red', title: 'Red'),
    S2Choice<String>(value: 'white', title: 'White'),
    S2Choice<String>(value: 'black', title: 'Black'),
    S2Choice<String>(value: 'yellow', title: 'Yellow'),
  ];

  void addQuantity() {
    setState(() {
      count += 1;
    });
  }

  void decreaseQuantity() {
    setState(() {
      count -= 1;
    });
  }

  final snackBar = SnackBar(
    content: const Text('Successfully added to cart.'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {},
    ),
  );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cartDb = Provider.of<Carts>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: AppText(text: "Details", color: Colors.white),
        backgroundColor: AppColors.mainColor,
      ),
      body: Container(
        height: size.height * 0.5,
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
                text: widget.loadedProduct.title,
                size: 22,
                // color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "unit price: ${widget.loadedProduct.price}",
                    style: const TextStyle(
                      color: AppColors.mainTextColor,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    "special price: ${widget.loadedProduct.sp}",
                    style: const TextStyle(
                      color: AppColors.mainTextColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SmartSelect<String>.single(
                title: 'Choose Size:',
                value: sizeValue,
                choiceItems: sizes,
                onChange: (state) {
                  setState(() {
                    sizeValue = state.value;
                  });
                }),
            SmartSelect<String>.single(
                title: 'Choose color:',
                value: colorValue,
                choiceItems: colors,
                onChange: (state) {
                  setState(() {
                    colorValue = state.value;
                  });
                }),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    "Quantity:",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: size.width * 0.3),
                  IconButton(
                      onPressed: () {
                        count == 1 ? "" : decreaseQuantity();
                      },
                      icon: Icon(Icons.remove,
                          color: count == 1 ? Colors.grey : AppColors.mainColor,
                          size: 25)),
                  SizedBox(width: size.width * 0.01),
                  Text(
                    "$count",
                    style: const TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: size.width * 0.01),
                  IconButton(
                      onPressed: () {
                        addQuantity();
                      },
                      icon: const Icon(Icons.add,
                          color: AppColors.mainColor, size: 25))
                ])
                // child:
                //     Icon(Icons.shopping_cart, color: AppColors.mainColor),

                ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: AppColors.mainColor,
              child: const Text(
                "Add to Cart",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await cartDb.addItem(CartData(
                  id: int.parse(widget.loadedProduct.id),
                  title: widget.loadedProduct.title,
                  quantity: count,
                  price: int.parse(widget.loadedProduct.sp),
                  size: sizeValue,
                  color: colorValue,
                ));
                cartDb.getItem();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
