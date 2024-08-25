import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';
import '../services/auth_services.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth_screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signUpUser() {
    AuthService().signUpUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );
  }

  void signInUser() {
    AuthService().signInUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final signinkey = GlobalKey<FormState>();
    final signupkey = GlobalKey<FormState>();

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height / 4,
                decoration: const BoxDecoration(
                  color: GlobalVariables.greyBackgroundCOlor,
                  image: DecorationImage(
                    image: AssetImage('assets/images/amzn1.png'),
                  ),
                ),
              ),
              Container(
                height: height / 10,
                decoration: BoxDecoration(
                  color: GlobalVariables.backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      height / 25,
                    ),
                    topRight: Radius.circular(height / 25),
                  ),
                ),
                child: TabBar(
                  labelPadding: EdgeInsets.only(top: height / 25),
                  indicator: UnderlineTabIndicator(
                    insets: EdgeInsets.only(
                      left: width / 10,
                      right: width / 10,
                    ),
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: height / 250,
                    ),
                  ),
                  controller: _tabController,
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    Tab(
                      height: height / 11,
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: height / 40),
                      ),
                    ),
                    Tab(
                      height: height / 11,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: height / 40),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: GlobalVariables.backgroundColor,
                height: height / 1.609,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Form(
                      key: signupkey,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: height / 20,
                              right: height / 20,
                              top: height / 30,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height / 20,
                                ),
                                CustomTextField(
                                  icon: const Icon(Icons.account_circle),
                                  controller: nameController,
                                  hintText: 'Name',
                                ),
                                SizedBox(
                                  height: height / 30,
                                ),
                                CustomTextField(
                                    icon: const Icon(Icons.mail),
                                    controller: emailController,
                                    hintText: 'Email'),
                                SizedBox(
                                  height: height / 30,
                                ),
                                CustomTextField(
                                  icon: const Icon(Icons.lock_outline_rounded),
                                  controller: passwordController,
                                  hintText: 'Password',
                                ),
                                SizedBox(
                                  height: height / 30,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height / 20,
                          ),
                          SizedBox(
                            width: width / 1.9,
                            height: height / 17,
                            child: ElevatedButton(
                              onPressed: () {
                                if (signupkey.currentState!.validate()) {
                                  signUpUser();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(height / 50),
                                  )),
                              child: Text('Create Account',
                                  style: TextStyle(fontSize: height / 45)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: signinkey,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: height / 20,
                              right: height / 20,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height / 10,
                                ),
                                CustomTextField(
                                  icon: const Icon(Icons.mail),
                                  controller: emailController,
                                  hintText: 'Email',
                                ),
                                SizedBox(
                                  height: height / 30,
                                ),
                                CustomTextField(
                                  icon: const Icon(Icons.lock_outline_rounded),
                                  controller: passwordController,
                                  hintText: 'Password',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height / 20,
                          ),
                          SizedBox(
                            width: width / 1.9,
                            height: height / 17,
                            child: ElevatedButton(
                              onPressed: () {
                                if (signinkey.currentState!.validate()) {
                                  signInUser();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(height / 50),
                                  )),
                              child: Text('Login',
                                  style: TextStyle(fontSize: height / 45)),
                            ),
                          ),
                        ],
                      ),
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
