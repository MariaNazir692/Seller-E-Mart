import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';
import 'package:intl/intl.dart'as intl;

AppBar AppBarWidget(title){
  return AppBar(
    backgroundColor: white,
    automaticallyImplyLeading: false,
    title: boldText(text: title,color: purpleColor, size: 20.0),
    actions: [
      Center(child: boldText(text: intl.DateFormat("EEE, MMM d, y").format(DateTime.now(), ), color: purpleColor )),
      10.widthBox
    ],
  );
}