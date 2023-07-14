import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentRepository {
  List<String> countries = [
    // Asian Countries
    'Afghanistan',
    'Bangladesh',
    'China',
    'India',
    'Indonesia',
    'Japan',
    'Malaysia',
    'Pakistan',
    'Philippines',
    'South Korea',
    'Thailand',
    'Vietnam',
    // European Countries
    'Austria',
    'Belgium',
    'Czech Republic',
    'France',
    'Germany',
    'Italy',
    'Netherlands',
    'Poland',
    'Spain',
    'Sweden',
    'Switzerland',
    'United Kingdom',
    // North American Countries
    'Canada',
    'Mexico',
    'United States',
    // South American Countries
    'Argentina',
    'Brazil',
    'Chile',
    'Colombia',
    'Peru',
    'Venezuela',
    // African Countries
    'Egypt',
    'Ethiopia',
    'Kenya',
    'Nigeria',
    'South Africa',
    'Tanzania',
    'Uganda',
    // Oceania Countries
    'Australia',
    'New Zealand',
  ];
  String publisherKey = 'YOUR_PUBLISHABLE_KEY';

  bool validateEmail(String email) { 
          RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
   return emailRegExp.hasMatch(email);
  }

  bool validateCreditCardNumber(String cardNumber) {
    // Remove any non-digit characters from the card number
    cardNumber = cardNumber.replaceAll(RegExp(r"\D"), "");

    // Perform Luhn algorithm validation
    int checksum = 0;
    bool isSecondDigit = false;
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);
      if (isSecondDigit) {
        digit *= 2;
        if (digit > 9) {
          digit = digit ~/ 10 + digit % 10;
        }
      }
      checksum += digit;
      isSecondDigit = !isSecondDigit;
    }

    return checksum % 10 == 0;
  }

  bool validateExpirationDate(String expDate) {
    try {
      DateTime date = DateTime.parse("20" + expDate.substring(3) + "-" + expDate.substring(0, 2) + "-01");
      // Compare with current date to check if it's expired
      return date.isAfter(DateTime.now());
    } catch (FormatException) {
      return false;
    }
  }

  bool validateCvc(String cvc) {
    return RegExp(r"^\d{3,4}$").hasMatch(cvc);
  }

  bool validateZipCode(String zipCode) {
    return RegExp(r"^\d{5}$").hasMatch(zipCode);
  }
}
