import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_emart/const/const.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:seller_emart/controllers/home_controller.dart';
import '../models/category_model.dart';

class ProductController extends GetxController{

  resetControllers(){
    pnameController.clear();
    pdescController.clear();
    ppriceController.clear();
    pquantityController.clear();
  }

var isloading=false.obs;
  //for adding product
  var pnameController=TextEditingController();
  var pdescController=TextEditingController();
  var pquantityController=TextEditingController();
  var ppriceController=TextEditingController();

  var categoryList=<String>[].obs;
  var subcategoryList=<String>[].obs;
  List<Category> category=[];

  var pImagesLinkList=[];
  var pImagesList=RxList<dynamic>.generate(3, (index) => null);

  var categoryValue=''.obs;
  var subcategoryValue=''.obs;
  var selectedColorIndex=0.obs;

  getCategories()async{
    var data=await rootBundle.loadString("lib/services/category_model.json");
    var cat=categoryModelFromJson(data);
    category=cat.categories;
  }

  populateCategoryList(){
    categoryList.clear();
    for(var item in category){
      categoryList.add(item.name);
    }
  }

  populateSubCategory(cat){

    subcategoryList.clear();
    var data=category.where((element) => element.name==cat).toList();
    for(var i=0; i<data.first.subcategory.length; i++){
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context)async{
    try{
      final img=await ImagePicker().pickImage(source: ImageSource.gallery);
      if(img==null){
        return;
      }else{
        pImagesList[index]=File(img.path);
      }
    }catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }

  //upload product images to db
  uploadImage()async{
pImagesLinkList.clear();
    for(var item in pImagesList){
      if(item!=null){
        var filename=basename(item.path);
        var destination='images/vendors/${currentUser!.uid}/$filename';
        Reference ref=FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n=await ref.getDownloadURL();
        pImagesLinkList.add(n);
      }

    }
  }

  //upload product to the products collection in db

uploadProduct(context)async{
    var store=firestore.collection(productsCollection).doc();
    await store.set({
      'is_featured':false,
      'p_category':categoryValue.value,
      'p_subcategory':subcategoryValue.value,
      'p_colors': FieldValue.arrayUnion([Colors.red.value, Colors.amberAccent.value, Colors.white.value]),
      'p_images':FieldValue.arrayUnion(pImagesLinkList),
      'p_wishlist':FieldValue.arrayUnion([]),
      'p_name':pnameController.text,
      'p_price':ppriceController.text,
      'p_desc':pdescController.text,
      'p_quantity':pquantityController.text,
      'p_rating':"5.0",
      'p_seller':Get.find<HomeController>().userName,
      'vendor_id':currentUser!.uid,
      'featured_id':''
    });
    VxToast.show(context, msg: "Product Uploaded Successfully");
    isloading(false);
}


addFeaturedProduct(docId)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'featured_id': currentUser!.uid,
      'is_featured':true
    },SetOptions(merge: true));
}

removeFeaturProduct(docId)async{
  await firestore.collection(productsCollection).doc(docId).set({
    'featured_id':'',
    'is_featured':false
  },SetOptions(merge: true));
}


removeProduct(docId)async{
    await firestore.collection(productsCollection).doc(docId).delete();
}

}