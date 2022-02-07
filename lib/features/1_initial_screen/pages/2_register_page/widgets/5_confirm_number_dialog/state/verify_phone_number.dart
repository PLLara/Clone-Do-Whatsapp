import 'package:firebase_auth/firebase_auth.dart';

verifyPhoneNumber({
  required String phoneNumber,
  required void Function(String, int?) onCodeSend,
  required void Function(FirebaseAuthException) onProblem,
}) async {
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
}
