// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/1_initial_screen/global/location_state.dart';
import 'package:whatsapp2/features/1_initial_screen/pages/2_register_page/widgets/2_form/state/change_current_location.dart';
import 'package:whatsapp2/features/1_initial_screen/widgets/country_code_selector_widget.dart';

class CellphoneNumberForm extends StatelessWidget {
  final LocationController locationController = Get.find();

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
