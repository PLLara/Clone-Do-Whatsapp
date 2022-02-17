import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp2/common/database/postgres.dart';

verifyPhoneNumber({
  required String phoneNumber,
  required void Function(String, int?) onCodeSend,
  required void Function(FirebaseAuthException) onProblem,
}) async {
  try {
    var db = Postgres();
    await db.connection.open();
    (await db.createUser('', phoneNumber)).message;
  } catch (e) {
    print(e);
  }

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
      onCodeSend(value.verificationId,value.hashCode);
    });
  }
}
