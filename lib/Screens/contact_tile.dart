import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

// ignore: must_be_immutable
class ContactTile extends StatefulWidget {
  Contact contact;
  ContactTile({super.key, required this.contact});

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: (widget.contact.photo == null)
            ? const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ))
            : CircleAvatar(backgroundImage: MemoryImage(widget.contact.photo!)),
        title: Text("${widget.contact.name.first} ${widget.contact.name.last}"),
        subtitle: Text(widget.contact.phones.first.number),
        trailing: Checkbox(
          activeColor: Colors.green,
          checkColor: Colors.greenAccent,
          onChanged: (value) {
            isChecked = value;
            print(isChecked);
            setState(() {});
          },
          value: isChecked,
        ),
        onTap: () {});
  }
}
