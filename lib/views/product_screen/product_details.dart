import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: "${data['p_name']}", size: 18.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VxSwiper.builder(
                autoPlay: true,
                height: 250,
                itemCount: data['p_images'].length,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                itemBuilder: (context, index) {
                  return Image.network(
                    data['p_images'][index],
                    width: double.infinity,
                    fit: BoxFit.fill,
                  );
                },
              ),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(text: "${data['p_name']}", size: 16.0),
                    10.heightBox,
                    Row(
                      children: [
                        boldText(text: "${data['p_category']}"),
                        10.widthBox,
                        normalText(text: "${data['p_subcategory']}",),

                      ],
                    ),
                    10.heightBox,
                    VxRating(
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      maxRating: 5,
                      stepInt: false,
                    ),
                    10.heightBox,
                    boldText(text: "\$${data['p_price']}", color: red, size: 16.0),
                    10.heightBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //         width: 100,
                        //         child:
                        //             boldText(text: "Color", color: fontGrey)),
                        //     // Row(
                        //     //   children: List.generate(
                        //     //     data['p_colors'].length,
                        //     //     (index) => VxBox()
                        //     //         .size(40, 40)
                        //     //         .roundedFull
                        //     //         .color(Color(data['p_colors'][index])
                        //     //         .withOpacity(1.0))
                        //     //         .margin(const EdgeInsets.symmetric(horizontal: 5))
                        //     //         .make()
                        //     //         .onTap(() {}),
                        //     //   ),
                        //     // )
                        //   ],
                        // ).box.padding(const EdgeInsets.all(12)).make(),
                        20.heightBox,
                        Row(
                          children: [
                            SizedBox(
                                width: 100,
                                child: boldText(
                                    text: "Quantity", color: fontGrey)),
                            normalText(text: "${data['p_quantity']} Items", color: fontGrey)
                          ],
                        ),
                      ],
                    )
                        .box
                        .white
                        .shadowSm
                        .rounded
                        .padding(const EdgeInsets.all(12))
                        .make(),
                    10.heightBox,
                    boldText(text: "Description", color: white),
                    10.heightBox,
                    normalText(
                        text:"${data['p_desc']}",
                        color: white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
