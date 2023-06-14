import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_emart/common_widgets/loadingIndicator.dart';
import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';
import 'package:seller_emart/controllers/auth_constroller.dart';
import 'package:seller_emart/controllers/profile_controller.dart';
import 'package:seller_emart/services/storeservices.dart';
import 'package:seller_emart/views/auth_screen/login_screen.dart';
import 'package:seller_emart/views/messaging_Screens/messages_screen.dart';
import 'package:seller_emart/views/setting_Screen/profile_setting.dart';
import 'package:seller_emart/views/setting_Screen/shop_setting_screen.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller=Get.put(ProfileController());

    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: "Account", size: 20.0),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() =>  ProfileSettingScreen(username: controller.docSnapshot['vendor_name'],));
              },
              icon: const Icon(Icons.edit)),
          IconButton(onPressed: () {
            Get.find<AuthController>().signOutMethod(context);
            Get.offAll(()=>const LogInScreen());

          }, icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: FutureBuilder(
        future: StoreSerivces.getProfile(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: LoadingIndicator(),);
          }
          else{
            controller.docSnapshot=snapshot.data!.docs[0];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: controller.docSnapshot['imageUrl']==''? Image.asset(
                      imgProduct,width: 70,fit: BoxFit.cover,)
                        .box
                        .clip(Clip.antiAlias)
                        .roundedFull
                        .make():
                    Image.network(controller.docSnapshot['imageUrl'],width: 70,fit: BoxFit.cover,)
                        .box
                        .clip(Clip.antiAlias)
                        .roundedFull
                        .make(),
                    title: boldText(text: "${controller.docSnapshot['vendor_name']}"),
                    subtitle: normalText(text: "${controller.docSnapshot['email']}"),
                  ),
                  const Divider(
                    color: white,
                  ),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List.generate(
                          profileBtnTitles.length,
                              (index) => ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => const ShopSettingScreen());
                                  break;
                                case 1:
                                  Get.to(() =>  MessagesScreen());
                                  break;
                                default:
                              }
                            },
                            leading: Icon(
                              profileBtnIcons[index],
                              color: purpleColor,
                            ),
                            title: boldText(
                                text: profileBtnTitles[index],
                                color: purpleColor),
                            trailing: const Icon(
                              (Icons.arrow_forward_rounded),
                              color: purpleColor,
                            ),
                          )),
                    ).box.rounded.white.make(),
                  )
                ],
              ),
            );
          }
        },
      ),

    );
  }
}
