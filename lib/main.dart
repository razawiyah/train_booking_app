import 'package:flutter/material.dart';

import 'TrainInfo.dart';

void main() {
  runApp(TrainBookingApp());
}

class TrainBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Train Booking App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String tripType = "One Way"; // Default trip type
  String fromLocation = "";
  String toLocation = "";
  DateTime? departureDate;
  DateTime? returnDate;
  int pax = 1;

  final List<String> locations = ["Location A", "Location B", "Location C"]; // Sample locations

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Train Booking App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Trip Type Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text("One Way"),
                  selected: tripType == "One Way",
                  onSelected: (selected) {
                    setState(() {
                      tripType = "One Way";
                      returnDate = null;
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text("Round Trip"),
                  selected: tripType == "Round Trip",
                  onSelected: (selected) {
                    setState(() {
                      tripType = "Round Trip";
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 20),

            // From Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "From"),
              value: fromLocation.isNotEmpty ? fromLocation : null,
              items: locations.map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  fromLocation = value!;
                });
              },
            ),

            SizedBox(height: 10),

            // To Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "To"),
              value: toLocation.isNotEmpty ? toLocation : null,
              items: locations.map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  toLocation = value!;
                });
              },
            ),

            SizedBox(height: 10),

            // Departure Date Picker
            ListTile(
              title: Text("Departure Date: ${departureDate != null ? departureDate.toString().split(" ")[0] : "Select Date"}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (selectedDate != null) {
                  setState(() {
                    departureDate = selectedDate;
                  });
                }
              },
            ),

            // Return Date Picker (Conditional)
            if (tripType == "Round Trip")
              ListTile(
                title: Text("Return Date: ${returnDate != null ? returnDate.toString().split(" ")[0] : "Select Date"}"),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: departureDate ?? DateTime.now(),
                    firstDate: departureDate ?? DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      returnDate = selectedDate;
                    });
                  }
                },
              ),

            SizedBox(height: 10),

            // Pax Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pax: $pax"),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (pax > 1) {
                          setState(() {
                            pax--;
                          });
                        }
                      },
                      icon: Icon(Icons.remove),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          pax++;
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            // Search Button
            ElevatedButton(
              onPressed: _validateAndSearch,
              child: Text("Search"),
            ),
          ],
        ),
      ),
    );
  }

  // Validation and Search Logic
/*
  void _validateAndSearch() {
    if (fromLocation.isEmpty ||
        toLocation.isEmpty ||
        departureDate == null ||
        (tripType == "Round Trip" && returnDate == null)) {
      // Show popup if any field is missing
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Incomplete Information"),
          content: Text("Please fill in all required fields."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else {
      // Proceed with search logic
      // Implement the actual search logic or navigation here
      print("Searching with provided details...");
    }
  }
*/

  void _validateAndSearch() {
    if (fromLocation.isEmpty ||
        toLocation.isEmpty ||
        departureDate == null ||
        (tripType == "Round Trip" && returnDate == null)) {
      // Show popup if any field is missing
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Incomplete Information"),
          content: Text("Please fill in all required fields."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else {
      // Navigate to TrainInfo screen with provided details
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrainInfo(
            fromLocation: fromLocation,
            toLocation: toLocation,
            departureDate: departureDate!,
            returnDate: tripType == "Round Trip" ? returnDate : null,
          ),
        ),
      );
    }
  }
}