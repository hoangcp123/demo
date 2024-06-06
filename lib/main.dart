import 'package:demo/screen/add_staff.dart';
import 'package:demo/screen/edit_staff.dart';
import 'package:demo/service/staff_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/staff.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Using SQL CRUD',
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final StaffService _staffService = StaffService();
  late List<Staff> listStaff;

  @override
  void initState() {
    // TODO: implement initState
    getAllStaffs();
    super.initState();
  }

  getAllStaffs() async {
    listStaff = <Staff>[];
    var list = await _staffService.getStaffs();
    list.forEach((staff) {
      setState(() {
        var s = Staff();
        s.staffId = staff['staffId'];
        s.staffName = staff['staffName'];
        s.department = staff['department'];
        s.position = staff['position'];
        listStaff.add(s);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Management',style: TextStyle(color: Colors.red,fontSize: 30)),
      ),
      body: ListView.builder(
          itemCount: listStaff.length,
          itemBuilder: (context, index){
            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(listStaff[index].staffName??''),
              subtitle: Text(listStaff[index].department??''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditStaff(staff: listStaff[index]))).then((data) {
                      getAllStaffs();
                    });
                  }, icon: const Icon(Icons.edit,color: Colors.teal,)),
                  IconButton(onPressed: (){
                    _deleteStaffDialog(context, listStaff[index].staffId);
                  }, icon: const Icon(Icons.delete,color: Colors.red,)),
                ],
              ),
            );
          }
      ),
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.red,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddStaff())).then((data) {
            getAllStaffs();
          });
        }, child: const Icon(Icons.add),
      ),
    );
  }

  _deleteStaffDialog(BuildContext context, staffId){
    return showDialog(
        context: context,
        builder: (param){
          return AlertDialog(
            title: const Text("Bạn có chắc chắn xóa không?",style: TextStyle(color: Colors.red, fontSize: 20),),
            actions: [
              TextButton(
                  onPressed: (){
                    var result = _staffService.deleteStaff(staffId);
                    if(result!=null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã xóa nhân viên có mã: $staffId")));
                      Navigator.of(context).pop();
                      getAllStaffs();
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Không xóa được nhân viên có mã: $staffId")));
                    }
                  },
                  child: const Text("Delete",style: TextStyle(color: Colors.red,fontSize: 20))),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel',style: TextStyle(color: Colors.cyanAccent,fontSize: 20),))
            ],
          );
        });
  }
}