import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/widgets/addressbar.dart';
import 'package:amazon_clone/features/home/widgets/carouselimage.dart';
import 'package:amazon_clone/features/home/widgets/dealoftheday.dart';
import 'package:amazon_clone/features/home/widgets/top_categories.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context,SearchScreen.routeName,arguments: query); 
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
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
                      onFieldSubmitted: navigateToSearchScreen,
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
            AddressBar(
              height: height / 20,
            ),
            SizedBox(
              height: height / 60,
            ),
            const TopCategories(),
            SizedBox(
              height: height / 50,
            ),
            CarouselImage(
              height: height / 30,
              width: width / 2.1,
            ),
            SizedBox(
              height:height/50,
            ),
            DealofTheDay(
              height:height/4,
            ),
          ],
        ),
      ),
    );
  }
}
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_stripe/flutter_stripe.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   Map<String, dynamic>? paymentIntentData;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stripe Tutorial'),
//       ),
//       body: Center(
//         child: InkWell(
//           onTap: () async {
//             // final paymentMethod = await Stripe.instance.createPaymentMethod(
//             //     params: const PaymentMethodParams.card(
//             //         paymentMethodData: PaymentMethodData()));
//             await makePayment();
//           },
//           child: Container(
//             height: 50,
//             width: 200,
//             color: Colors.green,
//             child: const Center(
//               child: Text(
//                 'Pay',
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> makePayment() async {
//     try {
//       paymentIntentData =
//           await createPaymentIntent('20', 'USD'); //json.decode(response.body);
//       // print('Response body==>${response.body.toString()}');
//       await Stripe.instance
//           .initPaymentSheet(
//               paymentSheetParameters: SetupPaymentSheetParameters(
//                   setupIntentClientSecret: 'sk_test_51PbJXUAavzVbAJDfI8E0vL6h3FIO00dGyk7f1xPiK1jZTLgH0peZg1lTEw4ycVCZXK9Yx8WE93sgqk6mdvGyLXyQ00O7llED8M',
//                   paymentIntentClientSecret:
//                       paymentIntentData!['client_secret'],
//                   //applePay: PaymentSheetApplePay.,
//                   //googlePay: true,
//                   //testEnv: true,
//                   customFlow: true,
//                   style: ThemeMode.dark,
//                   // merchantCountryCode: 'US',
//                   merchantDisplayName: 'Kashif'))
//           .then((value) {});

//       ///now finally display payment sheeet
//       displayPaymentSheet();
//     } catch (e, s) {
//       print('Payment exception:$e$s');
//     }
//   }

//   displayPaymentSheet() async {
//     try {
//       await Stripe.instance
//           .presentPaymentSheet(
//               //       parameters: PresentPaymentSheetParameters(
//               // clientSecret: paymentIntentData!['client_secret'],
//               // confirmPayment: true,
//               // )
//               )
//           .then((newValue) {
//         print('payment intent' + paymentIntentData!['id'].toString());
//         print(
//             'payment intent' + paymentIntentData!['client_secret'].toString());
//         print('payment intent' + paymentIntentData!['amount'].toString());
//         print('payment intent' + paymentIntentData.toString());
//         //orderPlaceApi(paymentIntentData!['id'].toString());
//         ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text("paid successfully")));

//         paymentIntentData = null;
//       }).onError((error, stackTrace) {
//         print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
//       });
//     } on StripeException catch (e) {
//       print('Exception/DISPLAYPAYMENTSHEET==> $e');
//       showDialog(
//           context: context,
//           builder: (_) => const AlertDialog(
//                 content: Text("Cancelled "),
//               ));
//     } catch (e) {
//       print('$e');
//     }
//   }

//   //  Future<Map<String, dynamic>>
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount('20'),
//         'currency': currency,
//         'payment_method_types[]': 'card',
//       };
//       print(body);
//       var response = await http.post(
//           Uri.parse('https://api.stripe.com/v1/payment_intents'),
//           body: body,
//           headers: {
//             'Authorization': 'Bearer sk_test_51PbJXUAavzVbAJDfI8E0vL6h3FIO00dGyk7f1xPiK1jZTLgH0peZg1lTEw4ycVCZXK9Yx8WE93sgqk6mdvGyLXyQ00O7llED8M',
//           'Content-Type': 'application/x-www-form-urlencoded',
//             'Content-Type': 'application/x-www-form-urlencoded'
//           });
//       print('Create Intent reponse ===> ${response.body.toString()}');
//       return jsonDecode(response.body);
//     } catch (err) {
//       print('err charging user: ${err.toString()}');
//     }
//   }

//   calculateAmount(String amount) {
//     final a = (int.parse(amount)) * 100;
//     return a.toString();
//   }
// }