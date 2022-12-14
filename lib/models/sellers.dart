class Sellers {
  String? name;
  String? uid;
  String? photoUrl;
  String? email;
  Map? ratings;

  Sellers({
    this.name,
    this.uid,
    this.photoUrl,
    this.email,
    this.ratings,
  });

  Sellers.fromJson(Map<String, dynamic> json) {
    name = json["fullname"];
    uid = json["uid"];
    photoUrl = json["photoUrl"];
    email = json["email"];
    ratings = json["ratings"];
  }
}
