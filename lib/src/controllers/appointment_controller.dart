
import 'package:flutter/foundation.dart';

class AppointmentController extends ChangeNotifier{
  bool load = false;

  DateTime? selectedDate;

  changeSelectedDate(DateTime sDate){
    selectedDate= sDate;
    notifyListeners();
  }
  final time =[];

  init(){

  }


}