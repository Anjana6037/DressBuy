import 'package:ecomerseapp/Services/API.dart';
import 'package:ecomerseapp/models/productmodel.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final productServiceProvider =
    Provider<ProductService>((ref) => ProductService());

final dressProvider = FutureProvider<List<Dress>>((ref) {
  return ref.read(productServiceProvider).fetchProducts();
});
