import 'package:coffie_app/models/coffe_model.dart';
import 'package:coffie_app/views/coffe_detalles.dart';
import 'package:flutter/material.dart';

const _duracion = Duration(milliseconds: 200);
const _paginaInicial = 8.0;

class Page1 extends StatefulWidget {
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final _pageControlCafe = PageController(
      viewportFraction: 0.30, initialPage: _paginaInicial.toInt());
  final _paginaTextControlador =
      PageController(initialPage: _paginaInicial.toInt());
  double _paginaActual = _paginaInicial;
  double _textPagina = _paginaInicial;
  //escuchar los scroll

  void textScrollListener() {
    _textPagina = _paginaActual;
  }

  void _cofffeEscuchar() {
    setState(() {
      _paginaActual = _pageControlCafe.page!;
    });
  }

  @override
  void initState() {
    _pageControlCafe.addListener(_cofffeEscuchar);
    _paginaTextControlador.addListener(textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageControlCafe.removeListener(_cofffeEscuchar);
    _paginaTextControlador.removeListener(textScrollListener);
    _pageControlCafe.dispose();
    _paginaTextControlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: Colors.black,
          ),
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
                onPageChanged: (value) {
                  if (value < cafe.length) {
                    _paginaTextControlador.animateToPage(value,
                        duration: _duracion, curve: Curves.easeOut);
                  }
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }
                  final caffe1 = cafe[index - 1];
                  final resultado = _paginaActual - index + 1;

                  final value = -0.4 * resultado + 1;
                  final opacidad = value.clamp(0.0, 1.0);
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 650),
                          pageBuilder: (context, animation, _) {
                            return FadeTransition(
                              opacity: animation,
                              child: CafeDetalles(
                                cafe: caffe1,
                              ),
                            );
                          }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..translate(
                                0.0, size.height / 2.6 * (1 - value).abs())
                            ..scale(value),
                          child: Opacity(
                              opacity: opacidad,
                              child: Hero(
                                tag: caffe1.name,
                                child: Image.asset(
                                  caffe1.image,
                                  fit: BoxFit.fitHeight,
                                ),
                              ))),
                    ),
                  );
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
                    Expanded(
                        child: PageView.builder(
                            itemCount: cafe.length,
                            controller: _paginaTextControlador,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final opacidad = (1 - (index - _textPagina).abs())
                                  .clamp(0.0, 1.0);
                              return Opacity(
                                  opacity: opacidad,
                                  child: Hero(
                                    tag: "text_${cafe[index].name}",
                                    child: Material(
                                      child: Text(
                                        cafe[index].name,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ));
                            })),

                    //animar desvanecimiento del texto
                    AnimatedSwitcher(
                      duration: _duracion,
                      child: Text(
                        '\$ ${cafe[_paginaActual.toInt()].price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 30),
                        key: Key(cafe[_paginaActual.toInt()].name),
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
