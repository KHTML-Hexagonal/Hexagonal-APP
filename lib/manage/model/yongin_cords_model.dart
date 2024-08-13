class YonginBuildingModel {
  final String? gisBuildingId;
  final String? legalDistrictName;
  final String? landLotNumber;
  final double? buildingTotalArea; // Nullable double
  final String? buildingStructureType;
  final String? primaryUse;
  final double? buildingHeight; // Nullable double
  final int? aboveGroundFloors;
  final int? belowGroundFloors;
  final String? permitDate; // Nullable String
  final String? approvalDate;
  final int? buildingAge;
  final String? dataReferenceDate;
  final double? latitude;
  final double? longitude;

  YonginBuildingModel(
    this.gisBuildingId,
    this.legalDistrictName,
    this.landLotNumber,
    this.buildingTotalArea,
    this.buildingStructureType,
    this.primaryUse,
    this.buildingHeight,
    this.aboveGroundFloors,
    this.belowGroundFloors,
    this.permitDate,
    this.approvalDate,
    this.buildingAge,
    this.dataReferenceDate,
    this.latitude,
    this.longitude,
  );

  YonginBuildingModel.fromJson(Map<String, dynamic> json)
      : gisBuildingId = json['gis_building_id'],
        legalDistrictName = json['legal_district_name'],
        landLotNumber = json['land_lot_number'],
        buildingTotalArea = (json['building_total_area'] != null)
            ? (json['building_total_area'] is int)
                ? (json['building_total_area'] as int).toDouble()
                : json['building_total_area'] as double?
            : null,
        buildingStructureType = json['building_structure_type'],
        primaryUse = json['primary_use'],
        buildingHeight = (json['building_height'] != null)
            ? (json['building_height'] is int)
                ? (json['building_height'] as int).toDouble()
                : json['building_height'] as double?
            : null,
        aboveGroundFloors = json['above_ground_floors'],
        belowGroundFloors = json['below_ground_floors'],
        permitDate = json['permit_date'],
        approvalDate = json['approval_date'],
        buildingAge = json['building_age'],
        dataReferenceDate = json['data_reference_date'],
        latitude = (json['latitude'] != null)
            ? double.tryParse(json['latitude'])
            : null,
        longitude = (json['longitude'] != null)
            ? double.tryParse(json['longitude'])
            : null;

  Map<String, dynamic> toJson() => {
        'gis_building_id': gisBuildingId,
        'legal_district_name': legalDistrictName,
        'land_lot_number': landLotNumber,
        'building_total_area': buildingTotalArea,
        'building_structure_type': buildingStructureType,
        'primary_use': primaryUse,
        'building_height': buildingHeight,
        'above_ground_floors': aboveGroundFloors,
        'below_ground_floors': belowGroundFloors,
        'permit_date': permitDate,
        'approval_date': approvalDate,
        'building_age': buildingAge,
        'data_reference_date': dataReferenceDate,
        'latitude': latitude?.toString(),
        'longitude': longitude?.toString(),
      };
}
