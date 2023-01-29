
class UserModel{
  final String status;
  final String message;
  final String name;
  final String id;
  final String identityNumber;
  final String phoneNumber;
  final String accountType;
  final String token;

  UserModel(
      {required this.status,
      required this.message,
      required this.name,
      required this.id,
      required this.identityNumber,
      required this.phoneNumber,
      required this.accountType,
      required this.token});

  factory UserModel.fromJson(jsonData) {
    return UserModel(
        status:jsonData['status'],
        message: jsonData['message'],
        name: jsonData['name'],
        id: jsonData['id'],
        identityNumber: jsonData['identity_number'],
        phoneNumber: jsonData['phone_number'],
        accountType: jsonData['account_type'],
        token: jsonData['token'],
    );
  }
}

class UserDate{
  final String id;
  final String name;
  final String number;
  final String identityNumber;
  final String token;

  UserDate(
      {required this.id,
      required this.name,
      required this.number,
      required this.identityNumber,
      required this.token});

  factory UserDate.fromJson(jsonData) {
    return UserDate(
      name: jsonData['name'],
      id: jsonData['id'],
      identityNumber: jsonData['identity_number'],
      number: jsonData['number'],
      token: jsonData['token'],
    );
  }

}

