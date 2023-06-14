import 'package:get/get.dart';
import 'package:seller_emart/common_widgets/custom_textFormField.dart';
import 'package:seller_emart/common_widgets/loadingIndicator.dart';
import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';
import 'package:seller_emart/views/product_screen/component/product_dropdown.dart';
import 'package:seller_emart/views/product_screen/component/product_images.dart';

import '../../controllers/product_controller.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: "Add Product", size: 18.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              20.heightBox,
              boldText(text: "Enter Product Details", size: 16.0),
              20.heightBox,
              CustomTextFormField(
                  lable: "Product Name",
                  hint: "eg. BMW",
                  controller: controller.pnameController),
              10.heightBox,
              CustomTextFormField(
                  lable: "Description",
                  hint: "eg. This is description of product....",
                  isDesc: true,
                  controller: controller.pdescController),
              10.heightBox,
              CustomTextFormField(
                  lable: "Product Quantity",
                  hint: "eg. 20",
                  controller: controller.pquantityController),
              10.heightBox,
              CustomTextFormField(
                  lable: "Product Price",
                  hint: "eg. 20",
                  controller: controller.ppriceController),
              10.heightBox,
              Divider(
                color: white,
              ),
              10.heightBox,
              boldText(text: "Choose Product Category & Subcategory"),
              10.heightBox,
              ProductDropDown("Category", controller.categoryList,
                  controller.categoryValue, controller),
              10.heightBox,
              ProductDropDown("Sub Category", controller.subcategoryList,
                  controller.subcategoryValue, controller),
              10.heightBox,
              const Divider(
                color: white,
              ),
              boldText(text: "Choose Product Images.", size: 16.0),
              10.heightBox,
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    3,
                    (index) => controller.pImagesList[index] != null
                        ? Image.file(
                            controller.pImagesList[index],
                            width: 100,
                            height: 100,
                      fit: BoxFit.cover,
                          ).onTap(() {
                            controller.pickImage(index, context);
                          })
                        : productImage(lable: "${index + 1}").onTap(() {
                            controller.pickImage(index, context);
                          }),
                  ),
                ),
              ),
              10.heightBox,
              normalText(
                  text: "First Image will be displayed as display image."),
              10.heightBox,
              const Divider(
                color: white,
              ),
              // boldText(text: "Choose Product Color.", size: 16.0),
              // 10.heightBox,

              //for colors
              // Wrap(
              //   runSpacing: 8.0,
              //   spacing: 8.0,
              //   children: List.generate(
              //       9,
              //       (index) => Obx(
              //             () => Stack(
              //               alignment: Alignment.center,
              //               children: [
              //                 VxBox()
              //                     .color(Vx.randomPrimaryColor)
              //                     .roundedFull
              //                     .size(50, 50)
              //                     .make()
              //                     .onTap(() {
              //                   controller.selectedColorIndex.value = index;
              //                 }),
              //                 controller.selectedColorIndex.value == index
              //                     ? const Icon(
              //                         Icons.done,
              //                         color: white,
              //                       )
              //                     : SizedBox()
              //               ],
              //             ),
              //           )),
              // ),
              10.heightBox,
             controller.isloading.value?Center(child: LoadingIndicator(),): ElevatedButton(
                onPressed: () async{
                  controller.isloading(true);
                  if(controller.pnameController.text.isNotEmpty && controller.pdescController.text.isNotEmpty
                  && controller.pquantityController.text.isNotEmpty && controller.ppriceController.text.isNotEmpty
                  && controller.categoryValue.value.isNotEmpty && controller.subcategoryValue.value.isNotEmpty){
                    controller.isloading(true);
                    await controller.uploadImage();
                     controller.uploadProduct(context);
                     controller.resetControllers();
                    Get.back();
                  }else{
                    VxToast.show(context, msg: "Enter all the details of product");
                    controller.isloading(false);
                  }


                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: white,
                    shape: const StadiumBorder(),
                    fixedSize: Size(context.screenWidth - 100, 50)),
                child: boldText(text: "Save", color: purpleColor),
              ),
              20.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
