class Patient{

  String? userName;
  String? email;
  String? firstName;
  String? lastName;
  String? age;
  String? weight;
  String? height;
  String? gender;
  String? allergies;
  DateTime? createdAt;
  String? medicalConditions;
  Patient({this.email,this.userName,this.lastName,this.firstName,this.medicalConditions,this.allergies,this.height,this.createdAt,this.age,this.gender,this.weight});

  Patient.fromJson(Map<dynamic,dynamic> data){
    userName=data['userName'];
    email=data['email'];
    firstName=data['firstName'];
    lastName=data['lastName'];
    age=data['age'];
    weight=data['weight'];
    height=data['height'];
    gender=data['gender'];
    allergies=data['allergies'];
    medicalConditions=data['medicalConditions'];
  }

  toJson(){
    Map<String,dynamic> data={};
    data['userName']=userName;
    data['email']=email;
    data['firstName']=firstName;
    data['lastName']=lastName;
    data['age']=age;
    data['weight']=weight;
    data['height']=height;
    data['gender']=gender;
    data['allergies']=allergies;
    return data;
  }
}