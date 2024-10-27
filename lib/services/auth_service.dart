import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  User? get user {
    return _user;
  }
  User? get currentUser => _firebaseAuth.currentUser;

  Future<bool> signUp(
      String name,
      String userName,
      String email,
      String phoneNumber,
      String address,
      String bloodGroup,
      String lastDate,
      String gender,
      String password,
      String profileUrl) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        _user = credential.user;
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'userId': credential.user!.uid,
          "name": name,
          "userName": userName,
          "email": email,
          "contactNumber": phoneNumber,
          'address': address,
          'bloodGroup': bloodGroup,
          'lastDate': lastDate,
          'gender': gender,
          'password': password,
          'profileUrl': profileUrl
        });

        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        print('the user of the present $userId does not exist}');
      }
    } catch (e) {
      print('Error$e');
    }
  }





  Future<bool> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        _user = credential.user;
        return true;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  String? getUserId() {
    return currentUser?.uid;
  }

  Future<bool> logOut() async{
    try{
      await _firebaseAuth.signOut();
      return true;

    }
    catch(e){
      print(e.toString());
    }
    return false;
  }

  /*
    Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }
   */
}






