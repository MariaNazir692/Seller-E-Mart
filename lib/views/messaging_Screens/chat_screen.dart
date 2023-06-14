import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';
import 'package:seller_emart/controllers/chat_controller.dart';
import 'package:seller_emart/services/storeservices.dart';
import 'package:seller_emart/views/messaging_Screens/component/msg_bubble.dart';

import '../../common_widgets/loadingIndicator.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller=Get.put(ChatsController());

    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: "Chats", size: 18.0),
      ),

      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(()=>
            controller.isLoading.value?Center(
                child:normalText(text: "Send a Message....")
            ):Expanded(
              child: StreamBuilder(
                stream: StoreSerivces.getChatMsgs(controller.chatDocId.toString()),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                    return LoadingIndicator();
                  }else if(snapshot.data!.docs.isEmpty){
                    return Center(
                      child:normalText(text: "Send a Message....") ,
                    );
                  }else{
                    return ListView(
                      children:snapshot.data!.docs.mapIndexed((currentValue, index){
                        var data=snapshot.data!.docs[index];
                        return Align(
                            alignment: data['uid']==currentUser!.uid?Alignment.centerRight:Alignment.centerLeft,
                            child: ChatBubble(data));
                      }).toList(),
                    );
                  }

                },
              ),
            ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                      controller: controller.msgController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: textfieldGrey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: textfieldGrey)),
                          hintText: "Type a message....", hintStyle: TextStyle(
                        color: darkGrey
                      ),
                      ),
                    )
                ),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: white,
                    ))
              ],
            )
                .box
                .height(80)
                .padding(EdgeInsets.all(12))
                .margin(EdgeInsets.only(bottom: 10))
                .make()
          ],
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     children: [
      //       Expanded(
      //           child: ListView.builder(
      //             itemCount: 30,
      //               itemBuilder: (context, index){
      //               return ChatBubble();
      //               }
      //           )
      //       ),
      //       10.heightBox,
      //       SizedBox(
      //         child:  Row(
      //           children: [
      //             Expanded(
      //                 child: TextFormField(
      //                   decoration: const InputDecoration(
      //                     isDense: true,
      //                     enabledBorder:OutlineInputBorder(
      //                         borderSide: BorderSide(color: white)
      //                     ),
      //                       focusedBorder: OutlineInputBorder(
      //                           borderSide: BorderSide(color: white)
      //                       ),
      //                       hintText: "Type a message....",
      //                   hintStyle: TextStyle(color: lightGrey)),
      //                 )),
      //             IconButton(
      //                 onPressed: () {},
      //                 icon: const Icon(
      //                   Icons.send,
      //                   color: white,
      //                   size: 30,
      //                 ))
      //           ],
      //         )
      //             // .box.white
      //             // .margin(const EdgeInsets.only(bottom: 10))
      //             // .make(),
      //
      //       )
      //
      //     ],
      //   ),
      // ),

    );
  }
}
