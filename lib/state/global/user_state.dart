import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:palestine_console/palestine_console.dart';

class UserStateController extends GetxController {
  Rx<User?> user = FirebaseAuth.instance.currentUser.obs;

  @override
  void onInit() {
    FirebaseAuth.instance.userChanges().listen((newUser) {
      Print.green("---------- USUARIO FOI ATUALIZADO :) ----------");
      if (newUser != null) {
        user.value = newUser;
      } else {
        user.value = null;
      }
      update();
    });
    user.value = FirebaseAuth.instance.currentUser!;
    update();
    super.onInit();
  }
}
