import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samad_blood_bank/services/auth_service.dart';

class UserProfile extends StatefulWidget {
  final String userId;
  const UserProfile({super.key, required this.userId});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map<String, dynamic>? userData;

  Future<void> fetchUserData() async {
    var authService = AuthService();
    userData = await authService.getUserProfile(widget.userId);

    if (userData != null) {
      //print('The user data is: $userData');
    } else {
      print('User data not found.');
    }

    setState(() {}); // Update the UI
  }

  @override
  void initState() {
    super.initState(); // Always call super.initState() in initState
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile of ${userData?['name'] ?? 'Loading...'}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFD20D0D),
            Color(0XFFE5D8D8),
          ])
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                 child:  CircleAvatar(
                    backgroundImage: userData != null && userData!['profileUrl'] != null
                        ? NetworkImage(userData!['profileUrl'])
                        : AssetImage('assets/images/splash.jpg') as ImageProvider,
                    radius: 50,
                  )

              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'Name \n${(userData?['name'] ?? 'Loading...')}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Email: ${userData?['email'] ?? 'Loading...'}', textAlign: TextAlign.center,),
                  const SizedBox(height: 10),
                  Text('Contact: ${userData?['contactNumber'] ?? 'Loading...'}', textAlign: TextAlign.center,),
                  const SizedBox(height: 10),
                  Text('Address: \n${userData?['address'] ?? 'Loading...'}', textAlign: TextAlign.center,),
                  const SizedBox(height: 10),
                  Text('Blood Group: ${userData?['bloodGroup'] ?? 'Loading...'}', textAlign: TextAlign.center,),
                  const SizedBox(height: 10),
                  Text('Last Date: ${userData?['lastDate'] ?? 'Loading...'}', textAlign: TextAlign.center,),
                  const SizedBox(height: 10),
                  // Display the availability status
                  Text('Status: ${checkAvailability(userData)}', textAlign: TextAlign.center,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String checkAvailability(Map<String, dynamic>? userData) {
    // Get the lastDate from userData or set it to a default value
    String lastDateString = userData?['lastDate'] ?? 'Loading...';

    // If the lastDate is 'Loading...', return a loading message
    if (lastDateString == 'Loading...') {
      return 'Loading...';
    }

    // Parse the lastDate string to a DateTime object
    DateTime lastDate = DateFormat('dd-MM-yyyy').parse(lastDateString);
    DateTime currentDate = DateTime.now();

    // Calculate the difference in days
    Duration difference = currentDate.difference(lastDate);
    int daysDifference = difference.inDays;

    // Check if the difference is greater than or equal to 90 days (approximately 3 months)
    if (daysDifference >= 90) {
      return 'Available'; // Available if more than 3 months have passed
    } else {
      return '${90 - daysDifference} days left for availability'; // Days left
    }
  }
}
