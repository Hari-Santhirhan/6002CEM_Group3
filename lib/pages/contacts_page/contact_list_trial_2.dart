import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/pages/contacts_page/add_contact_page.dart';

import '../../model/contacts_model.dart';
import '../../widget/appbar_emptyIcon.dart';
import '../../widget/contact_reload.dart';
import 'contact_detail_page.dart';

class ContactListPageTrial2 extends StatefulWidget {
  @override
  _ContactListPageTrial2State createState() => _ContactListPageTrial2State();
}

class _ContactListPageTrial2State extends State<ContactListPageTrial2> {
  //final curr_user = FirebaseAuth.instance.currentUser!; #Uncomment this when integrating

  List<Contact> contacts = [
    Contact(
        id: '1',
        name: 'Police',
        phoneNumber: '123-456-7890',
        user: 'Victor',
        isDeletable: false), //change user: value to curr_user
    Contact(
        id: '2',
        name: 'Hospital',
        phoneNumber: '098-765-4321',
        user: 'Victor',
        isDeletable: false), //change user: value to curr_user
    Contact(
        id: '3',
        name: 'Human Resources',
        phoneNumber: '013-254-6897',
        user: 'Victor',
        isDeletable: false), //change user: value to curr_user
    // Add more contacts here
  ];

  Future<void> loadContacts() async {
    contacts.clear();
    contacts = [
      Contact(
          id: '1',
          name: 'Police',
          phoneNumber: '123-456-7890',
          user: 'Victor',
          isDeletable: false), //change user: value to curr_user
      Contact(
          id: '2',
          name: 'Hospital',
          phoneNumber: '098-765-4321',
          user: 'Victor',
          isDeletable: false), //change user: value to curr_user
      Contact(
          id: '3',
          name: 'Human Resources',
          phoneNumber: '013-254-6897',
          user: 'Victor',
          isDeletable: false), //change user: value to curr_user
      // Add more contacts here
    ];
    final contactDocs =
    await FirebaseFirestore.instance.collection('contacts').get();
    //.where('user', isEqualTo: curr_user.uid) #add this after collection once integrated
    // with login page
    if (mounted) {
      setState(() {
        contacts.addAll(contactDocs.docs.map((doc) => Contact.fromJson(doc.data(), doc.id)).toList());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildEmptyAppBar(context, "Contacts"),
      body: RefreshIndicator(
        onRefresh: loadContacts,
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(contacts[index].name[0]),
                ),
                title: Text(contacts[index].name),
                subtitle: Text(contacts[index].phoneNumber),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.phone),
                      onPressed: () {
                        //make it so users can call people;
                      },
                    ),
                    if (contacts[index].isDeletable)
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await FirebaseFirestore.instance.collection('contacts').doc(contacts[index].id).delete();
                          setState(() {
                            contacts.removeAt(index);
                          });
                        },
                      )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ContactDetailPage(contact: contacts[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // Navigate to a new page to add a contact
          final newContact = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContactPage()),
          );
          if (newContact != null) {
            setState(() {
              contacts.add(newContact);
            });
          }
        },
      ),
    );
  }
}