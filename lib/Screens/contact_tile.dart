import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/Models/contact_model.dart';
import 'package:reminder/Providers/contact_provider.dart';

// ignore: must_be_immutable
class ContactTile extends StatefulWidget {
  ContactModel contact;
  ContactTile({super.key, required this.contact});

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: (widget.contact.photo == null)
            ? const CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ))
            : CircleAvatar(backgroundImage: MemoryImage(widget.contact.photo!)),
        title: Text("${widget.contact.firstName} ${widget.contact.lastName}"),
        subtitle: Text(widget.contact.phoneNumber ?? " "),
        trailing: Checkbox(
          activeColor: Colors.indigoAccent,
          checkColor: Colors.black,
          onChanged: (value) async {
            if (value == false) {
              isChecked = false;
              Provider.of<ContactProvider>(context, listen: false)
                  .removeContact(widget.contact);
              setState(() {});
            } else {
              isChecked = true;
              Provider.of<ContactProvider>(context, listen: false)
                  .addContact(widget.contact);
              setState(() {});
            }
          },
          value: isChecked,
        ),
        onTap: () {
          isChecked = !isChecked;
          setState(() {});
        });
  }
}
