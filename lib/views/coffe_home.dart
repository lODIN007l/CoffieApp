import 'package:coffie_app/models/coffe_model.dart';
import 'package:coffie_app/views/page1.dart';
import 'package:flutter/material.dart';

class HomeCoffe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < -20) {
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 650),
                pageBuilder: (context, animation, _) {
                  return FadeTransition(
                    opacity: animation,
                    child: Page1(),
                  );
                }));
          }
        },
        child: Stack(
          children: [
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0XFFA89276), Colors.white]))),
            ),
            Positioned(
                top: size.height * 0.15,
                right: 0,
                left: 0,
                height: size.height * 0.4,
                child:
                    Hero(tag: cafe[6].name, child: Image.asset(cafe[6].image))),
            Positioned(
                height: size.height * 0.7,
                right: 0,
                left: 0,
                bottom: 0,
                child: Hero(
                    tag: cafe[7].name,
                    child: Image.asset(
                      cafe[7].image,
                      fit: BoxFit.cover,
                    ))),
            Positioned(
                height: size.height,
                right: 0,
                left: 0,
                bottom: -size.height * 0.8,
                child: Hero(
                    tag: cafe[8].name,
                    child: Image.asset(
                      cafe[8].image,
                      fit: BoxFit.cover,
                    ))),
            Positioned(
                height: 180,
                left: 0,
                right: 0,
                bottom: size.height * 0.25,
                child: Image.asset('assets/logo.png'))
          ],
        ),
      ),
    );
  }
}
