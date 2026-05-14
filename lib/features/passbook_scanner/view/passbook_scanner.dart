import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/image_picker_service.dart';
import '../controller/passbook_controller.dart';

class PassbookScreen extends StatelessWidget {

  PassbookScreen({super.key});

  final controller =
  Get.put(PassbookController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Passbook Scanner",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
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
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.account_balance,
                    size: 60,
                    color: Colors.green,
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

                        controller.selectedImage.value =
                            file;

                        controller.scanPassbook(file);
                      }
                    },

                    icon: const Icon(Icons.camera_alt,color: Colors.white,),

                    label: const Text(
                      "Scan Passbook",
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                 Obx(() {

                  if (controller.selectedImage.value !=
                      null) {

                    return Container(

                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(20),

                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: ClipRRect(

                        borderRadius:
                        BorderRadius.circular(20),

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

                  final data =
                      controller.bankDetails.value;

                  if (data == null) {

                    return Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(20),
                      ),

                      child: const Center(
                        child: Text(
                          "No passbook scanned yet",
                        ),
                      ),
                    );
                  }

                  return Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(20),

                      boxShadow: [
                        BoxShadow(
                          color:
                          Colors.black.withOpacity(0.08),

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
                              Icons.account_balance,
                              color: Colors.green,
                            ),

                            SizedBox(width: 10),

                            Text(
                              "Bank Details",

                              style: TextStyle(
                                fontSize: 19,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        detailsTile(
                          "Account Holder Name",
                          data.holderName,
                        ),

                        const SizedBox(height: 20),

                        detailsTile(
                          "Account Number",
                          data.accountNumber,
                        ),

                        const SizedBox(height: 20),

                        detailsTile(
                          "IFSC Code",
                          data.ifscCode,
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

  Widget detailsTile(String title, String value) {

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,

        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(
            title,

            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value.isEmpty ? "Not Found" : value,

            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}