import 'package:flutter/material.dart';
import 'package:samad_blood_bank/auth/log_in_screen.dart';
import 'package:samad_blood_bank/screen/donar_by_area.dart';
import 'package:samad_blood_bank/screen/donar_by_group.dart';
import 'package:samad_blood_bank/screen/user_profile.dart';
import 'package:samad_blood_bank/services/auth_service.dart';
import 'package:samad_blood_bank/shared/settings.dart';
import 'package:samad_blood_bank/shared/text_field.dart';

class DashBoard extends StatefulWidget {
  final String userId;
  const DashBoard({super.key, required this.userId});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final searchController = TextEditingController();
  Map<String, dynamic>? userData;
  String? userId = AuthService().getUserId();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    var authService = AuthService();
    userData = await authService.getUserProfile(widget.userId);

    if (userData != null) {
      //print('The user data is: $userData');
    } else {
      print('User data not found.');
    }

    setState(() {}); // Update the UI if necessary
  }

  Future<void> logOut() async {
    var authService = AuthService();
    await authService.logOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LogInScreen()));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Successfully Logout')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CircleAvatar(
              backgroundImage:
                  userData != null && userData!['profileUrl'] != null
                      ? NetworkImage(userData!['profileUrl'])
                      : const AssetImage('assets/images/splash.jpg')
                          as ImageProvider,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    userData != null && userData!['profileUrl'] != null
                        ? NetworkImage(userData!['profileUrl'])
                        : const AssetImage('assets/images/splash.jpg')
                            as ImageProvider,
                radius: 50,
              ),
              accountName:
                  Text(userData != null ? userData!['userName'] : 'Loading...'),
              accountEmail:
                  Text(userData != null ? userData!['email'] : 'Loading...'),
            ),
            ListTile(
              leading: const Icon(
                Icons.done,
                color: Colors.red,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DonarByGroup()));
                },
                child: const Text('Group'),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.done,
                color: Colors.red,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DonarByArea()));
                },
                child: const Text('Area'),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.supervised_user_circle,
                color: Colors.red,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserProfile(userId: userId.toString())));
                },
                child: const Text('Profile'),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.supervised_user_circle,
                color: Colors.red,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                },
                child: const Text('Settings'),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.supervised_user_circle,
                color: Colors.red,
              ),
              title: GestureDetector(
                onTap: () {
                  logOut();
                },
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              controller: searchController,
              label: 'Search',
              hint: 'A',
              iconData: const Icon(Icons.search),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Blood group tags
                    for (var bloodGroup in [
                      'A+',
                      'A-',
                      'B+',
                      'B-',
                      'O+',
                      'O-',
                      'AB+',
                      'AB-'
                    ])
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          width: bloodGroup.length == 2 ? 40 : 50,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.redAccent.withOpacity(0.5),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              bloodGroup,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 500, // Set a fixed height to constrain ListView
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded corners
                        child: Container(
                          width: 50, // Set a consistent width
                          height: 150, // Set a consistent height
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1), // Subtle border
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(
                                    2, 2), // Light shadow for depth
                              ),
                            ],
                          ),
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaz-ezfcRhK7MD3wQovjTOuZ_EKk7pmJ1JJQ&s',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: const Text('Md Sharif Hossain'),
                      subtitle: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('sharifdu44@gmail.com'),
                          Text('10-26-2024'),
                          Text('Status')
                        ],
                      ),
                      trailing: const Column(
                        children: [
                          Text('B+'),
                          SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.chat),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(Icons.phone)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
