class AnalysisModel {
  String? response;
  AnalysisData? data;

  AnalysisModel({
    this.response,
    this.data,
  });

  factory AnalysisModel.fromJson(Map<String, dynamic> json) => AnalysisModel(
        response: json["response"],
        data: json["data"] == null ? null : AnalysisData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "data": data?.toJson(),
      };
}

class AnalysisData {
  String? meanlocaljitter;
  String? meanlocalabsolute;
  String? meanrap;
  String? meanppq5;
  String? meanddp;
  String? meanlocalshimmer;
  String? meanlocaldb;
  String? meanapq3;
  String? meanaqpq5;
  String? meanapq11;
  String? meandda;
  String? meanpitch;
  String? meansdpitch;
  String? minpitch;
  String? maxpitch;
  String? meanHnr;
  String? meansdHnr;
  String? f1;
  String? f2;
  String? f3;
  String? f4;

  AnalysisData({
    this.meanlocaljitter,
    this.meanlocalabsolute,
    this.meanrap,
    this.meanppq5,
    this.meanddp,
    this.meanlocalshimmer,
    this.meanlocaldb,
    this.meanapq3,
    this.meanaqpq5,
    this.meanapq11,
    this.meandda,
    this.meanpitch,
    this.meansdpitch,
    this.minpitch,
    this.maxpitch,
    this.meanHnr,
    this.meansdHnr,
    this.f1,
    this.f2,
    this.f3,
    this.f4,
  });

  factory AnalysisData.fromJson(Map<String, dynamic> json) => AnalysisData(
        meanlocaljitter: json["meanlocaljitter"],
        meanlocalabsolute: json["meanlocalabsolute"],
        meanrap: json["meanrap"],
        meanppq5: json["meanppq5"],
        meanddp: json["meanddp"],
        meanlocalshimmer: json["meanlocalshimmer"],
        meanlocaldb: json["meanlocaldb"],
        meanapq3: json["meanapq3"],
        meanaqpq5: json["meanaqpq5"],
        meanapq11: json["meanapq11"],
        meandda: json["meandda"],
        meanpitch: json["meanpitch"],
        meansdpitch: json["meansdpitch"],
        minpitch: json["minpitch"],
        maxpitch: json["maxpitch"],
        meanHnr: json["meanHNR"],
        meansdHnr: json["meansdHNR"],
        f1: json["f1"],
        f2: json["f2"],
        f3: json["f3"],
        f4: json["f4"],
      );

  Map<String, dynamic> toJson() => {
        "meanlocaljitter": meanlocaljitter,
        "meanlocalabsolute": meanlocalabsolute,
        "meanrap": meanrap,
        "meanppq5": meanppq5,
        "meanddp": meanddp,
        "meanlocalshimmer": meanlocalshimmer,
        "meanlocaldb": meanlocaldb,
        "meanapq3": meanapq3,
        "meanaqpq5": meanaqpq5,
        "meanapq11": meanapq11,
        "meandda": meandda,
        "meanpitch": meanpitch,
        "meansdpitch": meansdpitch,
        "minpitch": minpitch,
        "maxpitch": maxpitch,
        "meanHNR": meanHnr,
        "meansdHNR": meansdHnr,
        "f1": f1,
        "f2": f2,
        "f3": f3,
        "f4": f4,
      };
}
