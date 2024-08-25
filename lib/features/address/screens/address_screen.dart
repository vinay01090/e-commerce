import 'package:amazon_clone/common/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:amazon_clone/features/stripe/services/stripe_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import '../../../constants/utils.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final AddressServices addressServices = AddressServices();

  final _addressFormKey = GlobalKey<FormState>();
  List<PaymentItem> paymentItems = [];
  final String currency = "USD";


 @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }


  String addressTobeUsed = "";

  String getAddress(String address) {
    bool isForm = flatController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        townController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressTobeUsed =
            "${townController.text} - ${areaController.text} - ${flatController.text} - ${pincodeController.text}";
      } else {
        throw Exception('Please Enter all values');
      }
    } else {
      if (address.isNotEmpty) {
        addressTobeUsed = address;
      } else {
        showSnackBar(context, 'Error!');
      }
    }

    return addressTobeUsed;
  }

  @override
  void dispose() {
    super.dispose();
    flatController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    townController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().user;
    var address = context.watch<UserProvider>().user.address;
    var width = MediaQuery.of(context).size.width;
     int sum = 0;
     user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
         
      
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(width / 8),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(width / 20),
                child: Container(
                  padding: EdgeInsets.only(
                    left: width / 20,
                    right: width / 20,
                    top: width / 100,
                  ),
                  height: width / 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(width / 4),
                    ),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_city_sharp),
                      SizedBox(width: width / 90),
                      Text(
                        address,
                        style: TextStyle(
                          fontSize: width / 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: width / 30,
                ),
                child: Text(
                  'OR',
                  style: TextStyle(
                    fontSize: width / 25,
                  ),
                ),
              ),
            ],
          ),
          Form(
            key: _addressFormKey,
            child: Padding(
              padding: EdgeInsets.all(width / 20),
              child: Column(
                children: [
                  CustomTextField(
                    controller: flatController,
                    hintText: 'Flat,House No.,Building',
                    icon: const Icon(Icons.house_rounded),
                  ),
                  SizedBox(
                    height: width / 20,
                  ),
                  CustomTextField(
                    controller: areaController,
                    hintText: 'Area , Street',
                    icon: const Icon(Icons.streetview_rounded),
                  ),
                  SizedBox(
                    height: width / 20,
                  ),
                  CustomTextField(
                    controller: pincodeController,
                    hintText: 'PinCode',
                    icon: const Icon(Icons.code_sharp),
                  ),
                  SizedBox(
                    height: width / 20,
                  ),
                  CustomTextField(
                    controller: townController,
                    hintText: 'Town/City',
                    icon: const Icon(Icons.location_city_rounded),
                  ),
                  SizedBox(
                    height: width / 20,
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'pay',
            onTap: () async {
              await initPaymentSheet(
                  tAmount: sum, currency: currency, context: context);
              try {
                await Stripe.instance.presentPaymentSheet();
                Future.delayed(const Duration(seconds: 1));
                if (!context.mounted) {
                  return;
                }

                addressServices.placeOrder(
                  context: context,
                  address: getAddress(address),
                  totalSum: sum,
                );

                showSnackBar(context, 'payment Done');

              } catch (e) {
                Future.delayed(const Duration(seconds: 1));
                if (!context.mounted) {
                  return;
                }
                showSnackBar(context, 'payment Failed');
              }
            },
          ),
        ],
      ),
    );
  }
}
