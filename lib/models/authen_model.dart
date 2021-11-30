import 'dart:convert';

class AuthenModel {
  final bool isAuthenticate;
  final ProcessResult processResult;
  final String token;
  final String empid;
  AuthenModel({
    required this.isAuthenticate,
    required this.processResult,
    required this.token,
    required this.empid,
  });

  

  

  Map<String, dynamic> toMap() {
    return {
      'IsAuthenticate': isAuthenticate,
      'ProcessResult': processResult.toMap(),
      'Token': token,
      'empid': empid,
    };
  }

  factory AuthenModel.fromMap(Map<String, dynamic> map) {
    return AuthenModel(
      isAuthenticate: map['IsAuthenticate'],
      processResult: ProcessResult.fromMap(map['ProcessResult']),
      token: map['Token'],
      empid: map['empid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenModel.fromJson(String source) => AuthenModel.fromMap(json.decode(source));
}

class ProcessResult {
  final String message;
  final bool isError;

  ProcessResult({required this.message, required this.isError});

  Map<String, dynamic> toMap() {
    return {
      'Message': message,
      'IsError': isError,
    };
  }

  factory ProcessResult.fromMap(Map<String, dynamic> map) {
    return ProcessResult(
      message: map['Message'] ?? '',
      isError: map['IsError'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProcessResult.fromJson(String source) =>
      ProcessResult.fromMap(json.decode(source));
}
