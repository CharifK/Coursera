import 'package:flutter/material.dart';

class AddItemDialog extends StatelessWidget {
  final String title;
  final Function(String) onAdd;
  final TextEditingController _controller = TextEditingController();

  AddItemDialog({super.key, required this.title, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: "Enter name"),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              onAdd(_controller.text);
              Navigator.pop(context);
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
