class CountriesListModel {
  int? updated;
  String? country;
  CountryInfo? countryInfo;

  CountriesListModel({
    this.updated,
    this.country,
    this.countryInfo,
  });

  CountriesListModel.fromJson(Map<dynamic, dynamic> json) {
    updated = json['updated'];
    country = json['country'];
    countryInfo = json['countryInfo'] != null
        ? new CountryInfo.fromJson(json['countryInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated'] = this.updated;
    data['country'] = this.country;
    if (this.countryInfo != null) {
      data['countryInfo'] = this.countryInfo!.toJson();
    }
    return data;
  }
}

class CountryInfo {
  String? flag;

  CountryInfo({this.flag});

  CountryInfo.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['flag'] = this.flag;
    return data;
  }
}
