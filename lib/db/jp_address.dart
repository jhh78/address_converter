class JpAddress {
  late String? zip;
  late String? jp;
  late String? enPrefectures;
  late String? enCity;
  late String? enTown;

  JpAddress({
    this.zip,
    this.jp,
    this.enPrefectures,
    this.enCity,
    this.enTown,
  });

  Map<String, dynamic> toMap() {
    return {
      'zip': zip,
      'jp': jp,
      'enPrefectures': enPrefectures,
      'enCity': enCity,
      'enTown': enTown,
    };
  }

  JpAddress.fromJson(Map<dynamic, dynamic> json) {
    zip = json['zip'];
    jp = json['jp'];
    enPrefectures = json['enPrefectures'];
    enCity = json['enCity'];
    enTown = json['enTown'];
  }
}
