import '../model/card_details.dart';
import '../../../core/utils/luhn_validator.dart';
import '../../../core/utils/text_cleaner.dart';

CardDetails parseCard(String rawText) {

  rawText = cleanOCRText(rawText);

  String cardNumber = '';
  String expiry = '';
  String holderName = '';

   RegExp cardRegex = RegExp(
    r'(\d{4}\s\d{4}\s\d{4}\s\d{4})|(\d{16})',
  );

  Iterable<Match> cardMatches =
  cardRegex.allMatches(rawText);
  for (var match in cardMatches) {

    String possibleCard =
    match.group(0)!;

    possibleCard =
        possibleCard.replaceAll(' ', '');

    print(possibleCard);
    print(isValidCard(possibleCard));
    cardNumber = possibleCard;
    break;

  }

  RegExp expiryRegex = RegExp(
    r'(0[1-9]|1[0-2])[\/\-]?\d{2}',
  );

  Match? expiryMatch =
  expiryRegex.firstMatch(rawText);

  if (expiryMatch != null) {

    expiry = expiryMatch.group(0)!;

    if (!expiry.contains('/')) {

      expiry =
      '${expiry.substring(0, 2)}/${expiry.substring(2)}';
    }
  }

   List<String> lines =
  rawText.split('\n');

  for (String line in lines) {

    line = line.trim();

    String upper =
    line.toUpperCase();

    bool isName =
    RegExp(r'^[A-Z ]{3,}$')
        .hasMatch(upper);

    bool containsInvalidWords =
        upper.contains('BANK') ||
            upper.contains('VALID') ||
            upper.contains('THRU') ||
            upper.contains('CARD') ||
            upper.contains('VISA') ||
            upper.contains('MASTER');

    if (isName &&
        !containsInvalidWords &&
        line.split(' ').length >= 2) {

      holderName = upper;
      break;
    }
  }

  return CardDetails(
    cardNumber: cardNumber,
    expiryDate: expiry,
    holderName: holderName,
  );
}