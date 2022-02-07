import 'package:flutter/material.dart';
import 'package:whatsapp2/features/1_initial_screen/global/location_state.dart';

void changeCurrentLocation({
  required Location location,
  required LocationController locationController,
  required TextEditingController countryCodeInputController,
}) {
  locationController.changeLocation(location);
  countryCodeInputController.text = location.number.toString();
}
