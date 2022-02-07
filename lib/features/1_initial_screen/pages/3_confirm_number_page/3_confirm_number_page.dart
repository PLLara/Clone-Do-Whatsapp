// ignore_for_file: must_be_immutable, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/widgets/loading.dart';
import 'package:whatsapp2/features/1_initial_screen/global/location_state.dart';
import 'package:whatsapp2/features/1_initial_screen/pages/3_confirm_number_page/widgets/form_header.dart';

class ConfirmNumberPage extends StatefulWidget {
  String verificationId;

  ConfirmNumberPage({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<ConfirmNumberPage> createState() => _ConfirmNumberPageState();
}

class _ConfirmNumberPageState extends State<ConfirmNumberPage> {
  LocationController locationController = Get.find();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ConfirmNumberFormHeader(
              key: const Key('formheader'),
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: loading
                    ? const Loading()
                    : TextField(
                        onChanged: (verificationCode) async {
                          if (verificationCode.length == 6) {
                            setState(() {
                              loading = true;
                            });
                            try {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: verificationCode);
                              await auth.signInWithCredential(credential);
                              Get.back();
                              Get.back();
                              Get.back();
                              Get.back();
                              Get.back();
                              Get.back();
                            } catch (e) {
                              Get.defaultDialog(
                                title: e.toString(),
                              );
                            }
                            setState(() {
                              loading = false;
                            });
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
