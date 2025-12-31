
import 'package:ecomerseapp/models/productmodel.dart';
import 'package:ecomerseapp/providers/cartprovider.dart';
import 'package:ecomerseapp/providers/wishlistprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ProductDetailPage extends ConsumerWidget {
  final Dress product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

     final isWishlisted = ref.watch(
      wishlistProvider.select(
        (list) => list.any((item) => item.id == product.id),
      ),
    );
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          product.title??'',style: TextStyle(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor:  const Color.fromARGB(255, 221, 13, 86),
      ),
      body: 
        Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// IMAGE
                Stack(
                  children:[ Center(
                    child: Image.network(
                      product.image??'',
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 6,right: 6,
                  
                            child:IconButton(
              onPressed: () {
                ref
                    .read(wishlistProvider.notifier)
                    .toggleWishlist(product);
              },
              icon: Icon(
                isWishlisted
                    ? Icons.favorite
                    : Icons.favorite_border,
                size: 26,
                color: const Color.fromARGB(255, 221, 13, 86),
              ),
            ),
                    )
                    ]

                ),
                const SizedBox(height: 20),
            
                /// TITLE
                Text(
                  product.title??'',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                const SizedBox(height: 10),
            
                /// PRICE
                Text(
                  "₹${product.price}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color:   const Color.fromARGB(255, 221, 13, 86),
                  ),
                ),
            
               
            
                /// CATEGORY
                Container(height: 280,width: 500,
                  child: Text(
                    "Category: ${product.description}",
                    style: const TextStyle(color: Color.fromARGB(255, 41, 40, 40)),
                  ),
                ),
            
                const SizedBox(height: 20),
            
                /// ACTION BUTTONS
              
                    
                       Padding(
                         padding: const EdgeInsets.all(8),
                         child: ElevatedButton(
                          onPressed: () {
                          ref.read(cartProvider.notifier).addToCart(product);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(backgroundColor: Color.fromARGB(255, 221, 13, 86),
        content: Text("Added to cart ",style: TextStyle(fontWeight: FontWeight.w600,color:Color.fromARGB(255, 255, 255, 255), ),),
        duration: Duration(seconds: 2),
      ),
    );
                          },
                          
                          child: const Text("Add to Cart",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(500, 50),
                            backgroundColor:
                                const Color.fromARGB(255, 221, 13, 86),
                          ),
                                           ),
                       ),
                    
                   
                  
                
              ],
            ),
          ),
        ),
      
    );
  }
}
