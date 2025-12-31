import 'package:ecomerseapp/models/cartmodel.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/productmodel.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Dress product) {
    final index =
        state.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      state[index].quantity++;
      state = [...state];
    } else {
      state = [...state, CartItem(product: product)];
    }
  }

  void removeFromCart(CartItem item) {
    state = state.where((i) => i != item).toList();
  }

  void increment(CartItem item) {
    item.quantity++;
    state = [...state];
  }

  void decrement(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      state = [...state];
    }
  }

  double get totalAmount {
    double total = 0;
    for (var item in state) {
      total += (item.product.price ?? 0) * item.quantity;
    }
    return total;
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);
