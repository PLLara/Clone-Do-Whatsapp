// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/1_initial_screen/2_register_page/state/location_state.dart';
import 'package:whatsapp2/features/1_initial_screen/widgets/country_code_selector_widget.dart';

import '../../state/change_current_location.dart';

class ControlledFormLoginPhoneNumber extends StatelessWidget {
  final LocationController cLocation = Get.find();

  ControlledFormLoginPhoneNumber({
    super.key,
  }) {
    changeCurrentLocation(
      location: const Location('Brasil', 'br', 55),
      locationController: cLocation,
      countryCodeInputController: cLocation.countryCodeInputController.value,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                ContrySelectButton(),
                const SizedBox(
                  height: 10,
                ),
                ControlledFormLoginInputCelphone(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ContrySelectButton extends StatelessWidget {
  ContrySelectButton({
    super.key,
  });

  final LocationController cLocation = Get.find();

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
                  var countryCodeInputController = cLocation.countryCodeInputController.value;
                  changeCurrentLocation(
                    location: location,
                    locationController: cLocation,
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
                  Text(cLocation.selectedLocation.value.countryName),
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

class ControlledFormLoginInputCelphone extends StatelessWidget {
  ControlledFormLoginInputCelphone({
    super.key,
  });

  final LocationController cLocation = Get.find();

  @override
  Widget build(BuildContext context) {
    var controllerPhoneNumber = cLocation.phoneNumberInputController.value;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyLarge,
            controller: cLocation.countryCodeInputController.value,
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
            style: Theme.of(context).textTheme.bodyLarge,
            controller: controllerPhoneNumber,
            keyboardType: TextInputType.number,
            onFieldSubmitted: (value) {
              cLocation.buttonNextPressed();
            },
            textInputAction: TextInputAction.search,
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
