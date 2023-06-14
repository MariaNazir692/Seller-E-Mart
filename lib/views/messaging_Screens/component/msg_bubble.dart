import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_emart/const/const.dart';
import 'package:intl/intl.dart'as intl;

Widget ChatBubble(DocumentSnapshot data){


  var t= data['created_on']== null? DateTime.now():data['created_on'].toDate();
  var time=intl.DateFormat("h:mma").format(t);
  return  Directionality(
    textDirection: data['uid']==currentUser!.uid? TextDirection.rtl:TextDirection.ltr,
    // textDirection: TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration:  BoxDecoration(
        color: data['uid']==currentUser!.uid?Colors.redAccent: darkGrey ,
        // color: white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['msg']}".text.color(white).size(15).make(),
          10.heightBox,
          time.text.color(purpleColor.withOpacity(1)).make(),
        ],
      ),
    ),
  );

}