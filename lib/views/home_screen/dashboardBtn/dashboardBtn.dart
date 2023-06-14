import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';

Widget DashboardBtn(context, {title,count ,icon}){
  var size=MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
          child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          normalText(text: title, size: 16.0),
          boldText(text: count, size: 20.0)
        ],
      )),
      Image.asset(icon, width: 40, color: Colors.white,)
    ],
  ).box.rounded.size(size.width*0.4, 80).shadowSm.color(purpleColor).padding(EdgeInsets.all(8)).make();
}