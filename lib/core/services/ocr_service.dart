import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRService {

  static Future<String> extractText(File file) async {

    final inputImage = InputImage.fromFile(file);

    final textRecognizer = TextRecognizer();

    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);

    return recognizedText.text;
  }
}