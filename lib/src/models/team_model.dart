class TeamModel {
  int id = 0;
  String name = '';
  String shortName = '';
  String tla = '';
  String crest = '';
  String address = '';
  String website = '';

  TeamModel(
      {required this.id,
      required this.name,
      required this.shortName,
      required this.tla,
      required this.crest,
      required this.address,
      required this.website});

  TeamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crest = json['crest'];
    address = json['address'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['tla'] = this.tla;
    data['crest'] = this.crest;
    data['address'] = this.address;
    data['website'] = this.website;
    return data;
  }
}
