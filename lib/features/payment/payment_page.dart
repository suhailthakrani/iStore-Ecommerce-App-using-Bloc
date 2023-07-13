// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_cart_app/features/payment/order_completed_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // Token? _paymentToken;
  PaymentMethod? _paymentMethod;
  String? _error;

  String _paymentToken = '';

  @override
  void initState() {
    super.initState();
    Stripe.publishableKey =
        'YOUR_PUBLISHABLE_KEY'; // Replace with your Stripe publishable key
  }

  List<String> _countries = [
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

  // void _handlePayment() async {
  //   PaymentMethod paymentMethod = const PaymentMethod(
  //       id: 'dummy_id',
  //       livemode: false,
  //       paymentMethodType: 'card',
  //       billingDetails: BillingDetails(
  //         name: 'John Doe',
  //         email: 'johndoe@example.com',
  //         phone: '1234567890',
  //         address: Address(
  //           line1: '123 Main Street',
  //           city: 'City',
  //           state: 'State',
  //           postalCode: '12345',
  //           country: 'US',
  //           line2: 'Address Line 2',
  //         ),
  //       ),
  //       sepaDebit: SepaDebit(),
  //       bacsDebit: BacsDebit(),
  //       auBecsDebit: AuBecsDebit(),
  //       sofort: Sofort(),
  //       ideal: Ideal(),
  //       fpx: Fpx(),
  //       upi: Upi(),
  //       usBankAccount: UsBankAccount(
  //         accountHolderType: BankAccountHolderType.Individual,
  //         accountType: UsBankAccountType.Unknown,
  //       ),
  //       card: stripe.Card());

  //   final paymentMethodResult = await stripe.CreateTokenParams.card(
  //       params: CardTokenParams(
  //     address: paymentMethod.billingDetails.address,
  //   ));

  //   // Check if payment method creation was successful
  //   if (paymentMethodResult. == PaymentIntentsStatus.Succeeded) {
  //     setState(() {
  //       _paymentMethod = paymentMethodResult.paymentMethod;
  //     });

  //     // Make a payment using the payment method
  //     final paymentIntentResult =
  //         await paymentMethodResult.paymentMethod.confirmPaymentIntent(
  //       const PaymentIntent(
  //           id: "id",
  //           amount: 100,
  //           created: "created",
  //           currency: "currency",
  //           status: PaymentIntentsStatus.RequiresAction,
  //           clientSecret: "clientSecret",
  //           livemode: true,
  //           captureMethod: CaptureMethod.Automatic,
  //           confirmationMethod: ConfirmationMethod.Automatic),
  //     );

  //     // Check if payment was successful
  //     if (paymentIntentResult.status == PaymentIntentsStatus.Succeeded) {
  //       setState(() {
  //         _paymentToken =
  //             paymentIntentResult.paymentIntent?.paymentMethod?.token;
  //       });
  //     } else {
  //       setState(() {
  //         _error = 'Payment failed.';
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       _error = 'Payment method creation failed.';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 50,
        title: const Text(
          'Payment Amount: \$100.00',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerText(
              '  Card Holder Name',
            ),
            const SizedBox(height: 10),

            CupertinoTextField(
              placeholder: "e.g Suhail Thakrani",
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              placeholderStyle: const TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 20),
            headerText(
              '  Email Address',
            ),

            const SizedBox(height: 10),

            CupertinoTextField(
              placeholder: "e.g suhailthakrani@gmail.com",
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              placeholderStyle: const TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 20),
            headerText(
              '  Card Number',
            ),

            const SizedBox(height: 10),

            CupertinoTextField(
              placeholder: "1234 1234 1234 1234",
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              placeholderStyle: const TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              maxLength: 16,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w500),
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headerText('  Expiration Date'),
                      const SizedBox(height: 10),
                      CupertinoTextField(
                        placeholder: "MM / YY",
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        placeholderStyle: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.datetime,
                        onChanged: (value) {},
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headerText('  Security Code'),
                      const SizedBox(height: 10),
                      CupertinoTextField(
                        placeholder: "CVV / CVC",
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        placeholderStyle: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                        style: const TextStyle(
                          color: Colors.black26,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            headerText('  Country or Region'),
            const SizedBox(height: 10),
            CountryDropdown(countries: _countries),
            const SizedBox(height: 10),

            CupertinoTextField(
              placeholder: "ZIP Code",
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              placeholderStyle: const TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
              textAlignVertical: TextAlignVertical.bottom,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                const Text(
                  "Save this card here for future payments",
                  style: TextStyle(),
                )
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderCompletedPage(
                      orderNumber: "orderNumber",
                      productName: "productName",
                      productImage: "assets/images/congratulations.jpg",
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Make Payment'),
                ],
              ),
            ),
            // if (_paymentToken != null)
            //   const Text('Payment Successful!'),
            // if (_error != null)
            Text('Payment Failed: $_error'),
          ],
        ),
      ),
    );
  }

  Text headerText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor),
    );
  }
}

class CountryDropdown extends StatefulWidget {
  final List<String> countries;
  const CountryDropdown({
    Key? key,
    required this.countries,
  }) : super(key: key);

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  String _selectedCountry = 'United States'; // Initially selected country

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: DropdownButton<String>(
        value: _selectedCountry,
        onChanged: (String? newValue) {
          setState(() {
            _selectedCountry = newValue!;
          });
        },
        isExpanded: true,
        underline: Container(),
        items: widget.countries.map((String country) {
          return DropdownMenuItem<String>(
            value: country,
            child: Text(
              country,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          );
        }).toList(),
      ),
    );
  }
}
