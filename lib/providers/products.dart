import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import '../models/http_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
 
  List<Product> get items {
    
    return [..._items];
  }

  // List<Product> get favoriteItems {
  //   return _items.where((prodItem) => prodItem.isFavorite).toList();
  // }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }


  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    var url =
        Uri.parse('https://mocki.io/v1/26ca1ca6-332a-46fe-9df8-392d87a0ecf2');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body)['product_list'];
      final List<Product> loadedProducts = [];
      // print(extractedData);
      extractedData.forEach((prodData) {
        loadedProducts.add(Product(
          id: prodData['id'].toString(),
          title: prodData['name'],
          price: prodData['unitprice'].toString(),
          sp: prodData['sp'].toString(),
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      log(error.toString());
      throw (error);
    }
  }

  
}
