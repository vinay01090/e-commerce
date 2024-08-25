import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/home/services/homeservices.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/categoryDeals';
  final String category;
  const CategoryDealsScreen({Key?key, required this.category}):super(key:key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

@override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height / 13),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(width / 20),
                  child: Text(
                    'Keep shopping for ${widget.category}',
                    style: TextStyle(
                      fontSize: width / 20,
                    ),
                  ),
                ),
                Container(
                  height: height / 4,
                  padding:EdgeInsets.only(left:width/20),
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.6,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final currProduct = productList![index];
                      return Column(
                        children: [
                          SizedBox(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(width / 100),
                                child: Image.network(
                                  currProduct.images[0],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: height / 80,
                              right: width / 40,
                            ),
                            child: Text(
                              currProduct.name,
                              maxLines: 1,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}