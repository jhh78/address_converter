class KRAddress {
  late String? zip;
  late String? address1;
  late String? enPrefectures;
  late String? enCity;
  late String? enTown;
  late String? enStreet;

  KRAddress(
      {this.zip,
      this.address1,
      this.enPrefectures,
      this.enCity,
      this.enTown,
      this.enStreet});

  Map<String, dynamic> toMap() {
    return {
      'zip': zip,
      'address1': address1,
      'enPrefectures': enPrefectures,
      'enCity': enCity,
      'enTown': enTown,
      'enStreet': enStreet
    };
  }

  KRAddress.fromJson(Map<dynamic, dynamic> json) {
    zip = json['zip'];
    address1 = json['address1'];
    enPrefectures = json['enPrefectures'];
    enCity = json['enCity'];
    enTown = json['enTown'];
    enStreet = json['enStreet'];
  }
}
