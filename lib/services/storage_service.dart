import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class StorageService{
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadProfile({required File file, required String uid}) async{
    Reference fileRef = _storage.ref('users/profile').child('$uid ${p.extension(file.path)}');
    UploadTask task = fileRef.putFile(file);
    return task.then((p){
      if(p.state == TaskState.success){
        return fileRef.getDownloadURL();
      }

    });

  }
}

