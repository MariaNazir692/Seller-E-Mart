import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_emart/const/const.dart';

class ProfileController extends GetxController{

  var profileImagePath=''.obs;
  var nameController=TextEditingController();
  var oldpassController=TextEditingController();
  var newpassController=TextEditingController();
  var profileImageDownloadLink='';
  var isloading=false.obs;

  //for shop settings
resetController(){
  nameController.clear();
  oldpassController.clear();
  newpassController.clear();
  shopNameController.clear();
  shopAddressController.clear();
  shopMobileController.clear();
  shopWebsiteController.clear();
  shopDescController.clear();
}
  var shopNameController=TextEditingController();
  var shopAddressController=TextEditingController();
  var shopMobileController=TextEditingController();
  var shopWebsiteController=TextEditingController();
  var shopDescController=TextEditingController();

  late QueryDocumentSnapshot docSnapshot;

  changeImage(context)async{
    try{
      final img=await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
      if(img==null)return;
      profileImagePath.value=img.path;
    }on PlatformException catch(e){
      VxToast.show(context, msg: e.toString());
    }

  }

  UploadProfileImage()async{
    var filename=basename(profileImagePath.value);
    var destination='images/${currentUser!.uid}/$filename';
    Reference ref=FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageDownloadLink=await ref.getDownloadURL();
  }
  updateProfile({name, password, imageUrl})async{
    await firestore.collection(vendorCollection).doc(currentUser!.uid).set({
      'vendor_name':name,
      'password':password ,
      'imageUrl':imageUrl
    },SetOptions(merge:true));
    isloading(false);
  }
  changeAuthPassword({email,password, newPassword})async{
    final cred=EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value){
      currentUser!.updatePassword(newPassword);
    }).catchError((error){
      print(error.toString());
    });
  }

  updateShop({shopName, shopAddress, shopMobile, shopWebsite, shopDesc})async{
    var store=await firestore.collection(vendorCollection).doc(currentUser!.uid);
    await store.set({
      'shop_name':shopName,
      'shop_address':shopAddress ,
      'shop_mobile':shopMobile,
      'shop_website': shopWebsite,
      'shop_desc':shopDesc
    }, SetOptions(merge:true));

  }

}