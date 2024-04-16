import 'package:flutter/material.dart';

import '../../../widgets/Charts/chart.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = false;
  TimeOfDay selectedTime = TimeOfDay(hour: 8, minute: 0); // Initial time

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          // Background Image
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/settings_background.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 18),
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E), // Adjusted color to a darker shade
                  ),
                ),

            Container(
              width: 200,
              height:300,
              child: Center(
                child: TaskStatisticsChart(
                  statistics: {
                    '2024-04-05': true,
                    '2024-04-06': true,
                    '2024-04-07': false,
                    '2024-04-08': true,
                    '2024-04-09': false,
                    '2024-04-10': false,
                    '2024-04-11': true,
                  },
                  containerHeight: 40, // Set the height of the chart container
                ),
              ),
            ),

                SizedBox(height: 128),
                // Notifications Switch
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications on:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            notificationsEnabled = value;
                          });
                          _executeFunction();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Notification Time Picker
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notification time:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showTimePicker();
                        },
                        child: Text(
                          '${selectedTime.format(context)}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _executeFunction() {
    // Execute the function
    print('Function executed');
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
      _executeFunction();
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: SettingsPage(),
  ));
}
