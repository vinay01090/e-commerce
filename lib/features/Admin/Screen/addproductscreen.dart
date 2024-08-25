import 'dart:io';
import 'package:amazon_clone/common/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/features/Admin/Services/adminservices.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/addProductScreen';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        name: nameController.text,
        description: descriptionController.text,
        images: images,
        quantity: double.parse(quantityController.text),
        price: double.parse(priceController.text),
        category: category,
      );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height / 15),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Container(
            padding: EdgeInsets.only(
              left: width / 15,
            ),
            child: Text(
              'Add Product',
              style: TextStyle(
                color: Colors.black,
                fontSize: width / 19,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: EdgeInsets.all(width / 25),
            child: Column(
              children: [
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((i) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 220,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 220,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(width / 20),
                          child: Container(
                            width: width,
                            height: height / 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width / 40),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.folder_open_rounded),
                                SizedBox(height: height / 40),
                                const Text('Select Product Image'),
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: height / 30,
                ),
                CustomTextField(
                  controller: nameController,
                  hintText: 'Product Name',
                  icon: const Icon(Icons.emoji_objects_outlined),
                ),
                SizedBox(
                  height: height / 30,
                ),
                TextField(
                  controller: descriptionController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    prefixIconColor: Colors.black45,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                        left: width / 20,
                        right: width / 20,
                        bottom: height / 7,
                      ),
                      child: const Icon(Icons.description_rounded),
                    ),
                    fillColor: GlobalVariables.greyBackgroundCOlor,
                    filled: true,
                    hintText: 'Product Description',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(height / 60),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(height / 60),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(height / 50),
                      borderSide: const BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  maxLines: 7,
                ),
                SizedBox(
                  height: height / 30,
                ),
                CustomTextField(
                  controller: quantityController,
                  hintText: 'Product quantity',
                  icon: const Icon(Icons.production_quantity_limits_rounded),
                ),
                SizedBox(
                  height: height / 30,
                ),
                CustomTextField(
                  controller: priceController,
                  hintText: 'Product price',
                  icon: const Icon(Icons.production_quantity_limits_rounded),
                ),
                SizedBox(
                  height: height / 30,
                ),
                SizedBox(
                  width: width,
                  child: DropdownButton(
                    value: category,
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category=newVal!; 
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: height / 20,
                ),
                CustomButton(
                  text: 'SellProduct',
                  onTap: sellProduct,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
