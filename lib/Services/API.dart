import 'dart:convert';
import 'package:ecomerseapp/models/productmodel.dart';
import 'package:http/http.dart' as http;


class ProductService {
  Future<List<Dress>> fetchProducts() async {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Dress.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}
