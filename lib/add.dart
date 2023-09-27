import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class addUser extends StatefulWidget {
  const addUser({super.key});

  @override
  State<addUser> createState() => _addUserState();
}

class _addUserState extends State<addUser> {
  final List<String> group = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? selectedGroup;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('usersdetails');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorMobile = TextEditingController();

  void addDonor() {
    final data = {
      'Name': donorName.text,
      'Mobile': donorMobile.text,
      'Blood Group': selectedGroup
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Donor'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: donorName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter Donor Name')),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: donorMobile,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter Donor Number')),
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(label: Text('Select Blood Group')),
              items: group
                  .map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                selectedGroup = val.toString();
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                addDonor();
                Navigator.pop(context);
              },
              child: Text(
                'SUBMIT',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50)),
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
            )
          ],
        ),
      ),
    );
  }
}