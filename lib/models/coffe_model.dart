import 'dart:math';

double _rangoDoble(Random source, num inicio, num finN) =>
    source.nextDouble() * (finN - inicio) + inicio;

final cafe = List.generate(
    _names.length,
    (index) => Coffe(
        name: _names[index],
        image: 'assets/${index + 1}.png',
        price: _rangoDoble(random, 3, 7)));
final random = Random();

class Coffe {
  final String name;
  final String image;
  final double price;

  Coffe({required this.name, required this.image, required this.price});
}

final _names = [
  'Caramelo',
  'Capuchino',
  'Toffe',
  'Americano',
  'Express',
  'Té',
  'Cafe Clasico',
  'Cafe frio ',
  'Cafe semi descremado',
  'Bebida de caramelo',
  'Moca',
  'Mocachino'
];
