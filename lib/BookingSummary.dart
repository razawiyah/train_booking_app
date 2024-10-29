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
        backgroundColor: Colors.pink[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ticket Container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Train Details Header
                  Text(
                    "Train Ticket",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink[300]),
                  ),
                  SizedBox(height: 15),

                  // Train Information
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Train Name:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(trainName, style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Departure:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(departureTime, style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Arrival:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(arrivalTime, style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Amount:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("RM$totalAmount", style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // QR Code Section
            Text(
              "QR Code for Booking:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Center(
              /*child: QrImage(
                data: bookingInfo,
                version: QrVersions.auto,
                size: 200.0,
              ),*/
            ),
          ],
        ),
      ),
    );
  }
}