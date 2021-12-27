import 'package:coffie_app/models/coffe_model.dart';
import 'package:flutter/material.dart';

const _duracion = Duration(milliseconds: 200);

class Page1 extends StatefulWidget {
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final _pageControlCafe = PageController(
    viewportFraction: 0.30,
  );
  double _paginaActual = 0.0;
  //escuchar los scroll
  void _cofffeEscuchar() {
    setState(() {
      _paginaActual = _pageControlCafe.page!;
    });
  }

  @override
  void initState() {
    _pageControlCafe.addListener(_cofffeEscuchar);
    super.initState();
  }

  @override
  void dispose() {
    _pageControlCafe.removeListener(_cofffeEscuchar);
    _pageControlCafe.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Positioned(
                left: 20,
                right: 20,
                bottom: -size.height * 0.22,
                height: size.height * 0.3,
                child: const DecoratedBox(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                      BoxShadow(
                          color: Colors.brown, blurRadius: 90, spreadRadius: 45)
                    ]))),
            Transform.scale(
              scale: 1.6,
              alignment: Alignment.bottomCenter,
              child: PageView.builder(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }
                  final caffe = cafe[index - 1];
                  final resultado = _paginaActual - index + 1;

                  final value = -0.4 * resultado + 1;
                  final opacidad = value.clamp(0.0, 1.0);
                  return Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(0.0, size.height / 2.6 * (1 - value).abs())
                        ..scale(value),
                      child: Opacity(
                          opacity: opacidad,
                          child: Image.asset(
                            caffe.image,
                            fit: BoxFit.fitHeight,
                          )));
                },
                itemCount: cafe.length,
                controller: _pageControlCafe,
                scrollDirection: Axis.vertical,
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: 100,
                child: Column(
                  children: [
                    //animar desvanecimiento del texto
                    AnimatedSwitcher(
                      duration: _duracion,
                      child: Text(
                        '\$ ${cafe[_paginaActual.toInt()].price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 50),
                        key: Key(cafe[_paginaActual.toInt()].name),
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
