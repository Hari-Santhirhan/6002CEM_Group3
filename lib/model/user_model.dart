class Users {
  final String id;
  final String imagePath;
  final String name;
  final String gender;
  final String email;
  final String date;
  final String report;
  final String location;


  const Users({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.gender,
    required this.email,
    required this.date,
    required this.report,
    required this.location,

  });

  factory Users.fromJson(Map<String, dynamic> parsedJson){
    return Users(
        id: parsedJson['id'].toString(),
        imagePath: parsedJson['imagePath'].toString(),
        name: parsedJson['name'].toString(),
        gender: parsedJson['gender'].toString(),
        email : parsedJson['email'].toString(),
        date: parsedJson['date'].toString(),
        report: parsedJson['report'].toString(),
        location: parsedJson['location'].toString(),

    );
  }

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'imagePath': this.imagePath,
    'name': this.name,
    'gender': this.gender,
    'email': this.email,
    'date': this.date,
    'report': this.report,
    'location': this.location,
  };
}
