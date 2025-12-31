import 'productmodel.dart';

class CartItem {
  final Dress product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}
