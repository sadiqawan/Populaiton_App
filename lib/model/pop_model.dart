class PopulationModel {
  bool? error;
  String? msg;
  List<Data>? data;

  PopulationModel({this.error, this.msg, this.data});

  PopulationModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['error'] = error;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? city;
  String? country;
  List<PopulationCounts>? populationCounts;

  Data({this.city, this.country, this.populationCounts});

  Data.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    if (json['populationCounts'] != null) {
      populationCounts = <PopulationCounts>[];
      json['populationCounts'].forEach((v) {
        populationCounts!.add(PopulationCounts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['city'] = city;
    data['country'] = country;
    if (populationCounts != null) {
      data['populationCounts'] =
          populationCounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PopulationCounts {
  String? year;
  String? value;
  String? sex;
  String? reliabilty;

  PopulationCounts({this.year, this.value, this.sex, this.reliabilty});

  PopulationCounts.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    value = json['value'];
    sex = json['sex'];
    reliabilty = json['reliabilty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = year;
    data['value'] = value;
    data['sex'] = sex;
    data['reliabilty'] = reliabilty;
    return data;
  }
}
