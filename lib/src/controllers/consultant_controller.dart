import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult_patient/src/collections/collection.dart';
import 'package:consult_patient/src/services/rate_consultant.dart';
import 'package:flutter/foundation.dart';


import '../models/consultant_model.dart';
import '../utils/widgets/reusable_widget.dart';

class ConsultantController extends ChangeNotifier{
  ConsultantModel? consultant;
  List<ConsultantModel> consultantList = [];
  List<ConsultantModel> consultantListSearchable = [];
  double ratings = 0;
  String? searchString = '';


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

    double calRatings = ((currentRatings! + ratings)/5);
    double newRatings = double.parse(calRatings.toString());
    print('$calRatings $newRatings $ratings heere');

     double newPercentRatings= ((newRatings)/ 5) * 100;
     print(newPercentRatings);
    final update = await ConsultantService
    .updateConsultantRatings(newRatings, consultantId);
    load =false;
    notifyListeners();
    if(update == true){
      showToast('rated successfully');
    }
  }

  getAllConsultant(){
    ConsultantService.getConsultant()!.listen((event) {
     consultantList.clear();
      event.forEach((element) => consultantList!.add(element));
      print(consultantList);
     notifyListeners();
      onSearchForConsultants(searchString!);
     notifyListeners();

    });
  }

onSearchForConsultants(String search) {
  searchString = search.toLowerCase();
  notifyListeners();

  consultantListSearchable.clear();
  if (searchString == '' ||  searchString == null) {
    print(consultantList);
   consultantList!.forEach(
            (ConsultantModel element) =>consultantListSearchable.add(element));
  notifyListeners();
  } else {
    consultantList
    !.forEach((ConsultantModel? consultantModel) {

      if (consultantModel
      !.firstName!
          .toLowerCase()
          .contains(searchString!) || consultantModel!.lastName!
      .toLowerCase()
      .contains(searchString!)) {
        consultantListSearchable.add(consultantModel!);
        notifyListeners();
      }

    });
  }
}
}