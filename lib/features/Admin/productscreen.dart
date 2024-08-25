import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/Admin/Screen/addproductscreen.dart';
import 'package:amazon_clone/features/Admin/Services/adminservices.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product>? products = [];
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProductScreen() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final currProduct = products![index];
                return Container(
                  padding: EdgeInsets.only(
                      top: width / 20, left: width / 20, right: width / 20),
                  height: height / 8,
                  width: width / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(width / 30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(width / 20),
                          ),
                        ),
                        child: Image.network(
                          currProduct.images[0],
                          fit: BoxFit.contain,
                          height: height / 6,
                          width: width / 1.1,
                        ),
                      ),
                      SizedBox(height: height / 200),
                      Row(
                        children: [
                          SizedBox(width: width / 40),
                          Expanded(
                            child: Text(
                              currProduct.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(width: width / 40),
                          IconButton(
                            onPressed: () => deleteProduct(currProduct, index),
                            icon: const Icon(
                              Icons.delete_outline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigateToAddProductScreen();
              },
              tooltip: 'Add a Product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
