import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

verifyPhoneNumber({
  required String phoneNumber,
  required void Function(String, int?) onCodeSend,
  required void Function(FirebaseAuthException) onProblem,
}) async {

  try {

    var createUserOnPgResponse = await http.post(
      Uri.parse('https://whatsapp-2-backend.herokuapp.com/createuser'),
      body: {
        "nome": 'sem nome',
        "fone": phoneNumber
      },
    );
    print("BOM DIA PUTA");
    print(createUserOnPgResponse.body);


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
