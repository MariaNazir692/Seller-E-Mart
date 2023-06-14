import 'package:get/get.dart';
import 'package:seller_emart/common_widgets/customBtn.dart';
import 'package:seller_emart/common_widgets/loadingIndicator.dart';
import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';
import 'package:seller_emart/controllers/auth_constroller.dart';
import 'package:seller_emart/views/home_screen/home.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              20.heightBox,
              normalText(text: welcome, size: 18.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(
                    icLogo,
                    width: 70,
                    height: 70,
                  )
                      .box
                      .rounded
                      .border(color: white)
                      .padding(const EdgeInsets.all(10))
                      .make(),
                  10.widthBox,
                  boldText(text: appname, size: 20.0)
                ],
              ),
              20.heightBox,
              Obx(
                () => Column(
                  children: [
                    20.heightBox,
                    Align(
                        alignment: Alignment.center,
                        child: boldText(
                            text: loginTo, size: 18.0, color: purpleColor)),
                    40.heightBox,
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                          hintText: emailHint,
                          // border: InputBorder.none,
                          isDense: true,
                          fillColor: lightGrey,
                          filled: true,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: purpleColor),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: purpleColor,
                          )),
                    ),
                    20.heightBox,
                    TextFormField(
                      obscureText: true,
                      controller: controller.passController,
                      decoration: const InputDecoration(
                          hintText: passHint,
                          isDense: true,
                          fillColor: lightGrey,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: purpleColor),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: purpleColor,
                          )),
                    ),
                    10.heightBox,
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: normalText(
                                text: forgotPassword, color: purpleColor))),
                    SizedBox(
                      width: context.screenWidth - 100,
                      child: controller.isloading.value
                          ? Center(child: LoadingIndicator())
                          : CustomBtn(
                              title: login,
                              color: purpleColor,
                              onPress: () async {
                                controller.isloading(true);
                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    controller.isloading(false);
                                    Get.offAll(() => const Home());
                                  } else {
                                    controller.isloading(false);
                                    VxToast.show(context,
                                        msg: "SomethingWent Wrong");
                                  }
                                });
                                // Get.to(()=>const Home());
                              }),
                    ),
                    20.heightBox
                  ],
                )
                    .box
                    .rounded
                    .shadowSm
                    .white
                    .padding(const EdgeInsets.all(8))
                    .make(),
              ),
              20.heightBox,
              Align(
                  alignment: Alignment.center,
                  child: normalText(text: anyProblem)),
              const Spacer(),
              Center(
                child: normalText(text: credit),
              ),
              20.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
