import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_door/models/member_model.dart';
import 'package:test_door/models/timeline_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection referrence
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('home');

  // add user control
  Future updateUserData(
      String idmaster, String status, String displayName, String email) async {
    return await userCollection.doc(uid).set({
      "masterID": idmaster,
      "status": status,
      "email": email,
      "displayName": displayName,
    });
  }

  // add user control
  Future editUserData(String idmaster, String status) async {
    return await userCollection.doc(uid).update({
      "masterID": idmaster,
      "status": status,
    });
  }

  // Add member to control door
  Future addMember(
      String memberid, String displayName, String email, String status) {
    return userCollection.doc(uid).collection('member').doc(memberid).set({
      "memberid": memberid,
      "displayName": displayName,
      "email": email,
      "status": status,
    });
  }

  // timeline list from snapshot
  List<TimelineModel> _timelineListFromSnapshot(QuerySnapshot snapshop) {
    return snapshop.docs.map((doc) {
      return TimelineModel(
        uid: doc.data()['uid'] ?? "",
        date: doc.data()['date'] ?? "",
        time: doc.data()['time'] ?? "",
        unlock: doc.data()['unlock'] ?? "",
        command: doc.data()['command'] ?? "",
        displayName: doc.data()['displayName'] ?? "",
      );
    }).toList();
  }

  // get stream user timeline data
  Stream<List<TimelineModel>> get userTimeline {
    return userCollection
        .doc(uid)
        .collection('timeline')
        .orderBy('create', descending: false)
        .snapshots()
        .map(_timelineListFromSnapshot);
  }

  List<MemberModel> _memberListFromSnapshot(QuerySnapshot snapshop) {
    return snapshop.docs.map((doc) {
      return MemberModel(
        memberid: doc.data()['memberid'] ?? "",
        name: doc.data()['displayName'] ?? "",
        email: doc.data()['email'] ?? "",
        color: doc.data()['color'] ?? "",
        status: doc.data()['status'] ?? "",
      );
    }).toList();
  }

  // get list of member
  Stream<List<MemberModel>> get member {
    return userCollection
        .doc(uid)
        .collection('member')
        .snapshots()
        .map(_memberListFromSnapshot);
  }

  Future get userinfo {
    return userCollection.doc(uid).get();
  }
}
