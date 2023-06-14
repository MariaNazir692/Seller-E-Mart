import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:seller_emart/const/const.dart';
import 'package:get/get.dart';
import 'package:seller_emart/views/auth_screen/login_screen.dart';
import 'package:seller_emart/views/home_screen/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  var isLoggedIn=false;

  checkUser(){
      auth.authStateChanges().listen((User? user) {
        if(user==null && mounted){
          isLoggedIn=false;
        }else{
          isLoggedIn=true;
        }
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent, elevation: 0),
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn? const Home():const LogInScreen(),
    );
  }
}
