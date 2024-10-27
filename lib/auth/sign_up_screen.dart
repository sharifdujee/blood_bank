import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samad_blood_bank/auth/log_in_screen.dart';
import 'package:samad_blood_bank/services/auth_service.dart';
import 'package:samad_blood_bank/services/storage_service.dart';
import 'package:samad_blood_bank/shared/button.dart';
import 'package:samad_blood_bank/shared/drop_down.dart';
import 'package:samad_blood_bank/shared/image_upload.dart';
import 'package:samad_blood_bank/shared/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {


  /// Sign up Function

  Future<void> userRegistration() async {
    var authService = AuthService();

    String? pfpURL;
    if (selectedImage != null) {
      pfpURL = await _storageService.uploadProfile(
        file: selectedImage!,
        uid: _authService.user?.uid ?? '',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a profile image.')),
      );
      return;
    }
    String formattedDate = formatter.format(_selectedDate!);

    // Accessing controller values directly inside userRegistration
    bool isRegistered = await authService.signUp(
      nameController.text,
      userNameController.text,
      emailController.text,
      phoneNumberController.text,
      addressController.text,
      bloodGroupController.text, // This now holds the selected blood group value
      formattedDate,
      selectedGender,
      passwordController.text,
      pfpURL ?? '',
    );

    if (isRegistered) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LogInScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration is Success!'),
          duration: Duration(seconds: 5),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration is Failed!'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }






  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController lastDateController = TextEditingController();


  late MediaService _mediaService;
  File? selectedImage;
  late StorageService _storageService;
  late AuthService _authService;
  DateTime? _selectedDate;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  bool isMale = false;
  bool isFemale = false;
  bool isOther = false;
  String selectedGender = '';


  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    //print(pickDate);
    setState(() {
      _selectedDate = pickDate;
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    bloodGroupController.dispose();
    lastDateController.dispose();

    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mediaService = MediaService();
    _storageService = StorageService();
    _authService = AuthService();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFD20D0D),
            Color(0XFFE5D8D8),
          ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Welcome to Samad Blood Bank'),
              ),
              Form(

                key: _formKey,
                  child: Column(

                children: [
                  _pfpSetSelectionFiled(),

                  CustomTextField(controller: nameController, label: 'Name', hint: 'rahat', iconData: Icon(Icons.person),),
                  const SizedBox(height: 10,),
                  CustomTextField(controller: userNameController, label: 'User Name', hint: 'amit#32', iconData: Icon(Icons.person),),
                  const SizedBox(height: 10,),
                  CustomTextField(controller: emailController, label: 'Email', hint: 'rahat99@gmail.com', iconData: Icon(Icons.email),),
                  const SizedBox(height: 10,),
                  CustomTextField(controller: phoneNumberController, label: 'Contact Number', hint: '+8801***99', iconData: Icon(Icons.phone), prefixText: '+880',),
                  const SizedBox(height: 10,),

                  const SizedBox(height: 10,),CustomTextField(controller: addressController, label: 'Address', hint: '32/A Mura-para , Rup-gang, Narayan-gang', iconData: Icon(Icons.location_pin),),
                  const SizedBox(height: 10,),
                  AnimatedCustomDropdown(
                    controller: bloodGroupController,
                    label: 'Blood Group',
                    hint: 'Select Blood Group',
                    iconData: Icon(Icons.bloodtype_outlined),
                    items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'],
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.transparent.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Last Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                            style: const TextStyle(color: Colors.black87),
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),

                  selectTheGender(),
                  CustomTextField(controller: passwordController, label: 'Password', hint: '31-01-2023', iconData: Icon(Icons.password),),
                  CustomTextField(controller: confirmPasswordController, label: 'Confirm Password', hint: '31-01-2023', iconData: Icon(Icons.password),),

                  const SizedBox(height: 10,),

                CustomButton(
                  title: 'SignUp',
                  onTap: () {
                    // Call userRegistration with the required parameters
                    userRegistration();
                  },
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already Have an Account'),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const LogInScreen()));
                      }, child: Text('Sign In'))
                    ],
                  ),


                ],
              )),
            ],
          ),
        ),
      ),
    );

  }
  Widget _pfpSetSelectionFiled() {
    return GestureDetector(
      onTap: () async {
        File? file = await _mediaService.galleryImage();
        if (file != null) {
          setState(() {
            selectedImage = file;
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundImage: selectedImage != null
            ? FileImage(selectedImage!)
            : NetworkImage('https://www.azcriminallawteam.com/wp-content/uploads/2016/01/dummy-profile.png') as ImageProvider,
      ),
    );
  }


  Widget selectTheGender() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10), // Add some spacing
          Text(
            'Select Gender:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10), // Add some spacing

          // Radio buttons for gender selection
          RadioListTile<String>(
            title: Text('Male'),
            value: 'Male', // Use string values
            groupValue: selectedGender, // Bind to selectedGender
            onChanged: (value) {
              setState(() {
                selectedGender = value!; // Set the selected gender
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Female'),
            value: 'Female', // Use string values
            groupValue: selectedGender, // Bind to selectedGender
            onChanged: (value) {
              setState(() {
                selectedGender = value!; // Set the selected gender
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Other'),
            value: 'Other', // Use string values
            groupValue: selectedGender, // Bind to selectedGender
            onChanged: (value) {
              setState(() {
                selectedGender = value!; // Set the selected gender
              });
            },
          ),
        ],
      ),
    );
  }





}
