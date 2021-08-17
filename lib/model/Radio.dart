class EgyptModel {
  String title;
  String description;
  String genre;
  String country;
  String language;
  String source1;
  String source2;
  String source3;
  String source4;
  String source5;
  String source6;

  EgyptModel(
      {this.title,
      this.description,
      this.genre,
      this.country,
      this.language,
      this.source1,
      this.source2,
      this.source3,
      this.source4,
      this.source5,
      this.source6});

  EgyptModel.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    description = json['Description'];
    genre = json['Genre'];
    country = json['Country'];
    language = json['Language'];
    source1 = json['Source1'];
    source2 = json['Source2'];
    source3 = json['Source3'];
    source4 = json['Source4'];
    source5 = json['Source5'];
    source6 = json['Source6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Genre'] = this.genre;
    data['Country'] = this.country;
    data['Language'] = this.language;
    data['Source1'] = this.source1;
    data['Source2'] = this.source2;
    data['Source3'] = this.source3;
    data['Source4'] = this.source4;
    data['Source5'] = this.source5;
    data['Source6'] = this.source6;
    return data;
  }
}