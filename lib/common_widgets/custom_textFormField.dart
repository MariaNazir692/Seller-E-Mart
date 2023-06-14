import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';

Widget CustomTextFormField({lable, hint, controller, isDesc=false}){
  return TextFormField(
    controller: controller,
    style: TextStyle(color: white),
    maxLines: isDesc? 4:1,
    decoration: InputDecoration(
      label: normalText(text: lable,),
      hintText: hint,
      hintStyle: TextStyle(
        color: lightGrey
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: white
          )
      ),
      focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: white
          )
      )
    ) ,
  );


}