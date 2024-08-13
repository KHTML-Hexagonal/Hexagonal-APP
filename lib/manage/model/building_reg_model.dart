class BuildingRegistrationResponse {
  final String result;
  final BuildingData data;
  final String? error;

  BuildingRegistrationResponse({
    required this.result,
    required this.data,
    this.error,
  });

  factory BuildingRegistrationResponse.fromJson(Map<String, dynamic> json) {
    return BuildingRegistrationResponse(
      result: json['result'],
      data: BuildingData.fromJson(json['data']),
      error: json['error'],
    );
  }
}

class BuildingData {
  final String structureReason;
  final String roofMaterial;
  final String roofCondition;
  final String wallMaterial;
  final String wallCondition;
  final String windowDoorMaterial;
  final String windowDoorCondition;
  final String overallCondition;
  final String conditionReason;
  final int crackScore;
  final int leakScore;
  final int corrosionScore;
  final int agingScore;
  final int totalScore;
  final String repairList;

  BuildingData({
    required this.structureReason,
    required this.roofMaterial,
    required this.roofCondition,
    required this.wallMaterial,
    required this.wallCondition,
    required this.windowDoorMaterial,
    required this.windowDoorCondition,
    required this.overallCondition,
    required this.conditionReason,
    required this.crackScore,
    required this.leakScore,
    required this.corrosionScore,
    required this.agingScore,
    required this.totalScore,
    required this.repairList,
  });

  factory BuildingData.fromJson(Map<String, dynamic> json) {
    return BuildingData(
      structureReason: json['structureReason'],
      roofMaterial: json['roofMaterial'],
      roofCondition: json['roofCondition'],
      wallMaterial: json['wallMaterial'],
      wallCondition: json['wallCondition'],
      windowDoorMaterial: json['windowDoorMaterial'],
      windowDoorCondition: json['windowDoorCondition'],
      overallCondition: json['overallCondition'],
      conditionReason: json['conditionReason'],
      crackScore: json['crackScore'],
      leakScore: json['leakScore'],
      corrosionScore: json['corrosionScore'],
      agingScore: json['agingScore'],
      totalScore: json['totalScore'],
      repairList: json['repairList'],
    );
  }
}
