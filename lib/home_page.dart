import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Razorpay _razorpay = Razorpay();

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RazorPay'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CupertinoTextField(
              controller: controller,
              placeholder: 'Enter Your Amount',
            ),
          ),
          CupertinoButton(
            child: Text('Submit'),
            onPressed: () {
              var options = {
                'key': 'rzp_test_pEwhID4z7GK0t4',
                'amount': (int.parse(controller.text) * 100).toString(), //in the smallest currency sub-unit.
                'name': 'favad',
                // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                'description': 'Demo',
                'timeout': 300, // in seconds
                'prefill': {
                  'contact': '8787878787',
                  'email': 'favd@gmail.com'
                }
              };
              _razorpay.open(options);
            },
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
