import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/image_picker_service.dart';
import '../../../../core/utils/mask_card.dart';
import '../../../widgets/result_tile.dart';
import '../controller/card_controller.dart';

class CardScannerScreen extends StatelessWidget {

  CardScannerScreen({super.key});

  final controller = Get.put(CardController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Card Scanner",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: SingleChildScrollView(
            child: Column(
              children: [

                 Container(
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.document_scanner,
                    size: 60,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 20),

                 SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton.icon(
                    onPressed: () async {

                      File? file =
                      await ImagePickerService.pickImage();

                      if (file != null) {

                        controller.selectedImage.value = file;

                        controller.scanCard(file);
                      }
                    },

                    icon: const Icon(Icons.camera_alt,color: Colors.white,),

                    label: const Text(
                      "Scan Card",
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                 Obx(() {

                  if (controller.selectedImage.value != null) {

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),

                        child: Image.file(
                          controller.selectedImage.value!,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                }),

                const SizedBox(height: 25),

                 Obx(() {

                  if (controller.isLoading.value) {
                    return const CircularProgressIndicator();
                  }

                  final data = controller.cardDetails.value;

                  if (data == null) {

                    return Container(
                      padding: const EdgeInsets.all(25),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Text(
                        "No card scanned yet",
                      ),
                    );
                  }

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Row(
                          children: const [

                            Icon(
                              Icons.credit_card,
                              color: Colors.blue,
                            ),

                            SizedBox(width: 10),

                            Text(
                              "Card Details",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        detailsTile(
                          "Card Number",
                          maskCard(data.cardNumber),
                        ),

                        const SizedBox(height: 20),

                        detailsTile(
                          "Expiry Date",
                          data.expiryDate,
                        ),

                        const SizedBox(height: 20),

                        detailsTile(
                          "Card Holder",
                          data.holderName,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
