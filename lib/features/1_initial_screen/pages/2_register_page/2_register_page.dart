// ignore_for_file: must_be_immutable, file_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/1_initial_screen/pages/2_register_page/widgets/1_form_header/1_form_header.dart';
import 'package:whatsapp2/features/1_initial_screen/pages/2_register_page/widgets/3_form_footer/3_form_footer.dart';
import 'package:whatsapp2/features/1_initial_screen/pages/3_confirm_number/3_confirm_number_page.dart';
import 'package:whatsapp2/features/1_initial_screen/widgets/country_code_selector_widget.dart';
import '../../global/location_state.dart';

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

class CellphoneNumberForm extends StatelessWidget {
  LocationController locationController = Get.find();

  CellphoneNumberForm({
    Key? key,
  }) : super(key: key) {
    changeCurrentLocation(
      location: const Location('Brasil', 'br', 55),
      locationController: locationController,
      countryCodeInputController: locationController.countryCodeInputController.value,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                ContrySelectButton(
                  locationController: locationController,
                  countryCodeInputController: locationController.countryCodeInputController.value,
                ),
                const SizedBox(
                  height: 10,
                ),
                CellphoneInput(
                  countryCodeInputController: locationController.countryCodeInputController.value,
                  phoneNumberInputController: locationController.phoneNumberInputController.value,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ContrySelectButton extends StatelessWidget {
  const ContrySelectButton({
    Key? key,
    required this.locationController,
    required this.countryCodeInputController,
  }) : super(key: key);

  final LocationController locationController;
  final TextEditingController countryCodeInputController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextButton(
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (e) => CountryCodeSelector(
                key: const Key('countrycodeselector'),
                onSelectCountry: (Location location) {
                  changeCurrentLocation(
                    location: location,
                    locationController: locationController,
                    countryCodeInputController: countryCodeInputController,
                  );
                },
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(locationController.selectedLocation.value.countryName),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
              const Divider(
                height: 4,
                indent: 0,
                thickness: 1,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CellphoneInput extends StatelessWidget {
  const CellphoneInput({
    Key? key,
    required this.countryCodeInputController,
    required this.phoneNumberInputController,
  }) : super(key: key);

  final TextEditingController countryCodeInputController;
  final TextEditingController phoneNumberInputController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: countryCodeInputController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              isDense: true,
              prefixIcon: Text("+"),
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 8,
          child: TextFormField(
            controller: phoneNumberInputController,
            keyboardType: TextInputType.number,
            autocorrect: false,
            inputFormatters: [
              MaskedInputFormatter('(##)#####-####')
            ],
            decoration: const InputDecoration(
              isDense: true,
              hintText: 'Numero de celular',
            ),
          ),
        ),
      ],
    );
  }
}

class NextButton extends StatelessWidget {
  NextButton({
    Key? key,
  }) : super(key: key);
  LocationController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
      onPressed: () {
        if (locationController.phoneNumberInputController.value.text.length < 10) {
          Get.defaultDialog(title: "Bote um numero decente ai mano credo :/");
          return;
        }
        Get.dialog(
          AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Você escolheu o número: "),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Obx(
                    () => Text(
                      locationController.phoneNumberInputController.value.text.replaceAll('(', '').replaceAll('-', '').replaceAll(' ', '').replaceAll(')', ''),
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                const Text("Tem certeza que esse é o número certo? Gostaria de mudar? EIN? PAU NO CU")
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("DEU RUIM"),
                    ),
                    const Expanded(child: SizedBox()),
                    TextButton(
                      onPressed: () async {
                        FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: "+55" + locationController.phoneNumberInputController.value.text.replaceAll('(', '').replaceAll('-', '').replaceAll(' ', '').replaceAll(')', ''),
                          verificationCompleted: (PhoneAuthCredential credential) {
                            print("Verification Completed");
                            print(credential);
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            print("Verification failed");
                            print(e);
                            Get.defaultDialog(
                              title: "Fatal Error!",
                              barrierDismissible: false,
                              textConfirm: "Exit",
                              onConfirm: () {
                                Get.back();
                                Get.back();
                                Get.back();
                                Get.back();
                                Get.back();
                                Get.back();
                              },
                            );
                          },
                          codeSent: (String verificationId, int? resendToken) async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => ConfirmNumberPage(
                                  key: const Key('confirmnumberpage'),
                                  verificationId: verificationId,
                                ),
                              ),
                            );
                            print("CodeSent");
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {
                            print("CodeAutoRetrievalTimeout");
                            print(verificationId);
                          },
                        );
                      },
                      child: const Text("Bora"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      child: const Text('Próximo'),
    );
  }
}

void changeCurrentLocation({
  required Location location,
  required LocationController locationController,
  required TextEditingController countryCodeInputController,
}) {
  locationController.changeLocation(location);
  countryCodeInputController.text = location.number.toString();
}
