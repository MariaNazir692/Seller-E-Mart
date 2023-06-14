import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';

Widget CustomBtn({title, color,onPress,}){
  return ElevatedButton(onPressed: onPress,
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: StadiumBorder(),
        padding: EdgeInsets.all(12)
      ),
      child: "${title}".text.size(16).make()
  );
}