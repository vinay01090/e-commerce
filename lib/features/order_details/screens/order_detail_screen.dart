import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                  height: width / 8,
                  margin: EdgeInsets.only(left: 15, top: width / 25),
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
                  top: width / 30,
                  left: width / 50,
                ),
                child: const Icon(Icons.mic),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width / 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'View Order Details',
                style: TextStyle(
                  fontSize: width / 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.all(width / 50),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Date   :  ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}',
                    ),
                    Text(
                      'Order ID        :   ${widget.order.id}',
                    ),
                    Text(
                      'Order Total   : \$ ${widget.order.totalPrice.toDouble()}',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: width / 50,
              ),
              Text(
                'Purchase Details',
                style: TextStyle(
                  fontSize: width / 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height:width/4,
                width:width,
                padding: EdgeInsets.all(width / 50),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  children: [
                   ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.order.products.length,
                    itemBuilder: (context,index){
                      return Column(
                        children: [
                          Image.network(widget.order.products[index].images[0]),
                      ],
                      ); 
                            
                    },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
