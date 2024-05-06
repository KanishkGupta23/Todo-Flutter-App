import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService{

  final taskCollection = "Tasks";

  Future addTask(Map<String,dynamic> taskMap, String id)async{
    return await FirebaseFirestore.instance
    .collection(taskCollection)
    .doc(id)
    .set(taskMap);
  }

  Future <Stream<QuerySnapshot>>getTask(bool taskType)async{ 
    final resultVal = await FirebaseFirestore.instance.collection(taskCollection).where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("Yes", isEqualTo: taskType).snapshots();
    print(resultVal);
    return resultVal;
  }

  getTaskCountOfCompleteAndIncomplete(bool taskType) {
    return FirebaseFirestore.instance.collection(taskCollection).where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("Yes", isEqualTo:taskType).count().get().then((value) => value.count);
    // int? result = myTasks.count;
    // return result;
  }

  tickMethod(String id, bool val)async{
    return await FirebaseFirestore.instance.collection(taskCollection).doc(id).update({"Yes": val});
  }

   removeMethod(String id)async{
    return await FirebaseFirestore.instance.collection(taskCollection).doc(id).delete();
  }

  updateMethod(String id, String newWork)async{
    return await FirebaseFirestore.instance.collection(taskCollection).doc(id).update({"work": newWork});
  }

}