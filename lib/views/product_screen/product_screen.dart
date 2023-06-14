import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_emart/common_widgets/loadingIndicator.dart';
import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';
import 'package:seller_emart/controllers/product_controller.dart';
import 'package:seller_emart/services/storeservices.dart';
import 'package:seller_emart/views/product_screen/add_product.dart';
import 'package:seller_emart/views/product_screen/product_details.dart';
import '../../common_widgets/app_bar_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProductController());

    return Scaffold(
      backgroundColor: purpleColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await controller.getCategories();
          controller.populateCategoryList();
          controller.resetControllers();
          Get.to(() => const AddProductScreen());
        },
        backgroundColor: white,
        child: const Icon(
          Icons.add,
          color: purpleColor,
        ),
      ),
      appBar: AppBarWidget(products),
      body: StreamBuilder(
        stream: StoreSerivces.getProduct(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LoadingIndicator(),);
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: normalText(text: "No Products are added yet...."),);
          } else {
            var data=snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                        (index) =>
                        ListTile(
                          onTap: () {
                            Get.to(() =>  ProductDetails(data: data[index],));
                          },
                          leading: Image.network(
                            data[index]['p_images'][0],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          title: boldText(text: "${data[index]['p_name']}", color: white),
                          subtitle: Row(
                            children: [
                              normalText(text: "\$${data[index]['p_price']}", color: red),
                              10.widthBox,
                              normalText(text:data[index]['is_featured']? "Featured":'', color: green),
                            ],
                          ),
                          trailing: VxPopupMenu(
                            clickType: VxClickType.singleClick,
                            menuBuilder: () =>
                                Column(
                                  children: List.generate(
                                      popupMenuListTitles.length,
                                          (i) =>
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Icon(popupMenuListIcons[i],
                                                color: data[index]['featured_id']==currentUser!.uid && i==0? green: darkGrey,),
                                                10.widthBox,
                                                normalText(
                                                    text: data[index]['featured_id']==currentUser!.uid && i==0?'Remove Feature':popupMenuListTitles[i],
                                                    color: darkGrey)
                                              ],
                                            ).onTap(()async {
                                              switch(i){
                                                case 0:
                                                  if(data[index]['is_featured']==true){
                                                    await controller.removeFeaturProduct(data[index].id);
                                                    VxToast.show(context, msg: "Remove from Featured Product");
                                                  }else{
                                                    await controller.addFeaturedProduct(data[index].id);
                                                    VxToast.show(context, msg: "Added to Featured Product");
                                                  }
                                                  break;
                                                case 1:
                                                  controller.removeProduct(data[index].id);
                                                  VxToast.show(context, msg: "Product Removes");
                                                  break;
                                                default:
                                              }
                                            }),
                                          )),
                                ).box.white
                                    .width(200)
                                    .rounded
                                    .make(),
                            child: const Icon(
                              Icons.more_vert_rounded,
                              color: white,
                            ),
                          ),
                        ),
                  ),
                ),
              ),
            );

        }

        },
      ),

    );
  }
}
