import 'package:flutter/material.dart';

class CatogryItmeHome extends StatelessWidget {
  const CatogryItmeHome(
      {super.key,
      required this.images,
      required this.title,
      required this.color});

  final String images;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color == Colors.white ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style:
            TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color == Colors.white ? Colors.white : Colors.black),
      ),
    );
  }
}
