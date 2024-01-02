class KRAddress {
  late String? zip;
  late String? address;
  late String? enPrefectures;
  late String? enCity;
  late String? enTown;
  late String? enStreet;

  KRAddress(
      {this.zip,
      this.address,
      this.enPrefectures,
      this.enCity,
      this.enTown,
      this.enStreet});

  Map<String, dynamic> toMap() {
    return {
      'zip': zip,
      'address': address,
      'enPrefectures': enPrefectures,
      'enCity': enCity,
      'enTown': enTown,
      'enStreet': enStreet
    };
  }

  KRAddress.fromJson(Map<dynamic, dynamic> json) {
    zip = json['zip'];
    address = json['address'];
    enPrefectures = json['enPrefectures'];
    enCity = json['enCity'];
    enTown = json['enTown'];
    enStreet = json['enStreet'];
  }
}
