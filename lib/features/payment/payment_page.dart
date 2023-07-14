// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_cart_app/features/payment/components/order_completed_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../blocs/payment/payment_bloc.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late PaymentBloc paymentBloc;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cardController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvcController = TextEditingController();
  final _zipController = TextEditingController();

  @override
  void initState() {
    paymentBloc = BlocProvider.of<PaymentBloc>(context);
    paymentBloc.add(const PaymentInitialEvent());
    super.initState();
  }

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
      body:  SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerText(
                  '  Card Holder Name',
                ),
                const SizedBox(height: 10),

                CupertinoTextField(
                  controller: _nameController,
                  placeholder: "e.g Suhail Thakrani",
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  placeholderStyle: const TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    context
                        .read<PaymentBloc>()
                        .add(PaymentTextFieldsChangedEvent(
                          _nameController.text,
                          _emailController.text,
                          _cardController.text,
                          _expiryDateController.text,
                          _cvcController.text,
                          _zipController.text,
                        ));
                  },
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                const SizedBox(height: 5),
                BlocBuilder<PaymentBloc, PaymentState>(
                  bloc: paymentBloc,
                  builder: (context, state) {
                    if (state is PaymentErrorState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          state.fieldErrors["name"] != null
                              ? Text(state.fieldErrors["name"] ?? "",
                                  style: const TextStyle(color: Colors.red))
                              : Container(),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 5),
                headerText(
                  '  Email Address',
                ),

                const SizedBox(height: 10),

                CupertinoTextField(
                  controller: _emailController,
                  placeholder: "e.g suhailthakrani@gmail.com",
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  placeholderStyle: const TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    context
                        .read<PaymentBloc>()
                        .add(PaymentTextFieldsChangedEvent(
                          _nameController.text,
                          value,
                          _cardController.text,
                          _expiryDateController.text,
                          _cvcController.text,
                          _zipController.text,
                        ));
                  },
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                  const SizedBox(height: 5),
                BlocBuilder<PaymentBloc, PaymentState>(
                  bloc: paymentBloc,
                  builder: (context, state) {
                    if (state is PaymentErrorState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          state.fieldErrors["email"] != null
                              ? Text(state.fieldErrors["email"] ?? "",
                                  style: const TextStyle(color: Colors.red))
                              : Container(),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 5),
                headerText(
                  '  Card Number',
                ),

                const SizedBox(height: 10),

                CupertinoTextField(
                  controller: _cardController,
                  placeholder: "1234 1234 1234 1234",
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                  onChanged: (value) {
                    context
                        .read<PaymentBloc>()
                        .add(PaymentTextFieldsChangedEvent(
                          _nameController.text,
                          _emailController.text,
                          _cardController.text,
                          _expiryDateController.text,
                          _cvcController.text,
                          _zipController.text,
                        ));
                  },
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                 const SizedBox(height: 5),
                BlocBuilder<PaymentBloc, PaymentState>(
                  bloc: paymentBloc,
                  builder: (context, state) {
                    if (state is PaymentErrorState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          state.fieldErrors["card"] != null
                              ? Text(state.fieldErrors["card"] ?? "",
                                  style: const TextStyle(color: Colors.red))
                              : Container(),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 5),
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
                            controller: _expiryDateController,
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
                            onChanged: (value) {
                              context
                                  .read<PaymentBloc>()
                                  .add(PaymentTextFieldsChangedEvent(
                                    _nameController.text,
                                    _emailController.text,
                                    _cardController.text,
                                    _expiryDateController.text,
                                    _cvcController.text,
                                    _zipController.text,
                                  ));
                            },
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                            const SizedBox(height: 5),
                BlocBuilder<PaymentBloc, PaymentState>(
                  bloc: paymentBloc,
                  builder: (context, state) {
                    if (state is PaymentErrorState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          state.fieldErrors["expiryDate"] != null
                              ? Text(state.fieldErrors["expiryDate"] ?? "",
                                  style: const TextStyle(color: Colors.red))
                              : Container(),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 5),
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
                            controller: _cvcController,
                            placeholder: "CVV / CVC",
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            placeholderStyle: const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              context
                                  .read<PaymentBloc>()
                                  .add(PaymentTextFieldsChangedEvent(
                                    _nameController.text,
                                    _emailController.text,
                                    _cardController.text,
                                    _expiryDateController.text,
                                    _cvcController.text,
                                    _zipController.text,
                                  ));
                            },
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                            const SizedBox(height: 5),
                BlocBuilder<PaymentBloc, PaymentState>(
                  bloc: paymentBloc,
                  builder: (context, state) {
                    if (state is PaymentErrorState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          state.fieldErrors["cvc"] != null
                              ? Text(state.fieldErrors["cvc"] ?? "",
                                  style: const TextStyle(color: Colors.red))
                              : Container(),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
               
                headerText('  Country or Region'),
                const SizedBox(height: 10),
                CountryDropdown(
                    countries: context
                        .read<PaymentBloc>()
                        .paymentRepository
                        .countries),
                const SizedBox(height: 10),

                CupertinoTextField(
                  controller: _zipController,
                  placeholder: "ZIP Code",
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  placeholderStyle: const TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  textAlignVertical: TextAlignVertical.bottom,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    context
                        .read<PaymentBloc>()
                        .add(PaymentTextFieldsChangedEvent(
                          _nameController.text,
                          _emailController.text,
                          _cardController.text,
                          _expiryDateController.text,
                          _cvcController.text,
                          _zipController.text,
                        ),
                    );
                  },
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                  const SizedBox(height: 5),
                BlocBuilder<PaymentBloc, PaymentState>(
                  bloc: paymentBloc,
                  builder: (context, state) {
                    if (state is PaymentErrorState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          state.fieldErrors["zip"] != null
                              ? Text(state.fieldErrors["zip"] ?? "",
                                  style: const TextStyle(color: Colors.red))
                              : Container(),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 5),
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
                    context
                        .read<PaymentBloc>()
                        .add(PaymentTextFieldsChangedEvent(
                          _nameController.text,
                          _emailController.text,
                          _cardController.text,
                          _expiryDateController.text,
                          _cvcController.text,
                          _zipController.text,
                        ));
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const OrderCompletedPage(
                    //       orderNumber: "orderNumber",
                    //       productName: "productName",
                    //       productImage: "assets/images/congratulations.jpg",
                    //     ),
                    //   ),
                    // );
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
                // Text('Payment Failed: $_error'),
              ],
            ),
          )
      
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
