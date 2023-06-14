import 'package:seller_emart/const/const.dart';

Widget LoadingIndicator(){
  return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(red)
  );
}