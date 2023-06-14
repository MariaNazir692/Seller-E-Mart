import 'package:flutter/services.dart';
import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';

Widget ExitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        boldText(text: "Confirm",color: darkGrey),
        const Divider(),
        10.heightBox,
        normalText(text: "Are you sure to want to exit", color: darkGrey),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: (){SystemNavigator.pop();},
                child: normalText(text: "Yes"),
              style: ElevatedButton.styleFrom(
                backgroundColor: purpleColor
              ),
            ),
            ElevatedButton(
              onPressed: (){Navigator.pop(context);},
              child: normalText(text: "No"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: purpleColor
              ),
            )
          ],

        )

      ],
    ).box.roundedSM.padding(EdgeInsets.all(12)).color(lightGrey).make(),
  );
}