import 'package:flutter/material.dart';

class CatogryItmeHome extends StatelessWidget {
  const CatogryItmeHome({super.key, required this.images, required this.title});

  final String images;
  final String title;
  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return 
       Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: width * .9,
        height: height * .25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // الصورة في الأعلى
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius:  const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.network(
                  images, // ضع رابط الصورة هنا
                  height: 180,
                  fit: BoxFit.fill,
                ),
              ),
            ),

            // النص السفلي
             Positioned(
              bottom: 5,
              left: 10,
              right: 10,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            // الزر
          ],
        ),
      
    );
  }
}
