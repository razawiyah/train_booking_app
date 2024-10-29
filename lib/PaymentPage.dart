import 'package:flutter/material.dart';

import 'BookingSummary.dart';

class PaymentPage extends StatefulWidget {
  final double amount;

  PaymentPage({required this.amount});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  String selectedPaymentMethod = "Card"; // Default to "Card"
  String? selectedBank; // For FPX-like bank selection

  // List of dummy banks for the FPX simulation
  final List<String> bankList = [
    "Maybank",
    "CIMB Bank",
    "Public Bank",
    "RHB Bank",
    "Hong Leong Bank",
    "Bank Islam"
  ];

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

/*
  void _processPayment() {
    String paymentMethod = selectedPaymentMethod == "Card" ? "Card Payment" : "Online Banking - $selectedBank";

    // Show a success dialog (simulated payment process)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Successful"),
        content: Text("You have successfully paid RM${widget.amount} using $paymentMethod."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to the previous screen
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
*/

  void _processPayment() {
    // Show a success dialog before navigating
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Successful"),
        content: Text("You have successfully paid RM${widget.amount}."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingSummary(
                    trainName: "Express 123", // Replace with actual train name
                    departureTime: "10:00 AM", // Replace with actual departure time
                    arrivalTime: "2:00 PM", // Replace with actual arrival time
                    totalAmount: widget.amount,
                  ),
                ),
              );
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Amount to Pay: RM${widget.amount}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Payment Method Selection
            Text(
              "Select Payment Method:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ChoiceChip(
                  label: Text("Card"),
                  selected: selectedPaymentMethod == "Card",
                  onSelected: (selected) {
                    setState(() {
                      selectedPaymentMethod = "Card";
                      selectedBank = null; // Reset bank selection
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text("Online Banking"),
                  selected: selectedPaymentMethod == "Online Banking",
                  onSelected: (selected) {
                    setState(() {
                      selectedPaymentMethod = "Online Banking";
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 20),

            // Card Payment Fields (Shown if "Card" is selected)
            if (selectedPaymentMethod == "Card") ...[
              TextField(
                controller: _cardNumberController,
                decoration: InputDecoration(
                  labelText: "Card Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 16,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _expiryDateController,
                decoration: InputDecoration(
                  labelText: "Expiry Date (MM/YY)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _cvvController,
                decoration: InputDecoration(
                  labelText: "CVV",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 3,
              ),
            ],

            // FPX-like Bank Selection (Shown if "Online Banking" is selected)
            if (selectedPaymentMethod == "Online Banking") ...[
              Text(
                "Select Bank:",
                style: TextStyle(fontSize: 18),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedBank,
                hint: Text("Choose your bank"),
                items: bankList.map((bank) {
                  return DropdownMenuItem(
                    value: bank,
                    child: Text(bank),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBank = value!;
                  });
                },
              ),
            ],

            SizedBox(height: 20),

            // Confirm Payment Button
            Center(
              child: ElevatedButton(
                onPressed: selectedPaymentMethod == "Online Banking" && selectedBank == null
                    ? null // Disable if no bank is selected
                    : () {
                  _processPayment();
                },
                child: Text("Confirm Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}