import 'package:flutter_test/flutter_test.dart';

import '../lib/features/card_scanner/parser/card_parser.dart';

void main() {

  test('Card Parsing', () {

    String raw = '''
    4111 1111 1111 1111
    JOHN DOE
    12/28
    ''';

    final result = parseCard(raw);

    expect(
      result.cardNumber,
      '4111111111111111',
    );
  });
}