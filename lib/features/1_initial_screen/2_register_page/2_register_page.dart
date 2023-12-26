// ignore_for_file: must_be_immutable, file_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/widgets/show_fatal_error.dart';
import 'package:whatsapp2/features/1_initial_screen/2_register_page/widgets/1_form_header/1_form_header.dart';
import 'package:whatsapp2/features/1_initial_screen/2_register_page/widgets/2_form/2_cellphone_number_form.dart';
import 'package:whatsapp2/features/1_initial_screen/2_register_page/widgets/3_form_footer/3_form_footer.dart';
import 'package:whatsapp2/features/1_initial_screen/2_register_page/widgets/4_next_button/4_next_button.dart';
import 'package:whatsapp2/features/2_app/0_web_layout/web_layout.dart';

import 'state/location_state.dart';

class RegisterPage extends StatelessWidget {
  LocationController locationController = Get.put(LocationController()); // Rather Controller controller = Controller();
  RegisterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FormWrapper(),
              NextButton()
            ],
          ),
        ),
      ),
    );
  }
}

class FormWrapper extends StatelessWidget {
  const FormWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Whatsapp2WebLayoutBase(
      child: Column(
        children: [
          const FormHeader(),
          ControlledFormLoginPhoneNumber(),
          const FormFooter(),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signInAnonymously().then((value) {
                Get.offAllNamed('/');
              }).catchError((e) {
                showFatalError(e);
              });
            },
            child: const Text("Login Anon"),
          ),
        ],
      ),
    );
  }
}
