class Staff {
  int? staffId;
  String? staffName;
  String? department;
  String? position;

  staffMapper() {
    var mapping = Map<String, dynamic>();
    mapping['staffId'] = staffId;
    mapping['staffName'] = staffName;
    mapping['department'] = department;
    mapping['position'] = position;
    return mapping;
  }
}