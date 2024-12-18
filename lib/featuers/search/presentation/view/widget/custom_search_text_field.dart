import 'package:flutter/material.dart';
class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        autofocus: true,
        decoration: InputDecoration(
            // fillColor: Colors.white,
            // filled: true,
          focusColor: Colors.red,
            enabledBorder: buildOutlineInputBorder(),
            focusedBorder: buildOutlineInputBorder(),
            hintText: 'Search Screen',
            suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  size: 24,
                ))),
      ),
    );
  }


}
OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.grey),
  );
}