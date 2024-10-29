import 'package:flutter/material.dart';
import 'BookingDetail.dart';

class SeatSelection extends StatefulWidget {
  final String trainName;

  SeatSelection({required this.trainName});

  @override
  _SeatSelectionState createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  int selectedCoach = 1; // Default coach selection
  int? selectedSeat;
  double seatPrice = 10.0; // Default seat price (you can make it dynamic)

  // Dummy data for coaches and seats
  final int numberOfCoaches = 6;
  final int seatsPerCoach = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Seat - ${widget.trainName}"),
        backgroundColor: Colors.pink[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Coach Selection
            Text(
              "Select Coach:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: List.generate(numberOfCoaches, (index) {
                return ChoiceChip(
                  label: Text("Coach ${index + 1}"),
                  selected: selectedCoach == index + 1,
                  selectedColor: Colors.pink[300],
                  onSelected: (bool selected) {
                    setState(() {
                      selectedCoach = index + 1;
                      selectedSeat = null; // Reset seat selection on coach change
                    });
                  },
                );
              }),
            ),

            SizedBox(height: 20),

            // Seat Selection
            Text(
              "Select Seat:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Column(
                children: List.generate(numberOfCoaches, (coachIndex) {
                  return Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (seatIndex) {
                        int seatNum = (coachIndex * 4) + seatIndex + 1;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSeat = seatNum;
                              seatPrice = 10.0 + (seatIndex % 5) * 2; // Example dynamic pricing
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: selectedSeat == seatNum
                                  ? Colors.pink[300] // Selected seat color
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: selectedSeat == seatNum
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "S${seatNum}",
                                style: TextStyle(
                                  color: selectedSeat == seatNum
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: 20),

            // Display Seat Price
            if (selectedSeat != null)
              Text(
                "Selected Seat Price: RM$seatPrice",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

            SizedBox(height: 20),

            // Confirm Button
            Center(
              child: ElevatedButton(
                onPressed: selectedSeat != null
                    ? () {
                  _confirmSelection();
                }
                    : null, // Disable if no seat is selected
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[300],
                ),
                child: Text("Confirm"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmSelection() {
    // Confirm selection logic (navigate or display a confirmation message)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmation"),
        content: Text(
          "You have selected Coach $selectedCoach, Seat $selectedSeat with a price of RM$seatPrice.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingDetail(
                    trainName: widget.trainName,
                    departureTime: "10:00 AM", // Replace with actual departure time
                    arrivalTime: "2:00 PM", // Replace with actual arrival time
                    totalAmount: seatPrice,
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
}