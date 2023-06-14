import 'package:seller_emart/const/const.dart';

Widget productImage({required lable, onPress}){
  return "${lable}".text.bold.color(fontGrey).size(16.0).makeCentered().box.color(lightGrey).size(100, 100).rounded.make();
}