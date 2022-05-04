// ignore_for_file: must_be_immutable, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/1_initial_screen/2_register_page/widgets/1_form_header/1_form_header.dart';
import 'package:whatsapp2/features/1_initial_screen/2_register_page/widgets/2_form/2_cellphone_number_form.dart';
import 'package:whatsapp2/features/1_initial_screen/2_register_page/widgets/3_form_footer/3_form_footer.dart';
import 'package:whatsapp2/features/1_initial_screen/2_register_page/widgets/4_next_button/4_next_button.dart';
import 'state/location_state.dart';

class RegisterPage extends StatelessWidget {
  LocationController locationController = Get.put(LocationController()); // Rather Controller controller = Controller();
  RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FormWrapper(),
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FormHeader(),
        CellphoneNumberForm(),
        const FormFooter()
      ],
    );
  }
}
