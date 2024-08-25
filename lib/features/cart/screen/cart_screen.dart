import 'package:amazon_clone/common/custom_button.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:amazon_clone/features/cart/widgets/cardsubtotal.dart';
import 'package:amazon_clone/features/cart/widgets/cartproduct.dart';
import 'package:amazon_clone/features/home/widgets/addressbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  void navigateToAddressScreen(int sum){
    Navigator.pushNamed(context,AddressScreen.routeName,arguments:sum.toString() ); 
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height / 12),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: height / 20,
                  margin: EdgeInsets.only(left: 15, top: height / 50),
                  child: Material(
                    borderRadius: BorderRadius.all(
                      Radius.circular(width / 5),
                    ),
                    elevation: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(
                  top: height / 40,
                  left: width / 50,
                ),
                child: const Icon(Icons.mic),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBar(height: width / 11),
            const CardSubTotal(),
            Padding(
              padding: EdgeInsets.all(width / 40),
              child: CustomButton(
                text: 'Proceed to Buy ${user.cart.length} items',
                onTap: ()=>navigateToAddressScreen(sum),
                color: Colors.yellow,
              ),
            ),
            SizedBox(
              height: width / 80,
            ),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: width / 200,
            ),
            SizedBox(
              height: width / 40,
            ),
            ListView.builder(
              itemCount: user.cart.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
