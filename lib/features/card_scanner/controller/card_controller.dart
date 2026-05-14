import 'dart:io';

import 'package:flutter_ocr_scanner/core/services/ocr_service.dart';
import 'package:flutter_ocr_scanner/features/card_scanner/model/card_details.dart';
import 'package:flutter_ocr_scanner/features/card_scanner/parser/card_parser.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';



class CardController extends GetxController {

  RxBool isLoading = false.obs;

  Rx<CardDetails?> cardDetails =
  Rx<CardDetails?>(null);

  Rx<File?> selectedImage =
  Rx<File?>(null);

  Future<void> scanCard(File image) async {

    isLoading.value = true;

    try {

      String text =
      await OCRService.extractText(image);

      print('0card details is $text');

      cardDetails.value =
          parseCard(text);

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
      );

    } finally {

      isLoading.value = false;
    }
  }
}