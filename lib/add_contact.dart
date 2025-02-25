import 'package:flutter/material.dart';
import 'constant.dart';
class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  void _addContact() {
    String name = _nameController.text.trim();
    String phone = _phoneController.text.trim();

    if (name.isNotEmpty && phone.isNotEmpty) {
      if (!RegExp(r"^[789]\d{9}$").hasMatch(phone)) {
        // Show error if phone number is invalid
        showCustomSnackBar(context, "Please enter a valid 10-digit phone number starting with 7, 8, or 9");
      } else {
        // If phone number is valid, save the contact
        contactsBox.add({'name': name, 'number': phone});

        showCustomSnackBar(context, "Contact added successfully!");

        _nameController.clear();
        _phoneController.clear();
      }
    } else {
      showCustomSnackBar(context, "Please enter all details");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text("Add Contact",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueGrey.shade800,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blueGrey.shade800,
                child: const Icon(
                  Icons.person_add,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20,),
              CustomTextField(hintText: "Enter your name", controller: _nameController),
              const SizedBox(height: 20),
              CustomTextField(hintText: "Enter your Phone no.", controller: _phoneController,keyboardType: TextInputType.phone,),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _addContact,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade800,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text("Add Contact",style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
