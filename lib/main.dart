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
      theme: ThemeData(
        primaryColor: Colors.pink[300],
        hintColor: Colors.pink[100],
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
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

  final List<String> locations = [
    "Kuala Lumpur Sentral",
    "KLIA Ekspres",
    "Kota Bharu",
    "Butterworth",
    "Ipoh",
    "Penang",
    "Johor Bahru",
    "Melaka",
    "Kuantan",
    "Kota Kinabalu",
    "Kuching"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Trip Type Selection
                Text(
                  "Plan Your Trip Today!",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: Text("One Way"),
                      selected: tripType == "One Way",
                      onSelected: (selected) {
                        setState(() {
                          tripType = "One Way";
                          returnDate = null; // Reset return date if one way is selected
                        });
                      },
                      selectedColor: Colors.pink[200],
                      backgroundColor: Colors.grey[300],
                      labelStyle: TextStyle(color: Colors.black54),
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
                      selectedColor: Colors.pink[200],
                      backgroundColor: Colors.grey[300],
                      labelStyle: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // From and To Dropdowns with Swap Button
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        // From Dropdown
                        _buildDropdown("From", fromLocation, (value) {
                          setState(() {
                            fromLocation = value!;
                            // Reset "To" location when "From" is changed
                            toLocation = "";
                          });
                        }, locations),

                        SizedBox(height: 10),

                        // To Dropdown
                        _buildDropdown("To", toLocation, (value) {
                          setState(() {
                            toLocation = value!;
                          });
                        }, locations.where((location) => location != fromLocation).toList()),
                      ],
                    ),
                    Positioned(
                      top: 35,
                      right: 35, // Adjust this value to position the button
                      child: ElevatedButton(
                        onPressed: _swapLocations,
                        child: Icon(Icons.swap_vert),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(12),
                          backgroundColor: Colors.pink[300],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // Departure Date Picker
                _buildDatePicker("Departure Date", departureDate, (selectedDate) {
                  setState(() {
                    departureDate = selectedDate;
                  });
                }),

                // Return Date Picker (Conditional)
                if (tripType == "Round Trip")
                  _buildDatePicker("Return Date", returnDate, (selectedDate) {
                    setState(() {
                      returnDate = selectedDate;
                    });
                  }),

                SizedBox(height: 10),

                // Pax Counter
                _buildPaxCounter(),

                SizedBox(height: 20),

                // Search Button
                ChoiceChip(
                  label: Text("Search"),
                  selected: false, // ChoiceChip does not have a selected state for action buttons
                  onSelected: (selected) {
                    _validateAndSearch(); // Call the search function when pressed
                  },
                  selectedColor: Colors.pink[200],
                  backgroundColor: Colors.grey[300],
                  labelStyle: TextStyle(color: Colors.black54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for dropdowns
  Widget _buildDropdown(String label, String value, Function(String?) onChanged, List<String> locations) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      value: value.isNotEmpty ? value : null,
      items: locations.map((location) {
        return DropdownMenuItem(
          value: location,
          child: Text(location),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  // Helper method for date pickers
  Widget _buildDatePicker(String label, DateTime? date, Function(DateTime?) onChanged) {
    return ListTile(
      title: Text("$label: ${date != null ? date.toString().split(" ")[0] : "Select Date"}"),
      trailing: Icon(Icons.calendar_today),
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );
        if (selectedDate != null) {
          onChanged(selectedDate);
        }
      },
    );
  }

  // Pax Counter
  Widget _buildPaxCounter() {
    return Row(
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
              color: Colors.pink[300],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  pax++;
                });
              },
              icon: Icon(Icons.add),
              color: Colors.pink[300],
            ),
          ],
        ),
      ],
    );
  }

  void _swapLocations() {
    setState(() {
      String temp = fromLocation;
      fromLocation = toLocation;
      toLocation = temp;
    });
  }

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