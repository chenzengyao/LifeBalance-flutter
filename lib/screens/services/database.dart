import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifebalance/screens/models/course.dart';

class DatabaseService{

  final String uid;
  DatabaseService({ this.uid });    //Store collection in uid
  // collection reference, create 1 if not found in database
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');

  Future updateUserData(String email, String username) async {
    return await userCollection.doc(uid).set({   //pass in uid to (new)document
      'email': email,
      'username': username,
    });
  }

  // course list from snapshot
  List<User> _courseListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return User(
        email: doc.data()['email'] ?? '',    //empty string if dont exist
        username: doc.data()['username'] ?? '',
      );
    }).toList();
  }

  // get course stream
  Stream<List<User>> get courses {     //snapshot of firestore collection when data changes
    return userCollection.snapshots()  //return stream
      .map(_courseListFromSnapshot);
  }
}