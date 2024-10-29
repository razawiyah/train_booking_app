import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'BookingSummary.dart';

class PaymentPage extends StatefulWidget {
  final double amount;
  final String email; // Add this line to accept email

  PaymentPage({required this.amount, required this.email, required String userEmail}); // Update constructor

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

  Future<void> _sendEmail() async {
    final apiUrl = 'https://api.brevo.com/v3/smtp/email'; // Brevo API endpoint
    final apiKey = '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'; // Replace with your actual API key

    final emailData = {
      "sender": {"name": "Your App Name", "email": "yourapp@example.com"},
      "to": [{"email": widget.email}], // Use the passed email here
      "subject": "Booking Confirmation",
      "htmlContent": "<h1>Your booking has been confirmed!</h1><p>Total Amount: RM${widget.amount}</p>",
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'api-key': apiKey,
      },
      body: json.encode(emailData),
    );

    if (response.statusCode == 200) {
      print('Email sent successfully');
    } else {
      print('Failed to send email: ${response.statusCode}');
    }
  }

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
              _sendEmail(); // Send email with booking details
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

            // Email Input Field
            TextField(
              decoration: InputDecoration(
                labelText: "Email Address",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              controller: TextEditingController(text: widget.email), // Pre-fill with email
              enabled: false, // Disable editing
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
            ] else if (selectedPaymentMethod == "Online Banking") ...[
              DropdownButtonFormField<String>(
                hint: Text("Select Bank"),
                value: selectedBank,
                onChanged: (newValue) {
                  setState(() {
                    selectedBank = newValue;
                  });
                },
                items: bankList.map((bank) {
                  return DropdownMenuItem(
                    child: Text(bank),
                    value: bank,
                  );
                }).toList(),
              ),
            ],

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _processPayment,
              child: Text("Pay"),
            ),
          ],
        ),
      ),
    );
  }
}