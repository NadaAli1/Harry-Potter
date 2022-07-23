class AllCharacters {
  late String name;
  late String species;
  late String gender;
  late String house;
  late String dateOfBirth;
  late bool wizard;
  late String ancestry;
  late String eyeColor;
  late String hairColor;
  late String patronus;
  late bool hogwartsStudent;
  late bool hogwartsStaff;
  late String actorName;
  late bool alive;
  late String image;

  AllCharacters.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    species = json['species'];
    gender = json['gender'];
    house = json['house'];
    dateOfBirth = json['dateOfBirth'];
    wizard = json['wizard'];
    ancestry = json['ancestry'];
    eyeColor = json['eyeColour'];
    hairColor = json['hairColour'];
    patronus = json['patronus'];
    hogwartsStudent = json['hogwartsStudent'];
    hogwartsStaff = json['hogwartsStaff'];
    actorName = json['actor'];
    alive = json['alive'];
    image = json['image'];
  }
}
