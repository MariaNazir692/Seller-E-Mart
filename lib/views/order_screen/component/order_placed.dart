import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';

Widget orderPlacedDetails({title1, title2, d1, d2}){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: "${title1}", color: fontGrey),
            boldText(text: "${d1}", color: red),
            // "$title1".text.fontFamily(semibold).make(),
            // "$d1".text.color(redColor).fontFamily(semibold).make()
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: "${title2}", color: fontGrey),
              boldText(text: "${d2}", color: fontGrey),
            ],),
        )
      ],
    ),
  );
}