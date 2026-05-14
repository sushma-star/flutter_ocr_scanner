import 'package:flutter_test/flutter_test.dart';

import '../lib/features/passbook_scanner/parser/passbook_parser.dart';

void main() {

  test('Passbook Parsing', () {

    String raw = '''
    NAME: RAVI
    IFSC: SBIN0001234
    A/C NO: 12345678901
    ''';

    final result =
    parsePassbook(raw);

    expect(
      result.ifscCode,
      'SBIN0001234',
    );
  });
}
