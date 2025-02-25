import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'add_contact.dart';
import 'edit_contact.dart';
class MyPhoneApp extends StatefulWidget {
  const MyPhoneApp({super.key});

  @override
  State<MyPhoneApp> createState() => _MyPhoneAppState();
}

class _MyPhoneAppState extends State<MyPhoneApp> {
  final Box contactsBox = Hive.box('contactsBox');
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        centerTitle: true,
        title: const Text(
          "PhoneBook",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                cursorColor: Colors.blueGrey.shade800,
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: searchController.text.isNotEmpty
                      ? GestureDetector(
                    onTap: () {
                      searchController.clear();
                      setState(() {}); // Refresh the UI
                    },
                    child: const Icon(Icons.cancel_outlined, color: Colors.grey),
                  )
                      : null,
                  hintText: "Search contacts...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (query) {
                  setState(() {}); // Trigger UI update when search text changes
                },
              ),

            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: contactsBox.listenable(),
        builder: (context, box, _) {
          var contacts = box.values.toList();

          // Filtering contacts based on search input
          if (searchController.text.isNotEmpty) {
            contacts = contacts.where((contact) {
              return contact['name']
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase());
            }).toList();
          }

          return contacts.isEmpty
              ? const Center(
            child: Text(
              "No contacts available",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          )
              : ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              var contact = contacts[index];
              return ListTile(
                title: Text(contact['name']),
                subtitle: Text(contact['number']),
                leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade800,
                  child: Text(
                    contact['name'][0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.mode_edit_outlined, color: Colors.blue),
                      onPressed: () async {
                        bool? isUpdated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditContact(
                              index: index,
                              name: contact['name'],
                              number: contact['number'],
                            ),
                          ),
                        );

                        // Refresh the UI if contact is updated
                        if (isUpdated == true) {
                          setState(() {});
                        }
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteContact(index),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey.shade800,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddContact()));
        },
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
    );
  }

  void _deleteContact(int index) {
    contactsBox.deleteAt(index);
  }
}
