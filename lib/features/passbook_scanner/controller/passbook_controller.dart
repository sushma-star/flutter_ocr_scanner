import 'dart:io';

import 'package:get/get.dart';

import '../../../../core/services/ocr_service.dart';
import '../model/bank_details.dart';
import '../parser/passbook_parser.dart';



class PassbookController
    extends GetxController {

  RxBool isLoading = false.obs;

  Rx<BankDetails?> bankDetails =
  Rx<BankDetails?>(null);

  Rx<File?> selectedImage =
  Rx<File?>(null);

  Future<void> scanPassbook(File image) async {

    isLoading.value = true;

    try {

      String text =
      await OCRService.extractText(image);

      print(text);

      bankDetails.value =
          parsePassbook(text);

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