class AnalysisSummary {
  String? response;
  int? totalCount;
  List<RecordedData>? data;
  int? totalPages;
  int? currentPage;

  AnalysisSummary({
    this.response,
    this.totalCount,
    this.data,
    this.totalPages,
    this.currentPage,
  });

  factory AnalysisSummary.fromJson(Map<String, dynamic> json) =>
      AnalysisSummary(
        response: json["response"],
        totalCount: json["totalCount"],
        data: json["data"] == null
            ? []
            : List<RecordedData>.from(
                json["data"]!.map((x) => RecordedData.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "totalCount": totalCount,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class RecordedData {
  int? id;
  AnalysisDatas? analysisData;
  String? comments;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? clientId;

  RecordedData({
    this.id,
    this.analysisData,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.clientId,
  });

  factory RecordedData.fromJson(Map<String, dynamic> json) => RecordedData(
        id: json["id"],
        analysisData: json["analysis_data"] == null
            ? null
            : AnalysisDatas.fromJson(json["analysis_data"]),
        comments: json["comments"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        clientId: json["clientId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "analysis_data": analysisData?.toJson(),
        "comments": comments,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "clientId": clientId,
      };
}

class AnalysisDatas {
  String? f1;
  String? f2;
  String? f3;
  String? f4;
  String? meanHnr;
  String? meandda;
  String? meanddp;
  String? meanrap;
  String? maxpitch;
  String? meanapq3;
  String? meanppq5;
  String? minpitch;
  String? meanapq11;
  String? meanaqpq5;
  String? meanpitch;
  String? meansdHnr;
  String? meanlocaldb;
  String? meansdpitch;
  String? meanlocaljitter;
  String? meanlocalshimmer;
  String? meanlocalabsolute;

  AnalysisDatas({
    this.f1,
    this.f2,
    this.f3,
    this.f4,
    this.meanHnr,
    this.meandda,
    this.meanddp,
    this.meanrap,
    this.maxpitch,
    this.meanapq3,
    this.meanppq5,
    this.minpitch,
    this.meanapq11,
    this.meanaqpq5,
    this.meanpitch,
    this.meansdHnr,
    this.meanlocaldb,
    this.meansdpitch,
    this.meanlocaljitter,
    this.meanlocalshimmer,
    this.meanlocalabsolute,
  });

  factory AnalysisDatas.fromJson(Map<String, dynamic> json) => AnalysisDatas(
        f1: json["f1"],
        f2: json["f2"],
        f3: json["f3"],
        f4: json["f4"],
        meanHnr: json["meanHNR"],
        meandda: json["meandda"],
        meanddp: json["meanddp"],
        meanrap: json["meanrap"],
        maxpitch: json["maxpitch"],
        meanapq3: json["meanapq3"],
        meanppq5: json["meanppq5"],
        minpitch: json["minpitch"],
        meanapq11: json["meanapq11"],
        meanaqpq5: json["meanaqpq5"],
        meanpitch: json["meanpitch"],
        meansdHnr: json["meansdHNR"],
        meanlocaldb: json["meanlocaldb"],
        meansdpitch: json["meansdpitch"],
        meanlocaljitter: json["meanlocaljitter"],
        meanlocalshimmer: json["meanlocalshimmer"],
        meanlocalabsolute: json["meanlocalabsolute"],
      );

  Map<String, dynamic> toJson() => {
        "f1": f1,
        "f2": f2,
        "f3": f3,
        "f4": f4,
        "meanHNR": meanHnr,
        "meandda": meandda,
        "meanddp": meanddp,
        "meanrap": meanrap,
        "maxpitch": maxpitch,
        "meanapq3": meanapq3,
        "meanppq5": meanppq5,
        "minpitch": minpitch,
        "meanapq11": meanapq11,
        "meanaqpq5": meanaqpq5,
        "meanpitch": meanpitch,
        "meansdHNR": meansdHnr,
        "meanlocaldb": meanlocaldb,
        "meansdpitch": meansdpitch,
        "meanlocaljitter": meanlocaljitter,
        "meanlocalshimmer": meanlocalshimmer,
        "meanlocalabsolute": meanlocalabsolute,
      };
}
