import 'package:seller_emart/const/const.dart';

class StoreSerivces {
  static getProfile(uid) {
    print(uid);
    return firestore
        .collection(vendorCollection)
        .where('id', isEqualTo: uid)
        .get();
  }

  static getMessages(uid) {
    return firestore
        .collection(chatCollection)
        .where('toId', isEqualTo: uid)
        .snapshots();
  }

  static getOrders(uid) {
    return firestore
        .collection(ordersCollection)
        .where('vendors', arrayContains: uid).get();
        // .snapshots();
  }

  static getProduct(uid) {
    return firestore
        .collection(productsCollection)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }


  //for msgs
  static getChatMsgs(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  //
  // static getPopularProducts(uid) async {
  //   await firestore
  //       .collection(productsCollection)
  //       .where('vendor_id', isEqualTo: uid)
  //       .orderBy('p_wishlist'.length);
  // }
}
