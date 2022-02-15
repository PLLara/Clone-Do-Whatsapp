import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp2/common/database/postgres.dart';

verifyPhoneNumber({
  required String phoneNumber,
  required void Function(String, int?) onCodeSend,
  required void Function(FirebaseAuthException) onProblem,
}) async {
  var db = Postgres();
  await db.connection.open();

  print((await db.createUser('', phoneNumber)).message);

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
