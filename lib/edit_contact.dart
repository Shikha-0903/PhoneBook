import 'package:flutter/material.dart';
import 'constant.dart';
class EditContact extends StatefulWidget {
  final int index;
  final String name;
  final String number;

  const EditContact({super.key, required this.index, required this.name, required this.number});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  late TextEditingController nameController;
  late TextEditingController numberController;


  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    numberController = TextEditingController(text: widget.number);
  }

  void _updateContact() {
    String updatedName = nameController.text.trim();
    String updatedPhone = numberController.text.trim();

    if (updatedName.isEmpty || updatedPhone.isEmpty) {
      showCustomSnackBar(context, "Please enter all details");
      return;
    }

    if (!RegExp(r"^[789]\d{9}$").hasMatch(updatedPhone)) {
      showCustomSnackBar(context, "Please enter a valid 10-digit phone number starting with 7, 8, or 9");
      return;
    }

    // Fetch the existing contact
    var existingContact = contactsBox.getAt(widget.index);

    // Ensure we're only updating name or number
    contactsBox.putAt(widget.index, {
      'name': updatedName.isNotEmpty ? updatedName : existingContact['name'],
      'number': updatedPhone.isNotEmpty ? updatedPhone : existingContact['number'],
    });

    showCustomSnackBar(context, "Contact updated successfully!");

    // Close the screen and return success
    Navigator.pop(context, true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueGrey.shade800,
        title: const Text("Edit Contact",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 50,),
                CustomTextField(hintText: "enter your Name", controller: nameController),
                const SizedBox(height: 20),
                CustomTextField(hintText: "enter your Phone no", controller: numberController,keyboardType: TextInputType.phone,),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updateContact,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade800,
                  ),
                  child: const Text("Save", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
