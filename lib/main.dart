import 'package:amazon_clone/common/bottom_navbar.dart';
import 'package:amazon_clone/features/Admin/Screen/adminscreen.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:amazon_clone/features/widgets/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './constants/global_variables.dart';
import './features/auth/screens/auth_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart'; 

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  Stripe.publishableKey='pk_test_51PbJXUAavzVbAJDfzkCkawlmdOtv2g8CiSogObv7NX5iIWOjNCYePKflFk5zxZwUKDj4cjKQWgcNUB8jjN86oFlm00cn3mkKJK'; 
  await Stripe.instance.applySettings();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    AuthService().fetchUserData(context); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty?
      Provider.of<UserProvider>(context).user.type=='admin'?const AdminScreen(): const BottomNavBar():const AuthScreen(),
    );
  }
}


// import 'package:amazon_clone/features/home/screen/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// void main() async{

//   WidgetsFlutterBinding.ensureInitialized();

//   Stripe.publishableKey = 'pk_test_51PbJXUAavzVbAJDfzkCkawlmdOtv2g8CiSogObv7NX5iIWOjNCYePKflFk5zxZwUKDj4cjKQWgcNUB8jjN86oFlm00cn3mkKJK';

//   await Stripe.instance.applySettings();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(

//         primarySwatch: Colors.blue,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }
