import 'dart:convert';

class ProfileModel {
  final String employeeID;
  final String fullName;
  final String firstName;
  final String lastName;
  final String email;
  final String telephoneNumber;
   final String jobTitle;
  ProfileModel({
    required this.employeeID,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.telephoneNumber,
    required this.jobTitle,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'EmployeeID': employeeID,
      'FullName': fullName,
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'TelephoneNumber': telephoneNumber,
      'JobTitle': jobTitle,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      employeeID: map['EmployeeID'],
      fullName: map['FullName'],
      firstName: map['FirstName'],
      lastName: map['LastName'],
      email: map['Email'],
      telephoneNumber: map['TelephoneNumber'],
      jobTitle: map['JobTitle'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) => ProfileModel.fromMap(json.decode(source));
}
