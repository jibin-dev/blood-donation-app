import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class updateDonor extends StatefulWidget {
  const updateDonor({super.key});

  @override
  State<updateDonor> createState() => _updateDonorState();
}

class _updateDonorState extends State<updateDonor> {
  final List<String> group = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? selectedGroup;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('usersdetails');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorMobile = TextEditingController();
  void updatDonor(docid) {
    final data = {
      'Name': donorName.text,
      'Mobile': donorMobile.text,
      'Blood Group': selectedGroup
    };
    donor.doc(docid).update(data);
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = arg['Name'];
    donorMobile.text = arg['Mobile'];
    selectedGroup = arg['Blood Group'];
    final docid = arg['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Donor'),
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
              value: arg['Blood Group'],
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
                updatDonor(docid);
                Navigator.pop(context);
              },
              child: Text(
                'UPDATE',
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