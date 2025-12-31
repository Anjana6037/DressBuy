
import 'package:flutter_riverpod/legacy.dart';

final selectedCategoryProvider =
    StateProvider<String>((ref) => 'All');

final categories = [
  "All",
  "Women",
  "Men",
  "Electronics",
  "Jewelery",
];

final categoryImages = [
  "assets/cat2.jpg",
  "assets/cat1.jpg",
  "assets/cat4.jpg",
  "assets/cat3.jpg",
  "assets/cat5.jpg",
];
