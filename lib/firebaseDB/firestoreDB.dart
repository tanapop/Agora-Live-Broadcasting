import 'package:path/path.dart' as Path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class FireStoreClass {
  //static final Firestore _db = Firestore.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final liveCollection = 'liveuser';
  static final userCollection = 'user_streamer';
  static final emailCollection = 'user_email';

  static void createLiveUser({name, id, time, image}) async {
    final snapShot = await _db.collection(liveCollection).doc(name).get();
    if (snapShot.exists) {
      await _db
          .collection(liveCollection)
          .doc(name)
          .update({'name': name, 'channel': id, 'time': time, 'image': image});
    } else {
      await _db
          .collection(liveCollection)
          .doc(name)
          .set({'name': name, 'channel': id, 'time': time, 'image': image});
    }
  }

  static Future<String> getImage({username}) async {
    final snapShot = await _db.collection(userCollection).doc(username).get();
    return snapShot.data()['image'];
  }

  static Future<String> getName({username}) async {
    final snapShot = await _db.collection(userCollection).doc(username).get();
    return snapShot.data()['name'];
  }

  static Future<bool> checkUsername({username}) async {
    final snapShot = await _db.collection(userCollection).doc(username).get();
    //print('Xperion ${snapShot.exists} $username');
    if (snapShot.exists) {
      return false;
    }
    return true;
  }

  static Future<void> regUser(
      {firstName, lastName, fullName, email, username, image}) async {
    /*StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('$email/${Path.basename(image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete; //  Image Upload code */

    Reference reference = FirebaseStorage.instance
        .ref()
        .child('$email/${Path.basename(image.path)}')
        .child(image);

    UploadTask uploadTask = reference.putFile(image);

    uploadTask.whenComplete(() async {
      try {
        image = await reference.getDownloadURL();
      } catch (onError) {
        print("Error");
      }

      print(image);
    });

    /*await storageReference.getDownloadURL().then((fileURL) async {
      // To fetch the uploaded data's url
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('firstName', firstName);
      await prefs.setString('lastName', lastName);
      await prefs.setString('fullName', fullName);
      await prefs.setString('username', username);
      await prefs.setString('email', email);
      await prefs.setString('image', fileURL);

      await _db.collection(userCollection).doc(username).set({
        'firstName': firstName,
        'lastName': lastName,
        'fullName': fullName,
        'email': email,
        'username': username,
        'image': fileURL,
      });
      await _db.collection(emailCollection).doc(email).set({
        'firstName': firstName,
        'lastName': lastName,
        'fullName': fullName,
        'email': email,
        'username': username,
        'image': fileURL,
      });
      return true;
    });
  }*/

    await reference.getDownloadURL().then((fileURL) async {
      // To fetch the uploaded data's url
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('firstName', firstName);
      await prefs.setString('lastName', lastName);
      await prefs.setString('fullName', fullName);
      await prefs.setString('username', username);
      await prefs.setString('email', email);
      await prefs.setString('image', fileURL);

      await _db.collection(userCollection).doc(username).set({
        'firstName': firstName,
        'lastName': lastName,
        'fullName': fullName,
        'email': email,
        'username': username,
        'photoURL': fileURL,
      });
      await _db.collection(emailCollection).doc(email).set({
        'firstName': firstName,
        'lastName': lastName,
        'fullName': fullName,
        'email': email,
        'username': username,
        'photoURL': fileURL,
      });
      return true;
    });
  }

  static void deleteUser({username}) async {
    await _db.collection(liveCollection).doc(username).delete();
  }

  static Future<void> getDetails({email}) async {
    //var document = await Firestore.instance.document('user_email/$email').get();
    var document =
        await FirebaseFirestore.instance.doc('user_email/$email').get();
    var checkData = document.data;
    if (checkData == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', document.data()['name']);
    await prefs.setString('username', document.data()['username']);
    await prefs.setString('image', document.data()['image']);
  }
}
