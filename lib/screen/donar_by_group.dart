import 'package:flutter/material.dart';
import 'package:samad_blood_bank/shared/button.dart';
import 'package:samad_blood_bank/shared/text_field.dart';
class DonarByGroup extends StatefulWidget {
  const DonarByGroup({super.key});

  @override
  State<DonarByGroup> createState() => _DonarByGroupState();
}

class _DonarByGroupState extends State<DonarByGroup> {
  final TextEditingController groupController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Donor By Blood Group'),
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
            children: [
              Form(child: Column(
                children: [
                  CustomTextField(controller: groupController, label: 'Blood Group', hint: 'A+', iconData: const Icon(Icons.bloodtype_outlined),),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(controller: groupController, label: 'Division', hint: 'A+', iconData: const Icon(Icons.location_city),),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(controller: groupController, label: 'District', hint: 'A+', iconData: const Icon(Icons.location_city_outlined),),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(controller: groupController, label: 'Upazilla', hint: 'A+', iconData: const Icon(Icons.signpost),),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(controller: groupController, label: 'Address', hint: '15/6 Mirpur 2 Dhaka 1216', iconData: const Icon(Icons.location_pin),),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(title: 'Search Donors', onTap: (){})
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
