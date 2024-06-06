import 'package:flutter/material.dart';
import 'package:demo/models/staff.dart';
import 'package:demo/service/staff_service.dart';

class AddStaff extends StatefulWidget {
  const AddStaff({super.key});

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  var staffIdController = TextEditingController();
  var staffNameController = TextEditingController();
  var staffDepartmentController = TextEditingController();
  var staffPositionController = TextEditingController();

  var validateStaffId = false;
  var validateStaffName = false;
  var validateStaffDepartment = false;
  var validateStaffPosition = false;

  var staffService = StaffService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD NEW STAFF',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Staff Information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: staffIdController,
                decoration: InputDecoration(
                  hintText: 'Input staff id',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  label: const Text('Staff Id', style: TextStyle(color: Colors.teal)),
                  errorText: validateStaffId ? 'Staff id is empty' : '',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: staffNameController,
                decoration: InputDecoration(
                  hintText: 'Input staff name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  label: const Text('Staff Name', style: TextStyle(color: Colors.teal)),
                  errorText: validateStaffName ? 'Staff name is empty' : '',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: staffDepartmentController,
                decoration: InputDecoration(
                  hintText: 'Input staff department',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  label: const Text('Department', style: TextStyle(color: Colors.teal)),
                  errorText: validateStaffDepartment ? 'Department is empty' : '',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: staffPositionController,
                decoration: InputDecoration(
                  hintText: 'Input staff position',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  label: const Text('Position', style: TextStyle(color: Colors.teal)),
                  errorText: validateStaffPosition ? 'Position is empty' : '',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      setState(() {
                        staffIdController.text.isEmpty ? validateStaffId = true : validateStaffId = false;
                        staffNameController.text.isEmpty ? validateStaffName = true : validateStaffName = false;
                        staffDepartmentController.text.isEmpty ? validateStaffDepartment = true : validateStaffDepartment = false;
                        staffPositionController.text.isEmpty ? validateStaffPosition = true : validateStaffPosition = false;
                      });

                      if (!validateStaffId && !validateStaffName && !validateStaffDepartment && !validateStaffPosition) {
                        var staff = Staff();
                        staff.staffId = int.parse(staffIdController.text);
                        staff.staffName = staffNameController.text;
                        staff.department = staffDepartmentController.text;
                        staff.position = staffPositionController.text;

                        var result = await staffService.insertStaff(staff);
                        if (result != null) {
                          showAlertDialog('Notification', 'Added new staff successfully');
                        } else {
                          showAlertDialog('Notification', 'Failed to add new staff');
                        }
                      }
                    },
                    child: const Text('Save'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      clearForm();
                    },
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(String title, String content) {
    Widget okButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('Ok'),
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void clearForm() {
    staffIdController.text = '';
    staffNameController.text = '';
    staffDepartmentController.text = '';
    staffPositionController.text = '';
  }
}