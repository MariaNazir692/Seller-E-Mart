import 'package:get/get.dart';
import 'package:seller_emart/common_widgets/custom_textFormField.dart';
import 'package:seller_emart/common_widgets/loadingIndicator.dart';
import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';
import 'package:seller_emart/controllers/profile_controller.dart';
import 'package:seller_emart/views/profile_screen/profile_screen.dart';

class ShopSettingScreen extends StatelessWidget {
  const ShopSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: setting, size: 18.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                30.heightBox,
                Align(
                    alignment: Alignment.center,
                    child: boldText(text: "Edit Shop Settings", size: 18.0)),
                20.heightBox,
                CustomTextFormField(
                    lable: shopName,
                    hint: nameHint,
                    controller: controller.shopNameController),
                10.heightBox,
                CustomTextFormField(
                    lable: address,
                    hint: shopAddressHint,
                    controller: controller.shopAddressController),
                10.heightBox,
                CustomTextFormField(
                    lable: mobile,
                    hint: shopMobileHint,
                    controller: controller.shopMobileController),
                10.heightBox,
                CustomTextFormField(
                    lable: website,
                    hint: shopWebHint,
                    controller: controller.shopWebsiteController),
                10.heightBox,
                CustomTextFormField(
                    lable: description,
                    hint: shopDiscHint,
                    isDesc: true,
                    controller: controller.shopDescController),
                20.heightBox,
                controller.isloading.value
                    ? Center(
                        child: LoadingIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          controller.isloading(true);
                          if (controller.shopNameController.text.isNotEmpty &&
                              controller.shopAddressController.text.isNotEmpty &&
                          controller.shopMobileController.text.isNotEmpty &&
                          controller.shopWebsiteController.text.isNotEmpty &&
                          controller.shopDescController.text.isNotEmpty){
                            await controller.updateShop(
                                shopName: controller.shopNameController.text,
                                shopAddress:
                                controller.shopAddressController.text,
                                shopDesc: controller.shopDescController.text,
                                shopMobile:
                                controller.shopMobileController.text,
                                shopWebsite:
                                controller.shopWebsiteController.text);
                            VxToast.show(context, msg: "Shop is updated");
                            controller.isloading(false);
                            Get.off(()=>ProfileScreen());
                          }else{
                            VxToast.show(context, msg: "All fields are required");
                            controller.isloading(false);
                          }

                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: white,
                            shape: const StadiumBorder(),
                            fixedSize: Size(context.screenWidth - 100, 50)),
                        child: boldText(text: "Save", color: purpleColor),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
