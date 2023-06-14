import 'dart:io';
import 'package:get/get.dart';
import 'package:seller_emart/common_widgets/loadingIndicator.dart';
import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';
import 'package:seller_emart/controllers/profile_controller.dart';
import 'package:seller_emart/views/profile_screen/profile_screen.dart';
import '../../common_widgets/custom_textFormField.dart';

class ProfileSettingScreen extends StatefulWidget {
  final String? username;

  const ProfileSettingScreen({Key? key, this.username}) : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller.nameController.text = widget.username!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: editProfile, size: 18.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () => Column(
            children: [
              controller.docSnapshot['imageUrl'] == ' ' &&
                      controller.profileImagePath.isEmpty
                  ? Image.asset(
                      imgProduct,
                      fit: BoxFit.cover,
                      width: 70,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : controller.docSnapshot['imageUrl'] != '' &&
                          controller.profileImagePath.isEmpty
                      ? Image.network(
                          controller.docSnapshot['imageUrl'],
                          fit: BoxFit.cover,
                          width: 70,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImagePath.value),
                          fit: BoxFit.cover,
                          width: 70,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              ElevatedButton(
                onPressed: () {
                  controller.changeImage(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: white, shape: const StadiumBorder()),
                child: boldText(text: changImage, color: purpleColor),
              ),
              const Divider(
                color: white,
              ),
              10.heightBox,

              CustomTextFormField(
                  lable: name,
                  hint: nameHint,
                  controller: controller.nameController),
              10.heightBox,
              CustomTextFormField(
                  lable: password,
                  hint: passHint,
                  controller: controller.oldpassController),
              10.heightBox,
              CustomTextFormField(
                  lable: confirmPassword,
                  hint: passHint,
                  controller: controller.newpassController),
              20.heightBox,
              controller.isloading.value
                  ? Center(child: LoadingIndicator())
                  : ElevatedButton(
                      onPressed: () async {
                        controller.isloading(true);
                        //if user change image
                        if (controller.profileImagePath.value.isNotEmpty) {
                          await controller.UploadProfileImage();
                        } else {
                          controller.profileImageDownloadLink =
                              controller.docSnapshot['photoUrl'];
                        }
                        //if user change password
                        if (controller.docSnapshot['password'] ==
                            controller.oldpassController.text) {
                          await controller.changeAuthPassword(
                              email: controller.docSnapshot['email'],
                              password: controller.oldpassController.text,
                              newPassword: controller.newpassController.text);
                          await controller.updateProfile(
                              imageUrl: controller.profileImageDownloadLink,
                              name: controller.nameController.text,
                              password: controller.newpassController.text);
                          VxToast.show(context, msg: "Profile Updated");
                          Get.to(() => const ProfileScreen());
                        }
                        //if User change only image and user name
                        else if (controller
                                .oldpassController.text.isEmptyOrNull &&
                            controller.newpassController.text.isEmptyOrNull) {
                          print(controller.nameController.text);
                          await controller.updateProfile(
                              imageUrl: controller.profileImageDownloadLink,
                              name: controller.nameController.text,
                              password: controller.docSnapshot['password']);
                          VxToast.show(context, msg: "Profile Updated");
                          Get.to(() => const ProfileScreen());
                        } else {
                          VxToast.show(context,
                              msg: "Something Went Wrong....");
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
    );
  }
}
