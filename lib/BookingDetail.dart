import 'package:flutter/material.dart';

import 'PaymentPage.dart';

class BookingDetail extends StatelessWidget {
  final String trainName;
  final String departureTime;
  final String arrivalTime;
  final double totalAmount;

  BookingDetail({
    required this.trainName,
    required this.departureTime,
    required this.arrivalTime,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Train Details:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Train Number: $trainName", style: TextStyle(fontSize: 18)),
            Text("Departure Time: $departureTime", style: TextStyle(fontSize: 18)),
            Text("Arrival Time: $arrivalTime", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text(
              "Total Amount: RM$totalAmount",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _proceedToPayment(context);
                },
                child: Text("Proceed to Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _proceedToPayment(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment"),
        content: Text("Are you ready to proceed to payment?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close the dialog
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog first
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentPage(amount: totalAmount),
                ),
              );
            },
            child: Text("Proceed"),
          ),
        ],
      ),
    );
  }}