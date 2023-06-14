import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_emart/const/const.dart';

import 'home_controller.dart';


class ChatsController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getChatId();
  }

  var chats=firestore.collection(chatCollection);

  var isLoading=false.obs;

  var friendName=Get.arguments[0];
  var friendId=Get.arguments[1];

  var senderName=Get.find<HomeController>().userName;
  var currentId=currentUser!.uid;

  var msgController=TextEditingController();

  dynamic chatDocId;

  getChatId()async{
    isLoading(true);
    await chats.where('users', isEqualTo: {
      friendId:null,
      currentId: null
    }).limit(1).get().then((QuerySnapshot snapshot){
      if(snapshot.docs.isNotEmpty){
        chatDocId=snapshot.docs.single.id;

      }else{
        chats.add({
          'created_on': null,
          'last_msg':'',
          'fromId': '',
          'toId':'',
          'users': {friendId: null, currentId: null},
          'friend_name': friendName,
          'sender_name':senderName,
        }).then((value){
          {
            chatDocId=value.id;
          }
        });
      }
    });
    isLoading(false);
  }

  sendMsg(String msg)async{
    if(msg.trim().isNotEmpty){
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg':msg,
        'toId': currentId,
        'fromId':friendId
      });

      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg':msg,
        'uid':currentId
      });
    }
  }

}