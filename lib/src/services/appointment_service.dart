import 'package:consult_patient/src/collections/collection.dart';
import 'package:consult_patient/src/models/appointment_model.dart';

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
}