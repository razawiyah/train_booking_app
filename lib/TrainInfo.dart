import 'package:flutter/material.dart';
import 'SeatSelection.dart';

class TrainInfo extends StatelessWidget {
  final String fromLocation;
  final String toLocation;
  final DateTime departureDate;
  final DateTime? returnDate;

  TrainInfo({
    required this.fromLocation,
    required this.toLocation,
    required this.departureDate,
    this.returnDate,
  });

  // Sample train data
  final List<Map<String, String>> availableTrains = [
    {
      "trainName": "Express 1",
      "departureTime": "10:00 AM",
      "arrivalTime": "2:00 PM"
    },
    {
      "trainName": "Express 2",
      "departureTime": "1:00 PM",
      "arrivalTime": "5:00 PM"
    },
    {
      "trainName": "Express 3",
      "departureTime": "4:00 PM",
      "arrivalTime": "8:00 PM"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Trains"),
        backgroundColor: Colors.pink[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trip Info Section
            _buildTripInfoSection(context),

            SizedBox(height: 20),

            // Available Trains Section
            Text(
              "Available Trains:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: availableTrains.length,
                itemBuilder: (context, index) {
                  return _buildTrainCard(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build the trip info section
  Widget _buildTripInfoSection(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "From: $fromLocation",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "To: $toLocation",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Departure Date: ${departureDate.toLocal().toString().split(' ')[0]}",
              style: TextStyle(fontSize: 18),
            ),
            if (returnDate != null)
              Text(
                "Return Date: ${returnDate!.toLocal().toString().split(' ')[0]}",
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }

  // Method to build each train card
  Widget _buildTrainCard(BuildContext context, int index) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          availableTrains[index]["trainName"]!,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Departure: ${availableTrains[index]["departureTime"]}"),
            Text("Arrival: ${availableTrains[index]["arrivalTime"]}"),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeatSelection(trainName: availableTrains[index]["trainName"]!),
            ),
          );
        },
      ),
    );
  }
}