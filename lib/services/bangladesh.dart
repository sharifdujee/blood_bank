import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:samad_blood_bank/services/base_class.dart';

class Bangladesh{

  static Future<http.Response> getAllDivision() async{
    try{
      var response = await http.get(Uri.parse('${BaseClass.PUBLIC_API_URL}/divisions'),
      );
      if(response.statusCode==200){
        // print('the division data is ${response.body}');
        return response;
      }
    }
    on Exception catch(e){
      print(e.toString());
    }
    throw Exception;

  }

  //fetch the division and Upazilla name based on Division
  static Future<http.Response?> getSelectedDivisionDistrict(String division) async {
    try {
      var requestUrl = '${BaseClass.PUBLIC_API_URL}/division/$division';
      //print('Request URL: $requestUrl');
      var response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        //print('The fetched data is ${response.body}');
        return response;
      } else {
        print('Failed to load data with status code: ${response.statusCode}');
      }
    } on Exception catch (e) {
      print('Exception occurred: ${e.toString()}');
    }
    return null; // Return null in case of an error
  }

  static Future<http.Response?> getSelectedDistrictUpazilla(String district) async {
    try {
      var requestUrl = '${BaseClass.PUBLIC_API_URL}/district/$district';
      //print('Request URL: $requestUrl');
      var response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        //print('The fetched data is ${response.body}');
        return response;
      } else {
        print('Failed to load data with status code: ${response.statusCode}');
      }
    } on Exception catch (e) {
      print('Exception occurred: ${e.toString()}');
    }
    return null; // Return null in case of an error
  }


}