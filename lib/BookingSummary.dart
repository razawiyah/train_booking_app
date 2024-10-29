import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingSummary extends StatelessWidget {
  final String trainName;
  final String departureTime;
  final String arrivalTime;
  final double totalAmount;

  BookingSummary({
    required this.trainName,
    required this.departureTime,
    required this.arrivalTime,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    String bookingInfo = "Train: $trainName\nDeparture: $departureTime\nArrival: $arrivalTime\nAmount: RM$totalAmount";

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Summary"),
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
            SizedBox(height: 20),
            Text(
              "QR Code for Booking:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
          Center(
            child: Container(
              child: QrImage(
                data: bookingInfo,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
          )
          ],
        ),
      ),
    );
  }
}