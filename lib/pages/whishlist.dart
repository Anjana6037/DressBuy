import 'package:ecomerseapp/pages/productdetail.dart';
import 'package:ecomerseapp/providers/wishlistprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 221, 13, 86),
        title: const Text(
          "My Wishlist",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
       
      ),
      body: wishlist.isEmpty
          ? const Center(
              child: Text(
                "wishlist is empty !",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final product = wishlist[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(
                      product.image ?? '',
                      width: 50,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      product.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      "₹${product.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Color.fromARGB(255, 221, 13, 86),
                      ),
                      onPressed: () {
                        ref
                            .read(wishlistProvider.notifier)
                            .removeFromWishlist(product);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
