import 'package:coffie_app/models/coffe_model.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final _pageControlCafe = PageController(
    viewportFraction: 0.35,
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
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 100,
              child: Container(
                color: Colors.red,
              ),
            ),
            PageView.builder(
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
                      ..translate(
                          0.0,
                          MediaQuery.of(context).size.height /
                              2.6 *
                              (1 - value).abs())
                      ..scale(value),
                    child: Opacity(
                        opacity: opacidad, child: Image.asset(caffe.image)));
              },
              itemCount: cafe.length,
              controller: _pageControlCafe,
              scrollDirection: Axis.vertical,
            )
          ],
        ));
  }
}
