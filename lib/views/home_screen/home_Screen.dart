import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_emart/common_widgets/loadingIndicator.dart';
import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';
import 'package:seller_emart/services/storeservices.dart';
import 'package:seller_emart/views/home_screen/dashboardBtn/dashboardBtn.dart';
import 'package:seller_emart/views/product_screen/product_details.dart';
import '../../common_widgets/app_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(dashboard),
      body: StreamBuilder<QuerySnapshot>(
        stream: StoreSerivces.getProduct(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: normalText(text: "Not have any popular products"),
            );
          } else {
            var data = snapshot.data!.docs;
            data = data.sortedBy((a, b) =>
                b['p_wishlist'].length.compareTo(a['p_wishlist'].length));

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DashboardBtn(context, title: 'Products',
                          count: "${data.length}",
                          icon: icProducts),
                      FutureBuilder<QuerySnapshot>(
                        future: StoreSerivces.getOrders(currentUser!.uid),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
                          if (snapshot1.connectionState == ConnectionState.waiting) {
                            return DashboardBtn(context, title: 'Orders',
                                count: '0',
                                icon: icOrders);
                          } else if (!snapshot1.hasData || snapshot1.data!.docs.isEmpty) {
                            return DashboardBtn(context, title: 'Orders',
                                count: '0',
                                icon: icOrders);
                          } else {
                            var data1 = snapshot1.data!.docs;
                            return DashboardBtn(context, title: 'Orders',
                                count: '${data1.length}',
                                icon: icOrders);
                          }
                        },
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     DashboardBtn(context,
                  //         title: 'Rating', count: "60", icon: icStar),
                  //     DashboardBtn(context,
                  //         title: 'Total Sales', count: "60", icon: icTotalSales),
                  //   ],
                  // ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 10),
                  boldText(text: 'Popular Products', size: 18.0, color: fontGrey),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        if (data[index]['p_wishlist'].length == 0) {
                          return SizedBox();
                        } else {
                          return ListTile(
                            onTap: () {
                              Get.to(() => ProductDetails(data: data[index]));
                            },
                            leading: Image.network(
                              data[index]['p_images'][0],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            title: boldText(
                              text: "${data[index]['p_name']}",
                              color: fontGrey,
                            ),
                            subtitle: normalText(
                              text: "${data[index]['p_price']}",
                              color: red,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}








