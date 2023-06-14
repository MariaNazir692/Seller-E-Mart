import 'package:get/get.dart';
import 'package:seller_emart/const/const.dart';
import 'package:seller_emart/controllers/home_controller.dart';
import 'package:seller_emart/views/home_screen/home_Screen.dart';
import 'package:seller_emart/views/product_screen/product_screen.dart';
import '../../common_widgets/exitdialog.dart';
import '../order_screen/order_screen.dart';
import '../profile_screen/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller=Get.put(HomeController());
    var bottomNavBar=[
      const BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: dashboard),
      BottomNavigationBarItem(icon: Image.asset(icProducts, width: 24, color: darkGrey,), label: products),
      BottomNavigationBarItem(icon: Image.asset(icOrders,width: 24, color: darkGrey,),label: orders),
      BottomNavigationBarItem(icon: Icon(Icons.person),label: profile),
    ];
    var navScreen=[
      const HomeScreen(),
      const ProductScreen(),
      const OrderScreen(),
      const ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: ()async{
        showDialog(
          //so that dialog not closed automatically
            barrierDismissible: false,
            context: context, builder:(context)=>ExitDialog(context));
        return false;

      },
      child: Scaffold(
        bottomNavigationBar: Obx(()=>
          BottomNavigationBar(
            onTap: (index){
              controller.navIndx.value=index;
            },
            currentIndex: controller.navIndx.value,
            type: BottomNavigationBarType.shifting,
            selectedItemColor: purpleColor,
            unselectedItemColor: darkGrey,
            items: bottomNavBar,
          ),
        ),
        body: Column(
          children: [
            Obx(()=> Expanded(child: navScreen.elementAt(controller.navIndx.value)))

          ],
        ),
      ),
    );
  }
}
