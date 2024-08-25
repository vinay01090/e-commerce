import 'package:amazon_clone/common/custom_button.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/ratings.dart';
import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:amazon_clone/features/product_detail/services/product_detail_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName='/product-details'; 
  final Product product; 
  const ProductDetailScreen({super.key,required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final ProductDetailServices productDetailServices=ProductDetailServices(); 
  double  avgRating=0; 
  double myRating=0; 

  @override
  void initState(){
    super.initState(); 
    double totalRating=0; 
    for(int i=0; i<widget.product.rating!.length; i++){
      totalRating+=widget.product.rating![i].rating; 
      if(widget.product.rating![i].userId==Provider.of<UserProvider>(context,listen:false).user.id){
          myRating=widget.product.rating![i].rating; 
      }
    }

    if(totalRating!=0){
      avgRating=totalRating/widget.product.rating!.length; 
    }

  }

  void addToCart(){
    productDetailServices.addToCart(
      context: context,
       product: widget.product,); 
  }


  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height; 
    var width=MediaQuery.of(context).size.width; 
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
                      // onFieldSubmitted: navigateToSearchScreen,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(width/40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                  ),
                  Stars(
                    rating: avgRating,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height/60,
                horizontal: height/60,
              ),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: height/4,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: height/3,
              ),
            ),
            Container(
              color: Colors.black12,
              height: width/70,
            ),
            Padding(
              padding: EdgeInsets.all(width/40),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price: ',
                  style:  TextStyle(
                    fontSize: width/28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '\$${widget.product.price}',
                      style:  TextStyle(
                        fontSize: width/21,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width/50),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: width/70,
            ),
            Padding(
              padding: EdgeInsets.all(width/40),
              child: CustomButton(
                text: 'Buy Now',
                onTap: () {},
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(width/40),
              child: CustomButton(
                text: 'Add to Cart',
                onTap: addToCart,
                color: const Color.fromRGBO(254, 216, 19, 1),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/40),
              child: Text(
                'Rate The Product',
                style: TextStyle(
                  fontSize: width/20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                productDetailServices.rateProduct(
                  context: context,
                  product: widget.product,
                  rating: rating,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}