import '../model/bank_details.dart';
import '../../../core/utils/text_cleaner.dart';

BankDetails parsePassbook(String rawText) {

  rawText = cleanOCRText(rawText);

  String accountNumber = '';
  String ifsc = '';
  String name = '';

   RegExp numberRegex =
  RegExp(r'\b\d{9,18}\b');

  Iterable<Match> numberMatches =
  numberRegex.allMatches(rawText);

  List<String> numbers = numberMatches
      .map((e) => e.group(0)!)
      .toList();

  if (numbers.isNotEmpty) {

    numbers.sort(
          (a, b) => b.length.compareTo(a.length),
    );

    accountNumber = numbers.first;
  }

   RegExp ifscRegex =
  RegExp(r'[A-Z]{4}0[A-Z0-9]{6}');

  Match? ifscMatch =
  ifscRegex.firstMatch(rawText);

  if (ifscMatch != null) {

    ifsc = ifscMatch.group(0)!;
  }

  /// FIND NAME
  List<String> lines =
  rawText.split('\n');

  for (String line in lines) {

    String upper =
    line.toUpperCase();

    if (upper.contains('NAME')) {

      List<String> parts =
      line.split(':');

      if (parts.length > 1) {

        name = parts[1].trim();
      }
    }
  }

  return BankDetails(
    holderName: name,
    accountNumber: accountNumber,
    ifscCode: ifsc,
  );
}