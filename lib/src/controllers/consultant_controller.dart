import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult_patient/src/collections/collection.dart';
import 'package:flutter/cupertino.dart';

import '../models/consultant_model.dart';

class ConsultantController extends ChangeNotifier{
  Consultant? consultant;

  Stream<QuerySnapshot> getConsultants(){
    return Collections.consultant.snapshots();
  }
}