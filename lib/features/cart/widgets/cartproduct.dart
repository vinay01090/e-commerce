import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/features/product_detail/services/product_detail_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {

  final ProductDetailServices productDetailServices=ProductDetailServices(); 
  final CartServices cartServices=CartServices(); 

  void increaseQuantity(Product product){
     productDetailServices.addToCart(
      context: context, 
      product: product,
      ); 
  }

  void decreaseQuantity(Product product){
    cartServices.removeFromCart(
      context: context, 
      product: product,
      ); 
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity= productCart['quantity']; 

    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: width / 50),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitWidth,
                height: width / 4,
                width: width / 3,
              ),
              Container(
                width: width / 20,
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: width / 100, left: width / 20),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    height: width / 20,
                  ),
                  const Text(
                    'InStock',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          height: width / 80,
        ),

        Container(
          margin: EdgeInsets.all(width/40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: width/150,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () =>decreaseQuantity(product),
                      child: Container(
                        width: width/13,
                        height: width/20,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.remove,
                          size: width/30,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1.5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Container(
                        width: width/13,
                        height: width/15,
                        alignment: Alignment.center,
                        child: Text(
                          quantity.toString(),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()=>increaseQuantity(product),
                      child: Container(
                        width: width/13,
                        height: width/20,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add,
                          size: width/30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height:width/40,
        ),
      ],
    );
  }
}
