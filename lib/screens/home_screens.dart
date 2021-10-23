import 'dart:convert';

import 'package:animestewar/components/loader_component.dart';
import 'package:animestewar/helpers/constants.dart';
import 'package:animestewar/models/anime_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showLoader = false;
  List<Anime> animes = [];
  @override
  void initState() {
    super.initState();
    _getAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Best Animes'),
        backgroundColor: const Color(0xFFFF8000),
      ),
      body: showLoader
          ? LoaderComponent(
              text: 'Espere por favor...',
            )
          : Text('Hola perras'),
    );
  }

  void _getAnimes() async {
    setState(() {
      showLoader = true;
    });
    var url = Uri.parse(Constants.apiURL);
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    setState(() {
      showLoader = false;
    });
    var body = response.body;
    var decodedJson = jsonDecode(body);

    if (decodedJson != null) {
      for (var item in decodedJson['data']) {
        animes.add(Anime.fromJson(item));
      }
    }
    print(animes);
  }
}
