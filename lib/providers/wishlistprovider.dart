
import 'package:ecomerseapp/models/productmodel.dart';

import 'package:flutter_riverpod/legacy.dart';


class WishlistNotifier extends StateNotifier<List<Dress>> {
  WishlistNotifier() : super([]);

  bool isInWishlist(Dress product) {
    return state.any((item) => item.id == product.id);
  }

  void toggleWishlist(Dress product) {
    if (isInWishlist(product)) {
      state = state.where((item) => item.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }

  void removeFromWishlist(Dress product) {
    state = state.where((item) => item.id != product.id).toList();
  }

  void clearWishlist() {
    state = [];
  }
}

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, List<Dress>>(
  (ref) => WishlistNotifier(),
);
