class JPAddress {
  late String? zip;
  late String? address;
  late String? enPrefectures;
  late String? enCity;
  late String? enTown;

  JPAddress({
    this.zip,
    this.address,
    this.enPrefectures,
    this.enCity,
    this.enTown,
  });

  Map<String, dynamic> toMap() {
    return {
      'zip': zip,
      'address': address,
      'enPrefectures': enPrefectures,
      'enCity': enCity,
      'enTown': enTown,
    };
  }

  JPAddress.fromJson(Map<dynamic, dynamic> json) {
    zip = json['zip'];
    address = json['address'];
    enPrefectures = json['enPrefectures'];
    enCity = json['enCity'];
    enTown = json['enTown'];
  }
}
