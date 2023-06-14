import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_emart/common_widgets/textStyles.dart';
import 'package:seller_emart/const/const.dart';
import 'package:seller_emart/services/storeservices.dart';
import 'package:seller_emart/views/messaging_Screens/chat_screen.dart';

import '../../common_widgets/loadingIndicator.dart';
import 'package:intl/intl.dart'as intl;

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(
          text: messages,
          size: 18.0,
        ),
      ),
      body: StreamBuilder(
        stream: StoreSerivces.getMessages(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoadingIndicator(),
            );
          } if(snapshot.data!.docs.isEmpty){
            return Center(child: normalText(text: "No Messages yet....."));
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) {
                      var t=data[index]['created_on']==null?DateTime.now(): data[index]['created_on'].toDate();
                      var time=intl.DateFormat("h:mma").format(t);
                      return ListTile(
                        onTap: () {
                          Get.to(() => ChatScreen(), arguments: [
                            data[index]['friend_name'],data[index]['toId']
                          ]);
                        },
                        leading: const CircleAvatar(
                            backgroundColor: white,
                            child: Icon(
                              Icons.person,
                              color: purpleColor,
                            )),
                        title: boldText(text: "${data[index]['sender_name']}"),
                        subtitle: normalText(
                          text: "${data[index]['last_msg']}",
                        ),
                        trailing: normalText(text: time),
                      );
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
      //       children: List.generate(20, (index) => ListTile(
      //         onTap: (){
      //           Get.to(()=>const ChatScreen());
      //         },
      //         leading: const CircleAvatar(
      //           backgroundColor: white,
      //             child: Icon(Icons.person,color: purpleColor,)
      //         ),
      //         title: boldText(text: "Username"),
      //         subtitle: normalText(text: "Last msg here...", ),
      //         trailing: normalText(text: "10:45M"),
      //
      //       )),
      //
      //     ),
      //   ),
      // ),
    );
  }
}
