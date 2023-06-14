import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_emart/common_widgets/loadingIndicator.dart';
import 'package:seller_emart/const/const.dart';
import 'package:seller_emart/controllers/orders_controller.dart';
import 'package:seller_emart/services/storeservices.dart';
import 'package:seller_emart/views/order_screen/order_details.dart';

import '../../common_widgets/app_bar_widget.dart';
import '../../common_widgets/textStyles.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());

    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBarWidget(orders),
      body: StreamBuilder(
        stream: StoreSerivces.getOrders(currentUser!.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LoadingIndicator(),);
          }else if(snapshot.data!.docs.isEmpty){
            return Center(child: normalText(text: "No Orders yet....."));
          } else {
            var data=snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                        (index){
                      var time=data[index]['order_date'].toDate();
                      return  ListTile(
                        onTap: () {
                          Get.to(() => OrderDetails(data: data[index]));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        // leading: Image.network(
                        //   data[index]['img'],
                        //   width: 100,
                        //   height: 100,
                        //   fit: BoxFit.cover,
                        // ),
                        title: boldText(
                            text: "${data[index]['order_code']}", color: purpleColor),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month, color: fontGrey,),
                                10.widthBox,
                                boldText(
                                    text: intl.DateFormat().add_yMd().format(
                                        time), color: darkGrey),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.payment, color: fontGrey,),
                                10.widthBox,
                                normalText(text: "Unpaid", color: red),
                              ],
                            ),
                          ],
                        ),
                        trailing: boldText(
                            text: "${data[index]['total_amount']}", color: purpleColor, size: 15.0),
                      ).box
                          .margin(const EdgeInsets.only(bottom: 4))
                          .shadowSm
                          .rounded
                          .white
                          .make();
                        }

                  ),
                ),
              ),
            );
        }
        },
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: SingleChildScrollView(
      //     physics: const BouncingScrollPhysics(),
      //     child: Column(
      //       children: List.generate(
      //         20,
      //         (index) => ListTile(
      //           onTap: () {
      //             Get.to(()=>const OrderDetails());
      //           },
      //           // tileColor: textfieldGrey,
      //           shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(15)),
      //           leading: Image.asset(
      //             imgProduct,
      //             width: 100,
      //             height: 100,
      //             fit: BoxFit.cover,
      //           ),
      //           title: boldText(text: "123456567", color: purpleColor),
      //           subtitle: Column(
      //             children: [
      //               Row(
      //                 children: [
      //                   const Icon(Icons.calendar_month, color: fontGrey,),
      //                   10.widthBox,
      //                   boldText(text: intl.DateFormat().add_yMd().format(DateTime.now()),color: darkGrey),
      //                 ],
      //               ),
      //               Row(
      //                 children: [
      //                   const Icon(Icons.payment, color: fontGrey,),
      //                   10.widthBox,
      //                   normalText(text: "Unpaid", color: red),
      //                 ],
      //               ),
      //             ],
      //           ),
      //           trailing: boldText(text: "\$400", color: purpleColor, size: 15.0),
      //         ).box.margin(const EdgeInsets.only(bottom: 4)).shadowSm.rounded.white.make(),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
