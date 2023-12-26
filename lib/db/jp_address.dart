class JpAddress {
  late String? zipcode;
  late String? jp;
  late String? en;

  JpAddress({this.zipcode, this.jp, this.en});

  Map<String, dynamic> toMap() {
    return {
      'zipcode': zipcode,
      'jp': jp,
      'en': en,
    };
  }

  JpAddress.fromJson(Map<dynamic, dynamic> json) {
    zipcode = json['zipcode'];
    jp = json['jp'];
    en = json['en'];
  }
}
