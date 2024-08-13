class BuildingDetailModel {
  final List<String> images;
  final String buildingId;
  final String address;
  final String description;
  final String phoneNumber;
  final int crackScore;
  final int leakScore;
  final int corrosionScore;
  final int agingScore;
  final int totalScore;
  final String repairList;
  final String roofMaterial;
  final String buildingStructureType;
  final String wallMaterial;
  final String windowDoorMaterial;

  BuildingDetailModel.fromJson(Map<String, dynamic> json)
      : images = (json['images'] as List<dynamic>)
            .map((image) => image as String)
            .toList(),
        buildingId = json['buildingId'] ?? '',
        address = json['address'] ?? '',
        description = json['description'] ?? '',
        phoneNumber = json['phoneNumber'] ?? '',
        crackScore = json['crackScore'] ?? 0,
        leakScore = json['leakScore'] ?? 0,
        corrosionScore = json['corrosionScore'] ?? 0,
        agingScore = json['agingScore'] ?? 0,
        totalScore = json['totalScore'] ?? 0,
        repairList = json['repairList'] ?? '',
        roofMaterial = json['roofMaterial'] ?? '',
        buildingStructureType = json['buildingStructureType'] ?? '',
        wallMaterial = json['wallMaterial'] ?? '',
        windowDoorMaterial = json['windowDoorMaterial'] ?? '';
}
