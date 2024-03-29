// ignore_for_file: must_be_immutable, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/widgets/loading.dart';
import 'package:whatsapp2/features/1_initial_screen/3_confirm_number_page/widgets/form_header.dart';
import 'package:whatsapp2/features/2_app/0_web_layout/web_layout.dart';

import '../2_register_page/state/location_state.dart';

class ConfirmNumberPage extends StatefulWidget {
  String verificationId;

  ConfirmNumberPage({
    super.key,
    required this.verificationId,
  });

  @override
  State<ConfirmNumberPage> createState() => _ConfirmNumberPageState();
}

class _ConfirmNumberPageState extends State<ConfirmNumberPage> {
  LocationController locationController = Get.find();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Whatsapp2WebLayoutBase(
      child: Scaffold(
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
                          style: Theme.of(context).textTheme.bodyLarge,
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
                      title: Text(
                        'Remande o SMS',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Icons.phone,
                        color: Colors.amber,
                      ),
                      title: Text(
                        "Receba por ligação",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
