// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/1_initial_screen/global/location_state.dart';

class ConfirmNumberPage extends StatelessWidget {
  String verificationId;

  ConfirmNumberPage({Key? key, required this.verificationId}) : super(key: key);

  LocationController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: Text(
                'Verificando teu numero',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            const Text('Esperando o SMS ai no teu celular no número'),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () {
                      var countryCode = locationController.countryCodeInputController.value.text;
                      var phoneNumber = locationController.phoneNumberInputController.value.text;
                      return Text(
                        '+$countryCode $phoneNumber. ',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 25,
                    child: TextButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size.zero),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                      child: const Text("Wrong number?"),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextField(
                  onChanged: (a) async {
                    print(a);
                    if (a.length > 5) {
                      print('tentando registrar:');
                      try {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: a);

                        await auth.signInWithCredential(credential);
                        Get.back();
                        Get.back();
                        Get.back();
                        Get.back();
                        Get.back();
                        Get.back();
                      } catch (e) {
                        Get.defaultDialog(title: e.toString());
                      }
                    }
                  },
                  decoration: const InputDecoration(isDense: true),
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text('Digite o código de 6 digitos.'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.sms,
                      color: Colors.amber,
                    ),
                    title: const Text('Remande o SMS'),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.amber,
                    ),
                    title: const Text("Receba por ligação"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
