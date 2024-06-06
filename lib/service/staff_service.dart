import 'package:demo/models/staff.dart';
import 'package:demo/repository/staff_repository.dart';

class StaffService {
  late StaffRepository _staffRepository;

  StaffService() {
    _staffRepository = StaffRepository();
  }

  insertStaff(Staff staff) async {
    return await _staffRepository.insertStaff('Staff', staff.staffMapper());
  }

  updateStaff(Staff staff) async {
    return await _staffRepository.updateStaff('Staff', staff.staffMapper());
  }

  getStaffs() async {
    return await _staffRepository.getStaffs('Staff');
  }

  getStaffById(staffId) async {
    return _staffRepository.getStaffById('Staff', staffId);
  }

  deleteStaff(staffId) async {
    return _staffRepository.deleteStaff('Staff', staffId);
  }
}