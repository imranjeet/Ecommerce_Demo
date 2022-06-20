import 'package:hive/hive.dart';

 part 'cart_data.g.dart';

@HiveType(typeId: 0)
class CartData {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int quantity;
  @HiveField(3)
  final int price;
  @HiveField(4)
  final String size;
  @HiveField(5)
  final String color;

  CartData({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.size, 
    required this.color
  });
}
