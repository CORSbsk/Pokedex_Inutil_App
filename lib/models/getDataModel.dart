class GetDataModel {
  final List<Result> results;

  GetDataModel({
    required this.results,
  });

  factory GetDataModel.fromJson(Map<String, dynamic> json) => GetDataModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  final int pokId;
  final int pokNum;
  final String pokName;
  final String pokImg;
  final String pokFirstType;
  final String pokSecondType;
  final String pokHeight;
  final String pokWeight;
  final String pokGif;

  Result({
    required this.pokId,
    required this.pokNum,
    required this.pokName,
    required this.pokImg,
    required this.pokFirstType,
    required this.pokSecondType,
    required this.pokHeight,
    required this.pokWeight,
    required this.pokGif,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        pokId: json["pok_id"],
        pokNum: json["pok_num"],
        pokName: json["pok_name"],
        pokImg: json["pok_img"],
        pokFirstType: json["pok_firstType"],
        pokSecondType: json["pok_secondType"],
        pokHeight: json["pok_height"],
        pokWeight: json["pok_weight"],
        pokGif: json["pok_gif"],
      );

  Map<String, dynamic> toJson() => {
        "pok_id": pokId,
        "pok_num": pokNum,
        "pok_name": pokName,
        "pok_img": pokImg,
        "pok_firstType": pokFirstType,
        "pok_secondType": pokSecondType,
        "pok_height": pokHeight,
        "pok_weight": pokWeight,
        "pok_gif": pokGif,
      };
}
