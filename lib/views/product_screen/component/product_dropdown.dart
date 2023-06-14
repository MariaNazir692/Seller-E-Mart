import 'package:get/get.dart';
import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';
import 'package:seller_emart/controllers/product_controller.dart';

Widget ProductDropDown(hint, List<String>list, dropValue, ProductController controller){
  return Obx(()=>
    SizedBox(
      width: 300,
      child: DropdownButtonHideUnderline(
          child: DropdownButton(
            borderRadius: BorderRadius.circular(20),
            isExpanded:false,
            isDense: false,
            hint: normalText(text: "$hint", color: fontGrey),
            value: dropValue.value==''?null:dropValue.value,
            onChanged: (newvalue){
              if(hint=="Category"){
                controller.subcategoryValue.value='';
                controller.populateSubCategory(newvalue.toString());
              }
              dropValue.value=newvalue.toString();
            },
            items: list.map((e){
              return DropdownMenuItem(child: e.toString().text.make(), value: e,);
            }).toList(),

          )
      ).box.padding(EdgeInsets.symmetric(horizontal: 4)).white.rounded.make(),
    ),
  );
}