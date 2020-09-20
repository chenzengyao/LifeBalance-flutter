import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifebalance/screens/models/course.dart';

class DatabaseService{

  final String uid;
  DatabaseService({ this.uid });    //Store collection in uid
  // collection reference, create 1 if not found in database
  final CollectionReference courseCollection = Firestore.instance.collection('course');

  Future updateUserData(String name, String courseCode, String moduleName, int duration) async {
    return await courseCollection.document(uid).setData({   //pass in uid to (new)document
      'name': name,
      'courseCode': courseCode,
      'moduleName': moduleName,
      'duration' : duration,
    });
  }

  // course list from snapshot
  List<Course> _courseListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Course(
        name: doc.data['name'] ?? '',    //empty string if dont exist
        courseCode: doc.data['courseCode'] ?? '',
        moduleName: doc.data['moduleName'] ?? '',
        duration: doc.data['duration'] ?? 0
      );
    }).toList();
  }

  // get course stream
  Stream<List<Course>> get courses {     //snapshot of firestore collection when data changes
    return courseCollection.snapshots()  //return stream
      .map(_courseListFromSnapshot);
  }
}