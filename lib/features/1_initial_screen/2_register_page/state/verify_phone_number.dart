// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

registerWithPhoneNumber({
  required String phoneNumber,
  required void Function(String, int?) onCodeSend,
  required void Function(FirebaseAuthException) onProblem,
}) async {
  try {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: onProblem,
      codeSent: onCodeSend,
      codeAutoRetrievalTimeout: (String verificationId) {
        print("CodeAutoRetrievalTimeout");
        print(verificationId);
      },
    );
  } catch (e) {
    await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber).then((value) {
      onCodeSend(value.verificationId, value.hashCode);
    });
  }
}
