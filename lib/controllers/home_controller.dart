import 'package:get/get.dart';
import 'package:seller_emart/const/const.dart';

class HomeController extends GetxController {


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserName();
  }

  var navIndx = 0.obs;

  var userName = '';

  getUserName() async {
    var n = await firestore
        .collection(vendorCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
          if(value.docs.isNotEmpty){
            return value.docs.single['vendor_name'];
          }
    });
   userName=n;

  }




}
