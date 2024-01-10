class JPAddress {
  late String? zip;
  late String? address;
  late String? enPrefectures;
  late String? enCity;
  late String? enTown;
  late String? enStreet;

  JPAddress({
    this.zip,
    this.address,
    this.enPrefectures,
    this.enCity,
    this.enTown,
    this.enStreet,
  });

  Map<String, dynamic> toMap() {
    return {
      'zip': zip,
      'address': address,
      'enPrefectures': enPrefectures,
      'enCity': enCity,
      'enTown': enTown,
      'enStreet': null
    };
  }

  JPAddress.fromJson(Map<dynamic, dynamic> json) {
    zip = json['zip'];
    address = json['address'];
    enPrefectures = json['enPrefectures'];
    enCity = json['enCity'];
    enTown = json['enTown'];
    enStreet = null;
  }
}
