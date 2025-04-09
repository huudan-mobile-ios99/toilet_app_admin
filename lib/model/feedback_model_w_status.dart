class DatumWStatus {
  final String id;
  final String datumId;
  final String driver;
  final int star;
  final String content;
  final List<String> experience;
  final DateTime createdAt;
  final int v;
  final bool isprocess;
  final DateTime processCreatedAt;

  DatumWStatus({
    required this.id,
    required this.datumId,
    required this.driver,
    required this.star,
    required this.content,
    required this.experience,
    required this.createdAt,
    required this.v,
    required this.isprocess,
    required this.processCreatedAt,
  });

  factory DatumWStatus.fromJson(Map<String, dynamic> json) {
    return DatumWStatus(
      id: json["_id"],
      datumId: json["id"],
      driver: json["driver"],
      star: json["star"],
      content: json["content"],
      experience: List<String>.from(json["experience"].map((x) => x)),
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : DateTime(2000),
      v: json["__v"],
      isprocess: json['isprocess'],
      processCreatedAt: json['processCreatedAt'] != null
          ? DateTime.parse(json['processCreatedAt'])
          : DateTime.now(),
    );
  }
}

class FeedbackModelWStatus {
  final bool status;
  final String message;
  final int totalResult;
  final List<DatumWStatus> data;

  FeedbackModelWStatus({
    required this.status,
    required this.message,
    required this.totalResult,
    required this.data,
  });

  factory FeedbackModelWStatus.fromJson(Map<String, dynamic> json) {
    return FeedbackModelWStatus(
      status: json["status"],
      message: json["message"],
      totalResult: json["totalResult"],
      data: List<DatumWStatus>.from(
          json["data"].map((x) => DatumWStatus.fromJson(x))),
    );
  }
}