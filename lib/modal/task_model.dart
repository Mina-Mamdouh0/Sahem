
class TaskModel{
  final  String to;
  final  String from;
  final  String id;
  final  String subject;
  final  String nameSubject;
  final  String massage;
  final  String date;

  TaskModel(
      {required this.to,
        required this.id,
      required this.from,
      required this.subject,
      required this.nameSubject,
      required this.massage,
      required this.date});

  factory TaskModel.fromJson(jsonData) {
    return TaskModel(
      to:jsonData['to'],
      id: jsonData['id'],
      from: jsonData['from'],
      subject: jsonData['subject'],
      nameSubject: jsonData['nameSubject'],
      massage: jsonData['massage'],
      date: jsonData['date'],
    );
  }
}
