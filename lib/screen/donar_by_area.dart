
import 'package:flutter/material.dart';
import 'package:samad_blood_bank/model/district_wise_data.dart';
import 'package:samad_blood_bank/model/division_model.dart';
import 'package:samad_blood_bank/model/division_wise_data.dart';
import 'package:samad_blood_bank/services/bangladesh.dart';
import 'package:samad_blood_bank/shared/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DonarByArea extends StatefulWidget {
  const DonarByArea({super.key});

  @override
  State<DonarByArea> createState() => _DonarByAreaState();
}

class _DonarByAreaState extends State<DonarByArea> {
  List<DivisionData> divisionList = [];
  List<District> districtList = [];
  List<Upazilla> upazillaList = [];
  String? _selectedDivision;
  String? _selectedDistrict;
  String? _selectedUpazilla;
  /*GENDER? gender;
  late  List<dynamic> selectdGender;
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController nameController = TextEditingController();*/


  @override
  void initState() {
    _fetchDivisions();
    super.initState();
  }

  Future<void> _fetchDivisions() async {
    try {
      var response = await Bangladesh.getAllDivision();
      var division = divisionFromJson(response.body);
      setState(() {
        divisionList = division.data;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }



  Future<void> _fetchAllData() async {
    if (_selectedDivision != null && _selectedDivision!.isNotEmpty) {
      try {
        var response = await Bangladesh.getSelectedDivisionDistrict(_selectedDivision!);
        if (response != null && response.statusCode == 200) {
          var divisionWiseData = divisionWiseDataFromJson(response.body);
          setState(() {

            districtList = divisionWiseData.data;
            _selectedDistrict = null; // Reset district selection when a new division is selected
          });
        } else {
          print('Failed to load data');
        }
      } on Exception catch (e) {
        print(e.toString());
      }
    } else {
      print('Please select a division');
    }
  }



  Future<void> _fetchAllUpazilla() async {
    if (_selectedDistrict != null && _selectedDistrict!.isNotEmpty) {
      try {
        var response = await Bangladesh.getSelectedDistrictUpazilla(_selectedDistrict!);
        if (response != null && response.statusCode == 200) {
          var districtWiseData = districtWiseDataFromJson(response.body);

          setState(() {
            upazillaList = districtWiseData.data // Now data is a list
                .map((upazillaData) => Upazilla(
              district: upazillaData.district,
              districtbn: upazillaData.districtbn,
              coordinates: upazillaData.coordinates,
              upazillas: upazillaData.upazillas, // Get the full list of upazillas
            ))
                .toList();

            _selectedUpazilla = null; // Reset upazilla selection
          });
        } else {
          print('Failed to load data');
        }
      } on Exception catch (e) {
        print(e.toString());
      }
    } else {
      print('Please select a district');
    }
  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title:  Text(AppLocalizations.of(context)?.donate??''),
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
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             _divisionDropDown(),
              const SizedBox(
                height: 20,
              ),
              _districtDropDown(),
              const SizedBox(
                height: 20,
              ),
              _upazillaDropDown(),
              const SizedBox(
                height: 20,
              ),
              CustomButton(title: 'Search Donors', onTap: (){})
            ],
          ),
        ),
      ),
    );
  }

  Widget _divisionDropDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonFormField<String>(
        value: _selectedDivision,
        hint: const Text("Select Division"),
        items: divisionList.map((DivisionData division) {
          return DropdownMenuItem<String>(
            value: division.division,
            child: Text(division.division),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedDivision = newValue!;
            _fetchAllData(); // Trigger fetching districts when a division is selected
          });
        },
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border:  OutlineInputBorder(),
          labelText: 'Division',
        ),
      ),
    );
  }

  Widget _districtDropDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonFormField<String>(
        value: _selectedDistrict,
        hint: const Text("Select District"),
        items: districtList.map((District district) {
          return DropdownMenuItem<String>(
            value: district.district,
            child: Text(district.district),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedDistrict = newValue;
            _fetchAllUpazilla();
          });
        },
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border:  OutlineInputBorder(),
          labelText: 'District',
        ),
      ),
    );
  }
  Widget _upazillaDropDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonFormField<String>(
        value: _selectedUpazilla,
        hint: const Text("Select Upazilla"),
        items: upazillaList.expand((Upazilla upazilla) {
          return upazilla.upazillas.map((String upazillaName) {
            return DropdownMenuItem<String>(
              value: upazillaName,
              child: Text(upazillaName),
            );
          }).toList();
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedUpazilla = newValue;
          });
          // Debugging output
          print("Selected Upazilla: $_selectedUpazilla");
        },
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border:  OutlineInputBorder(),
          labelText: 'Upazilla',
        ),
      ),
    );
  }



 /* Widget _selectTheGender() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Select Your Gender',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    child: RadioListTile<GENDER>(
                      title: const Text('Male'),
                      contentPadding: const EdgeInsets.all(0),
                      value: GENDER.male,
                      groupValue: gender,
                      onChanged: (GENDER? value) {
                        setState(() {
                          gender = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: RadioListTile<GENDER>(
                      title: const Text('Female'),
                      contentPadding: const EdgeInsets.all(0),
                      value: GENDER.female,
                      groupValue: gender,
                      onChanged: (GENDER? value) {
                        setState(() {
                          gender = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: RadioListTile<GENDER>(
                      title: const Text('Other'),
                      contentPadding: const EdgeInsets.all(0),
                      value: GENDER.others,
                      groupValue: gender,
                      onChanged: (GENDER? value) {
                        setState(() {
                          gender = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }*/





}

