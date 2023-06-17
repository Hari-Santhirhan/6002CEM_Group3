import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/widget/appbar_widget.dart';
import '../../model/contacts_model.dart';

class AddContactPage extends StatefulWidget {
  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  //current user login
  //final curr_user = FirebaseAuth.instance.currentUser!; #uncomment later#
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Add Contacts"),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, create a new contact and go back to the previous page
                    final newContactData = {
                      'user': 'user_id', // Replace with curr_user
                      'name': _nameController.text,
                      'phoneNumber': _phoneNumberController.text,
                      'isDeletable': true,
                    };

                    // Save the new contact to Firebase here
                    DocumentReference docRef = await FirebaseFirestore.instance
                        .collection('contacts')
                        .add(newContactData);

                    final newContact = Contact(
                      id: docRef.id,
                      user: newContactData['user'] as String,
                      name: newContactData['name'] as String,
                      phoneNumber: newContactData['phoneNumber'] as String,
                      isDeletable: true,
                    );

                    Navigator.pop(context, newContact);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
