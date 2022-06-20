import 'package:ecom_app/models/cart_data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Carts with ChangeNotifier {
  List _cartList = <CartData>[];
  List get cartList => _cartList;

  int get itemCount {
    return _cartList.length;
  }

  getItem() async {
    final box = await Hive.openBox<CartData>('cart');

    _cartList = box.values.toList();

    notifyListeners();
  }

  addItem(CartData item) async {
    var box = await Hive.openBox<CartData>('cart');

    box.add(item);

    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    for (var cartItem in _cartList) {
      total += cartItem.price * cartItem.quantity;
    }
    return total;
  }

  deleteItem(int index) {
    final box = Hive.box<CartData>('cart');

    box.deleteAt(index);

    getItem();

    notifyListeners();
  }

  updateItem(int index, CartData cartData) {
    final box = Hive.box<CartData>('cart');

    box.putAt(index, cartData);

    notifyListeners();
  }

  
}
