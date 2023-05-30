import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult_patient/src/collections/collection.dart';
import 'package:consult_patient/src/controllers/central_state.dart';
import 'package:consult_patient/src/controllers/user_controller.dart';
import 'package:consult_patient/src/models/appointment_model.dart';
import 'package:consult_patient/src/models/consultant_model.dart';

class AppointmentService{
  static Future createAppointment(AppointmentModel appointmentModel)async{
    print('ooo');
    try{

      final create = await Collections.appointment.add(appointmentModel.toJson());

      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  static Future<List<AppointmentModel>?>? getAppointmentHistory()async{
    try{
      QuerySnapshot query = await Collections.appointment.where("patient.userId",isEqualTo:userController.patient!.userId).get();
      return query.docs.map((e)=> AppointmentModel.fromJson(e.data() as Map<String, dynamic>)).toList(
      );
    }catch(e){
      print(e.toString());
    }
  }

}