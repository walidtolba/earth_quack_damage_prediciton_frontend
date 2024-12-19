class BuildingData {
  final int countFloorsPreEq; // 1 to 9
  final int ageBuilding; // 0 to 999
  final double plinthAreaSqFt; // 70 to 5000
  final double heightFtPreEq; // 6 to 99
  final String landSurfaceCondition; // ['Flat', 'Moderate slope', 'Steep slope']
  final String foundationType; // ['Other', 'Mud mortar-Stone/Brick', ...]
  final String roofType; // ['Bamboo/Timber-Light roof', ...]
  final String groundFloorType; // ['Mud', 'Brick/Stone', 'RC', ...]
  final String otherFloorType; // ['Not applicable', 'Timber/Bamboo-Mud', ...]
  final String position; // ['Not attached', 'Attached-1 side', ...]
  final String planConfiguration; // ['Rectangular', 'L-shape', ...]
  final String technicalSolutionProposed; // ['Major repair', 'Reconstruction', ...]
  final String hasSuperstructure; // ['adobe_mud', 'mud_mortar_stone', ...]
  final String address;
  final double latitude; // Ensure proper typing
  final double longitude; // Ensure proper typing

  BuildingData({
    required this.countFloorsPreEq,
    required this.ageBuilding,
    required this.plinthAreaSqFt,
    required this.heightFtPreEq,
    required this.landSurfaceCondition,
    required this.foundationType,
    required this.roofType,
    required this.groundFloorType,
    required this.otherFloorType,
    required this.position,
    required this.planConfiguration,
    required this.technicalSolutionProposed,
    required this.hasSuperstructure,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  // Factory method to create an instance from JSON
  factory BuildingData.fromJson(Map<String, dynamic> json) {
    print(json);
    return BuildingData(
      countFloorsPreEq: json['count_floors_pre_eq'],
      ageBuilding: json['age_building'],
      plinthAreaSqFt: json['plinth_area_sq_ft'].toDouble(),
      heightFtPreEq: json['height_ft_pre_eq'].toDouble(),
      landSurfaceCondition: json['land_surface_condition'],
      foundationType: json['foundation_type'],
      roofType: json['roof_type'],
      groundFloorType: json['ground_floor_type'],
      otherFloorType: json['other_floor_type'],
      position: json['position'],
      planConfiguration: json['plan_configuration'],
      technicalSolutionProposed: json['technical_solution_proposed'],
      hasSuperstructure: json['has_superstructure'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }


  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'count_floors_pre_eq': countFloorsPreEq,
      'age_building': ageBuilding,
      'plinth_area_sq_ft': plinthAreaSqFt,
      'height_ft_pre_eq': heightFtPreEq,
      'land_surface_condition': landSurfaceCondition,
      'foundation_type': foundationType,
      'roof_type': roofType,
      'ground_floor_type': groundFloorType,
      'other_floor_type': otherFloorType,
      'position': position,
      'plan_configuration': planConfiguration,
      'technical_solution_proposed': technicalSolutionProposed,
      'has_superstructure': hasSuperstructure,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}


// count_floors_pre_eq (1 to 9)
// age_building (0 to 999)
// plinth_area_sq_ft (70 to 5000)
// height_ft_pre_eq (6 to 99)
// land_surface_condition ['Flat', 'Moderate slope', 'Steep slope']
// foundation_type ['Other', 'Mud mortar-Stone/Brick', 'Cement-Stone/Brick', 'RC']
// roof_type ['Bamboo/Timber-Light roof', 'Bamboo/Timber-Heavy roof', 'RCC/RB/RBC']
// ground_floor_type ['Mud', 'Brick/Stone', 'RC', 'Timber', 'Other']
// other_floor_type ['Not applicable', 'TImber/Bamboo-Mud', 'Timber-Planck', 'RCC/RB/RBC'] 
// position ['Not attached', 'Attached-1 side', 'Attached-2 side', 'Attached-3 side']
// plan_configuration ['Rectangular', 'L-shape', 'Square', 'T-shape', 'Multi-projected','H-shape', 'U-shape', 'Others', 'E-shape','Building with Central Courtyard']
// technical_solution_proposed ['Major repair', 'Reconstruction', 'Minor repair', 'No need']
// has_superstructure = ['adobe_mud','mud_mortar_stone','stone_flag','cement_mortar_stone','mud_mortar_brick','cement_mortar_brick','timber','rc_non_engineered','rc_engineered','other']

