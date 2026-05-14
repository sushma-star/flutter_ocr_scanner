import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ocr_scanner/core/utils/luhn_validator.dart';

void main() {

  test('Valid Card', () {

    bool result =
    isValidCard('4111111111111111');

    expect(result, true);
  });

  test('Invalid Card', () {

    bool result =
    isValidCard('1234567890123456');

    expect(result, false);
  });
}