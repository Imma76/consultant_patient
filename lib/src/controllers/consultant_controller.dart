import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult_patient/src/collections/collection.dart';
import 'package:consult_patient/src/services/rate_consultant.dart';
import 'package:flutter/cupertino.dart';

import '../models/consultant_model.dart';
import '../utils/widgets/reusable_widget.dart';

class ConsultantController extends ChangeNotifier{
  Consultant? consultant;
  double ratings = 0;


  bool load=false;

  updateRating(double newRatings){
    ratings= newRatings;
    notifyListeners();
  }

  Stream<QuerySnapshot> getConsultants(){
    return Collections.consultant.snapshots();
  }

  Future rateConsultant({ required
  double? currentRatings,required String? consultantId})async{
    load =true;
    notifyListeners();
    String calRatings = (currentRatings! + (ratings!/3)).toStringAsFixed(1);
    double newRatings = double.parse(calRatings);

    final update = await ConsultantService
    .updateConsultantRatings(newRatings, consultantId);
    load =false;
    notifyListeners();
    if(update == true){
      showToast('rated successfully');
    }
  }
}