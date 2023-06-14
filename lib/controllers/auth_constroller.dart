import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../const/const.dart';

class AuthController extends GetxController{
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var isloading=false.obs;




  //loginMethod
  Future<UserCredential?> loginMethod({ context})async{
    UserCredential? userCredential;
    try{
      userCredential= await auth.signInWithEmailAndPassword(email: emailController.text,
          password: passController.text);
      print(currentUser!.uid);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }


  signOutMethod(context)async{
    try{
      await auth.signOut();
    }catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }
}