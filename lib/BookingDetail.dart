import 'package:flutter/material.dart';
import 'PaymentPage.dart';

class BookingDetail extends StatefulWidget {
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
  _BookingDetailState createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  final TextEditingController _emailController = TextEditingController();
  String? email; // Variable to store email

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
            Text("Train Name: ${widget.trainName}", style: TextStyle(fontSize: 18)),
            Text("Departure Time: ${widget.departureTime}", style: TextStyle(fontSize: 18)),
            Text("Arrival Time: ${widget.arrivalTime}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text(
              "Total Amount: RM${widget.totalAmount}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Email Input Field
            Text(
              "Email Address:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Enter your email address",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value; // Update the email variable
              },
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
    // Validate email
    email = _emailController.text; // Get the email from the text field
    if (email != null && email!.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(
            amount: widget.totalAmount,
            email: email!, userEmail: '', // Pass the email address to PaymentPage
          ),
        ),
      );
    } else {
      // Handle empty email case
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your email address")),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose(); // Dispose the controller
    super.dispose();
  }
}