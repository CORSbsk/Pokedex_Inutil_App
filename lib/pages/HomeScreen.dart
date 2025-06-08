import 'package:andercode_flutter_pokedex/controller/getDataController.dart';
import 'package:andercode_flutter_pokedex/pages/DetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<HomeScreen> {
  final getDataController = Get.put(Getdatacontroller());

  @override
  void initState() {
    getDataController.getDataFromSupabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: !getDataController.isLoading.value
            ? Stack(
                children: [
                  _ImagePokeball(),
                  _TextoTitulo(),
                  Positioned(
                    top: 150,
                    bottom: 0,
                    width: width,
                    child: Column(
                      children: [
                        Expanded(
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.4),
                                itemCount: 151,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    child: InkWell(
                                      child: SafeArea(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: _getBackgroundColor(
                                                getDataController
                                                    .getDataModel
                                                    .value
                                                    .results[index]
                                                    .pokFirstType),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                          ),
                                          child: Stack(
                                            children: [
                                              _PokeballInterna(),
                                              _ImagenPokemon(index),
                                              _NombrePokemonInterno(index),
                                              _TipoPokemonInterno(index)
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => Detailscreen(
                                              heroTag: index,
                                              WpokNum: getDataController
                                                  .getDataModel
                                                  .value
                                                  .results[index]
                                                  .pokNum,
                                              WpokName: getDataController
                                                  .getDataModel
                                                  .value
                                                  .results[index]
                                                  .pokName,
                                              WpokFirstType: getDataController
                                                  .getDataModel
                                                  .value
                                                  .results[index]
                                                  .pokFirstType,
                                              WpokFirstTypeBackgroundColor:
                                                  _getTypeColor(
                                                      getDataController
                                                          .getDataModel
                                                          .value
                                                          .results[index]
                                                          .pokFirstType),
                                              WpokSecondType: getDataController
                                                  .getDataModel
                                                  .value
                                                  .results[index]
                                                  .pokSecondType,
                                              WpokSecondTypeBackgroundColor:
                                                  _getTypeColor(
                                                      getDataController
                                                          .getDataModel
                                                          .value
                                                          .results[index]
                                                          .pokSecondType),
                                              WpokImg: getDataController
                                                  .getDataModel
                                                  .value
                                                  .results[index]
                                                  .pokGif,
                                              WpokHeight: getDataController
                                                  .getDataModel
                                                  .value
                                                  .results[index]
                                                  .pokHeight,
                                              WpokWeight: getDataController
                                                  .getDataModel
                                                  .value
                                                  .results[index]
                                                  .pokWeight,
                                              WBackgroundColor:
                                                  _getBackgroundColor(
                                                      getDataController
                                                          .getDataModel
                                                          .value
                                                          .results[index]
                                                          .pokFirstType),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }))
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget _ImagePokeball() {
    return Positioned(
      top: -50,
      right: -50,
      child: Image.asset(
        'images/poke_ball_icon.png',
        fit: BoxFit.fitWidth,
        width: 200,
        color: Colors.black.withValues(alpha: 0.1),
      ),
    );
  }

  Widget _TextoTitulo() {
    return Positioned(
      top: 100,
      left: 20,
      child: Text(
        'Pokedex',
        style: TextStyle(
            color: Colors.black.withValues(alpha: 0.8),
            fontWeight: FontWeight.bold,
            fontSize: 30),
      ),
    );
  }

  Widget _PokeballInterna() {
    return Positioned(
      bottom: -8,
      right: -10,
      child: Image.asset(
        'images/poke_ball_icon.png',
        fit: BoxFit.fitWidth,
        width: 100,
        color: Colors.black.withValues(alpha: 0.1),
      ),
    );
  }

  Widget _ImagenPokemon(index) {
    return Positioned(
        bottom: 5,
        right: 5,
        child: Hero(
          tag: index,
          child: CachedNetworkImage(
            placeholder: ((context, url) => Center(
                  child: CircularProgressIndicator(),
                )),
            imageUrl:
                getDataController.getDataModel.value.results[index].pokGif,
            height: 80,
            fit: BoxFit.fitHeight,
          ),
        ));
  }

  Widget _NombrePokemonInterno(index) {
    return Positioned(
        top: 10,
        left: 10,
        right: 10,
        child: Text(
          getDataController.getDataModel.value.results[index].pokName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ));
  }

  Widget _TipoPokemonInterno(index) {
    var tipos = [
      getDataController.getDataModel.value.results[index].pokFirstType
          .toString()
    ];

    var segundoTipo = getDataController
        .getDataModel.value.results[index].pokSecondType
        .toString();

    if (segundoTipo != "") {
      tipos.add(segundoTipo);
    }

    return Positioned(
      bottom: 5,
      left: 15,
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centra los tipos verticalmente
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centra los tipos horizontalmente
        children: tipos.map((tipo) {
          return Container(
            margin: EdgeInsets.only(bottom: 5), // Espaciado entre tipos
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _getTypeColor(tipo), // Color basado en el tipo
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
          );
        }).toList(),
      ),
    );
  }

  // Función para obtener el color principal basado en el tipo
  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.redAccent;
      case 'water':
        return Colors.blueAccent;
      case 'grass':
        return Colors.greenAccent;
      case 'electric':
        return Colors.yellowAccent;
      case 'ice':
        return Colors.cyanAccent;
      case 'fighting':
        return Colors.orangeAccent;
      case 'poison':
        return Colors.purpleAccent;
      case 'ground':
        return Colors.brown;
      case 'flying':
        return Colors.lightBlueAccent;
      case 'psychic':
        return Colors.pinkAccent;
      case 'bug':
        return Colors.lightGreen;
      case 'rock':
        return Colors.grey;
      case 'ghost':
        return Colors.deepPurpleAccent;
      case 'dragon':
        return Colors.indigoAccent;
      case 'dark':
        return Colors.black87;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pinkAccent[100]!;
      default:
        return Colors.grey; // Color por defecto si el tipo no coincide
    }
  }

  // Función para obtener el color de fondo basado en el tipo
  Color _getBackgroundColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.red[100]!; // Más saturado
      case 'water':
        return Colors.blue[100]!;
      case 'grass':
        return Colors.green[100]!;
      case 'electric':
        return Colors.yellow[100]!;
      case 'ice':
        return Colors.cyan[100]!;
      case 'fighting':
        return Colors.orange[100]!;
      case 'poison':
        return Colors.purple[100]!;
      case 'ground':
        return Colors.brown[100]!;
      case 'flying':
        return Colors.lightBlue[100]!;
      case 'psychic':
        return Colors.pink[100]!;
      case 'bug':
        return Colors.lightGreen[100]!;
      case 'rock':
        return Colors.grey[350]!;
      case 'ghost':
        return Colors.deepPurple[100]!;
      case 'dragon':
        return Colors.indigo[100]!;
      case 'dark':
        return Colors.grey[700]!;
      case 'steel':
        return Colors.blueGrey[100]!;
      case 'fairy':
        return Colors.pink[100]!;
      default:
        return Colors.grey[400]!; // Fondo por defecto
    }
  }
}
