class Contact {
  final String id;
  final String user;
  final String name;
  final String phoneNumber;
  final bool isDeletable;

  const Contact({
    required this.id,
    required this.user,
    required this.name,
    required this.phoneNumber,
    this.isDeletable = true,
  });

  factory Contact.fromJson(Map<String, dynamic> parsedJson, String id){
    return Contact(
      id: id,
      user: parsedJson['user'].toString(),
      name: parsedJson['name'].toString(),
      phoneNumber: parsedJson['phoneNumber'].toString(),
      isDeletable: parsedJson['isDeletable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
    'user': this.user,
    'name': this.name,
    'phoneNumber': this.phoneNumber,
    'isDeletable': this.isDeletable,
  };
}