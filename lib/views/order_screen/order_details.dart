import 'package:get/get.dart';
import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';
import 'package:seller_emart/controllers/orders_controller.dart';
import 'package:seller_emart/views/order_screen/component/order_placed.dart';
import 'package:intl/intl.dart'as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({Key? key, this.data}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  var controller=Get.find<OrdersController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value=widget.data['order_confirmed'];
    controller.ondelivery.value=widget.data['order_on_delivery'];
    controller.delivered.value=widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: "Order Details", size: 18.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            child: Container(
              color: white,
              child: Center(
                  child: boldText(
                      text: "Confirm Order", size: 18.0, color: purpleColor)),
            ).onTap(() {
              controller.confirmed(true);
              controller.changeStatus(title: 'order_confirmed',status: true, docId: widget.data.id);
            }),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                20.heightBox,
                Visibility(
                  visible:controller.confirmed.value,
                  child: Column(
                    children: [
                      10.heightBox,
                      boldText(text: "Order Status",size: 16.0,color: purpleColor),
                      10.heightBox,
                      SwitchListTile(
                        value: true,
                        onChanged: (value) {},
                        title: boldText(text: "Placed", color: purpleColor),
                      ),
                      SwitchListTile(
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value=value;
                        },
                        title: boldText(text: "Confirmed", color: purpleColor),
                      ),
                      SwitchListTile(
                        value: controller.ondelivery.value,
                        onChanged: (value) {
                          controller.ondelivery.value=value;
                          controller.changeStatus(title: 'order_on_delivery',status: value, docId: widget.data.id);
                        },
                        title: boldText(text: "on Delivery", color: purpleColor),
                      ),
                      SwitchListTile(
                        value: controller.delivered.value,
                        onChanged: (value) {
                          controller.delivered.value=value;
                          controller.changeStatus(title: 'order_delivered',status: value, docId: widget.data.id);
                        },
                        title: boldText(text: "Delivered", color: purpleColor),
                      ),
                    ],
                  ).box.roundedSM.shadowSm.white.make(),
                ),
                20.heightBox,
                boldText(text: "Order Details",size: 16.0),
                //order details section
                Column(
                  children: [
                    orderPlacedDetails(
                        d1: "${widget.data['order_code']}",
                        d2: "${widget.data['shipping_method']}",
                        title1: "Order Code",
                        title2: "Shipping Method"),
                    orderPlacedDetails(
                        d1: intl.DateFormat().add_yMd().format(widget.data['order_date'].toDate()),
                        d2: "${widget.data['payment_method']}",
                        title1: "Order Date",
                        title2: "Payment Method"),
                    orderPlacedDetails(
                        d1: "UnPaid",
                        d2: "Order Placed",
                        title1: "Payment Status",
                        title2: "Delivery Status"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(
                                  text: "Shipping Address", color: purpleColor),
                              "${widget.data['order_by_name']}".text.make(),
                              "${widget.data['order_by_email']}".text.make(),
                              "${widget.data['order_by_address']}".text.make(),
                              "${widget.data['order_by_city']}".text.make(),
                              "${widget.data['order_by_state']}".text.make(),
                              "${widget.data['order_by_phone']}".text.make(),
                              "${widget.data['order_by_postalcode']}".text.make(),
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(
                                    text: "Total Amount", color: purpleColor),
                                boldText(text: "${widget.data['total_amount']}", color: red, size: 16.0)
                                // "Total Amount".text.fontFamily(semibold).make(),
                                // "{data['total_amount']}".numCurrency.text.color(redColor).fontFamily(semibold).make()
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ).box.roundedSM.shadowSm.white.make(),
                const Divider(
                  thickness: 2,
                ),
                20.heightBox,
                boldText(text: "Ordered Product", size: 16.0),
                10.heightBox,
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(controller.orders.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlacedDetails(
                            title1: "${controller.orders[index]['title']}",
                            title2: "${controller.orders[index]['tprice']}",
                            d1: "${controller.orders[index]['qty']}x",
                            d2: "Refundable"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            width: 30,
                            height: 10,
                            color: Color(controller.orders[index]['color']),
                          ),
                        ),
                        10.heightBox
                      ],
                    );
                  }).toList(),
                ).box.white.shadowSm.make(),
                30.heightBox
              ],
            ),
          ),
        ),
      ),
    );
  }
}
