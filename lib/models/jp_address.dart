class JPAddress {
  late String? zip;
  late String? address1;
  late String? address2;
  late String? enPrefectures;
  late String? enCity;
  late String? enTown;
  late String? enStreet;

  JPAddress({
    this.zip,
    this.address1,
    this.address2,
    this.enPrefectures,
    this.enCity,
    this.enTown,
    this.enStreet,
  });

  Map<String, dynamic> toMap() {
    return {
      'zip': zip,
      'address1': address1,
      'address2': address2,
      'enPrefectures': enPrefectures,
      'enCity': enCity,
      'enTown': enTown,
      'enStreet': enStreet
    };
  }

  JPAddress.fromJson(Map<dynamic, dynamic> json) {
    zip = json['zip'];
    address1 = json['address1'];
    address2 = json['address2'];
    enPrefectures = json['enPrefectures'];
    enCity = json['enCity'];
    enTown = json['enTown'];
    enStreet = json['enStreet'];
  }
}
