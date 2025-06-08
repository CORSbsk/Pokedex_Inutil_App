import 'package:andercode_flutter_pokedex/pages/HomeScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Detailscreen extends StatefulWidget {
  final heroTag;
  final WpokNum;
  final WpokName;
  final WpokFirstType;
  final WpokFirstTypeBackgroundColor;
  final WpokSecondType;
  final WpokSecondTypeBackgroundColor;
  final WpokImg;
  final WpokHeight;
  final WpokWeight;
  final WBackgroundColor;

  const Detailscreen(
      {super.key,
      this.heroTag,
      this.WpokNum,
      this.WpokName,
      this.WpokFirstType,
      this.WpokFirstTypeBackgroundColor,
      this.WpokSecondType,
      this.WpokSecondTypeBackgroundColor,
      this.WpokImg,
      this.WpokHeight,
      this.WpokWeight,
      this.WBackgroundColor});

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: widget.WBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          _FlechaAtras(),
          _NombreDelPokemon(),
          _TipoPokemon(),
          _PokeballFondo(),
          Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: height * 0.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(children: [
                          Container(
                            width: width * 0.3,
                            child: Text(
                              'Altura:',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            child: Text(
                              widget.WpokHeight,
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(children: [
                          Container(
                            width: width * 0.3,
                            child: Text(
                              'PESO:',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            child: Text(
                              widget.WpokWeight,
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
              )),
          _ImagenPokemon()
        ],
      ),
    );
  }

  Widget _FlechaAtras() {
    return Positioned(
        top: 40,
        left: 5,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 50,
          ),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(),
              ),
            );
          },
        ));
  }

  Widget _NombreDelPokemon() {
    return Positioned(
      top: 110,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.WpokName.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            "#" + widget.WpokNum.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _TipoPokemon() {
    var tipos = [widget.WpokFirstType.toString()];

    // Si hay un segundo tipo, agrégalo a la lista de tipos
    if (widget.WpokSecondType.toString() != "") {
      tipos.add(widget.WpokSecondType.toString());
    }

    return Positioned(
      top: 155,
      left: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: tipos
            .asMap()
            .map((index, tipo) {
              // Combinar los colores según el tipo
              var tipoBackgroundColor = index == 0
                  ? widget.WpokFirstTypeBackgroundColor
                  : widget.WpokSecondTypeBackgroundColor;

              return MapEntry(
                index,
                Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: tipoBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    tipo,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            })
            .values
            .toList(),
      ),
    );
  }

  Widget _PokeballFondo() {
    var height = MediaQuery.of(context).size.height;

    return Positioned(
        top: height * 0.21,
        right: -50,
        child: Image.asset('images/poke_ball_icon.png',
            height: 250,
            color: Colors.white.withValues(alpha: 0.5),
            fit: BoxFit.fitHeight));
  }

  Widget _ImagenPokemon() {
    var height = MediaQuery.of(context).size.height;

    return Positioned(
        top: height * 0.22,
        child: Hero(
          tag: widget.heroTag,
          child: CachedNetworkImage(
              imageUrl: widget.WpokImg,
              height: 190,
              fit: BoxFit.cover),
        ));
  }
}
