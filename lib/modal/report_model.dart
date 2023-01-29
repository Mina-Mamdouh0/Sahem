
class ReportModel {
  final String id;
  final String reporter;
  final String mosque_id;
  final String nameReport;
  final String address;
  final String createdAt;
  final String name;
  final String muezzinName;
  final String muezzinPhone;
  final String imamName;
  final String imamPhone;
  final String oratorName;
  final String oratorPhone;
  final String servantName;
  final String servantPhone;
  final String neighborhood;
  final String presence;
  final String najdReading;
  final String oratorPresence;
  final String oratorCommitment;
  final String external_amplifiers;
  final String internal_amplifiers;
  final String levelOfCleanliness;
  final String otherNodes;
  final String publisherName;
  final String publisherPhone;
  final String publishedDate;
  final String rating;
  final String mosque_name;
  final String hijri_date;
  final String khotba;
   String? imageOne;
   String? imageTwo;
   String? imageThree;
   String? rating_messge;

  ReportModel(
      {required this.id,required this.reporter, required this.mosque_id,
      required this.nameReport, required this.address, required this.createdAt,
      required this.name, required this.muezzinName, required this.muezzinPhone,
      required this.imamName, required this.imamPhone, required this.oratorName,
      required this.oratorPhone, required this.servantName, required this.servantPhone,
      required this.neighborhood, required this.presence, required this.najdReading,
      required this.oratorPresence, required this.oratorCommitment,
      required this.internal_amplifiers,required this.external_amplifiers, required this.levelOfCleanliness,
      required this.otherNodes, required this.publisherName,
      required this.publisherPhone, required this.publishedDate,
        required this.rating,this.imageOne,this.imageTwo,this.imageThree,
        required this.mosque_name,required this.hijri_date,required this.khotba,
        this.rating_messge});

  factory ReportModel.fromJson(jsonData) {
    return ReportModel(
      name: jsonData['name'],
      hijri_date: jsonData['hijri_date'],
      khotba: jsonData['khotba'],
      mosque_id: jsonData['mosque_id'],
      publisherPhone: jsonData['publisherPhone'],
      id: jsonData['id'],
      publisherName: jsonData['publisherName'],
      otherNodes: jsonData['otherNodes'],
      levelOfCleanliness: jsonData['levelOfCleanliness'],
      internal_amplifiers: jsonData['internal_amplifiers'],
      external_amplifiers: jsonData['external_amplifiers'],
      oratorCommitment: jsonData['oratorCommitment'],
      oratorPresence: jsonData['oratorPresence'],
      najdReading: jsonData['najdReading'],
      presence: jsonData['presence'],
      neighborhood: jsonData['neighborhood'],
      servantPhone: jsonData['servantPhone'],
      servantName: jsonData['servantName'],
      oratorPhone: jsonData['oratorPhone'],
      oratorName: jsonData['oratorName'],
      imamPhone: jsonData['imamPhone'],
      imamName: jsonData['imamName'],
      muezzinPhone: jsonData['muezzinPhone'],
      muezzinName: jsonData['muezzinName'],
      createdAt: jsonData['createdAt'],
      address: jsonData['address'],
      nameReport: jsonData['nameReport'],
      publishedDate: jsonData['publishedDate'],
      rating: jsonData['rating'],
      reporter: jsonData['reporter'],
      rating_messge: jsonData['rating_messge'],
      imageThree: jsonData['imageThree'],
      imageTwo: jsonData['imageTwo'],
      imageOne: jsonData['imageOne'],
      mosque_name: jsonData['mosque_name'],
    );
  }
}

class MosqueDate{
  final String id;
  final String neighborhood_name;
  final String mosque_name;
  final String moazin;
  final String imam;
  final String imam_phone;
  final String moazin_phone;
  final String kahteeb;
  final String kahteeb_phone;
  final String servant_name;
  final String servant_number;

  MosqueDate(
      {required this.id,
        required this.kahteeb,
        required this.imam,
        required this.imam_phone,
        required this.kahteeb_phone,
        required this.moazin,
        required this.moazin_phone,
        required this.mosque_name,
        required this.neighborhood_name,
        required this.servant_name,
        required this.servant_number,
      });

  factory MosqueDate.fromJson(jsonData) {
    return MosqueDate(
      kahteeb: jsonData['kahteeb'],
      imam: jsonData['imam'],
      imam_phone: jsonData['imam_phone'],
      id: jsonData['id'],
      kahteeb_phone: jsonData['kahteeb_phone'],
      moazin: jsonData['moazin'],
      moazin_phone: jsonData['moazin_phone'],
      mosque_name: jsonData['mosque_name'],
      neighborhood_name: jsonData['neighborhood_name'],
      servant_name: jsonData['servant_name'],
      servant_number: jsonData['servant_number'],
    );
  }

}
