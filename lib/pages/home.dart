import 'package:ecomerseapp/pages/cart.dart';
import 'package:ecomerseapp/pages/whishlist.dart';
import 'package:ecomerseapp/pages/productdetail.dart';
import 'package:ecomerseapp/providers/categoryprovider.dart';
import 'package:ecomerseapp/providers/homeprovider.dart';
import 'package:ecomerseapp/providers/searchprovider.dart';
import 'package:ecomerseapp/providers/wishlistprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchfocusnode = FocusNode();

  @override
  void dispose() {
    searchController.dispose();
    searchfocusnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dressAsync = ref.watch(dressProvider);
    final Scaffoldkey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: Colors.white,
      key: Scaffoldkey,
      drawer: Drawer(
        width: 250,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 13, 86),
              ),
              child: Center(
                child: Text(
                  "Hi,user",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_bag,
                color: const Color.fromARGB(255, 221, 13, 86),
              ),
              title: Text(
                "Shopping Cart",
                style: TextStyle(color: const Color.fromARGB(255, 221, 13, 86)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cart()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.person,
                color: const Color.fromARGB(255, 221, 13, 86),
              ),
              title: Text(
                "Profile",
                style: TextStyle(color: const Color.fromARGB(255, 221, 13, 86)),
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: const Color.fromARGB(255, 221, 13, 86),
              ),
              title: Text(
                "Settings",
                style: TextStyle(color: const Color.fromARGB(255, 221, 13, 86)),
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.language,
                color: const Color.fromARGB(255, 221, 13, 86),
              ),
              title: Text(
                "Language",
                style: TextStyle(color: const Color.fromARGB(255, 221, 13, 86)),
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.privacy_tip_outlined,
                color: const Color.fromARGB(255, 221, 13, 86),
              ),
              title: Text(
                "Privacy and Support",
                style: TextStyle(color: const Color.fromARGB(255, 221, 13, 86)),
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.notification_important_rounded,
                color: const Color.fromARGB(255, 221, 13, 86),
              ),
              title: Text(
                "Notifications",
                style: TextStyle(color: const Color.fromARGB(255, 221, 13, 86)),
              ),
              onTap: () {},
            ),
            Divider(),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Column(
          children: [
            AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 221, 13, 86),
              title: const Text(
                "Hi, User",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WishlistPage()),
                    );
                  },
                  icon: const Icon(Icons.favorite, size: 28),
                ),
                SizedBox(width: 2),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cart()),
                    );
                  },
                  icon: Icon(Icons.shopping_bag, size: 28),
                ),
                SizedBox(width: 2),
              ],
            ),
            Container(
              height: 65,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: const Color.fromARGB(255, 221, 13, 86),

              child: TextField(
                controller: searchController,
                focusNode: searchfocusnode,
                autofocus: false,
                enabled: true,
                onChanged: (value) {
                  print("search typed:$value");
                  ref.read(searchQueryProvider.notifier).state = value
                      .trim()
                      .toLowerCase();
                },
                decoration: InputDecoration(
                  hintText: "Search products...",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        slivers: [
         
          SliverToBoxAdapter(
            child: SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final selectedcategory = ref.watch(selectedCategoryProvider);
                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedCategoryProvider.notifier).state =
                          categories[index];
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,

                            backgroundImage: AssetImage(categoryImages[index]),
                          ),

                          Flexible(
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                fontWeight:
                                    selectedcategory == categories[index]
                                    ? FontWeight.w900
                                    : FontWeight.normal,
                                fontSize: selectedcategory == categories[index]
                                    ? 17
                                    : 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          dressAsync.when(
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),

            error: (error, _) => SliverToBoxAdapter(
              child: Center(child: Text(error.toString())),
            ),

            data: (products) {
              final searchQuery = ref.watch(searchQueryProvider).toLowerCase();
              final selectedcategory = ref.watch(selectedCategoryProvider);

              final filteredproducts = products.where((product) {
                final category = product.category ?? '';
                final title = product.title?.toLowerCase() ?? '';

                bool categoryMatch =
                    selectedcategory == "All" ||
                    (selectedcategory == "Men" &&
                        category.contains("men's clothing")) ||
                    (selectedcategory == "Women" &&
                        category.contains("women's clothing")) ||
                    (selectedcategory == "Electronics" &&
                        category.contains("electronics")) ||
                    (selectedcategory == "Jewelery" &&
                        category.contains("jewelery"));

                bool searchMatch =
                    searchQuery.isEmpty || title.contains(searchQuery);

                return categoryMatch && searchMatch;
              }).toList();
              return SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = filteredproducts[index];
                    final isWishlisted = ref.watch(
                      wishlistProvider.select(
                        (list) => list.any((item) => item.id == product.id),
                      ),
                    );
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: product),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Card(
                            elevation: 2,
                            color: const Color.fromARGB(225, 255, 255, 255),
                            child: Padding(
                              padding: const EdgeInsets.all(18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      product.image ?? '',
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      product.title ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      "₹${product.price}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 6,
                            right: 6,

                            child: IconButton(
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
                          ),
                        ],
                      ),
                    );
                  }, childCount: filteredproducts.length),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
