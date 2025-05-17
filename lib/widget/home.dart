import 'package:clima_app/clases/clima.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // esto es necesario para usar json.decode


class ClimaScreen extends StatefulWidget {
  @override
  _ClimaScreenState createState() => _ClimaScreenState();
}

class _ClimaScreenState extends State<ClimaScreen> {
  final List<String> ciudades = [
    'Guatemala',
    'Honduras',
    'Costa Rica',
    'El Salvador',
    'Panama',
    'Belice',
    'Nicaragua',
  ];

  final String apiKey = 'c9a8f13d9141da13b73096de9cab5cc5'; // tu API key

  List<ClimaInfo> climaData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchClimaData();
  }

  Future<void> fetchClimaData() async {
    List<ClimaInfo> loadedData = [];

    for (String ciudad in ciudades) {
      final url =
          'https://api.openweathermap.org/data/2.5/weather?q=$ciudad&appid=$apiKey&units=metric&lang=es';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final clima = ClimaInfo.fromJson(ciudad, data);
        loadedData.add(clima);
      } else {
        print('Error al cargar el clima de $ciudad');
      }
    }

    setState(() {
      climaData = loadedData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clima actual')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: climaData.length,
              itemBuilder: (context, index) {
                final clima = climaData[index];
                return ListTile(
                  leading: Image.network(
                    'https://openweathermap.org/img/wn/${clima.icon}@2x.png',
                    width: 50,
                  ),
                  title: Text(clima.city),
                  subtitle: Text('${clima.description}'),
                  trailing: Text('${clima.temperature.toStringAsFixed(1)}°C'),
                );
              },
            ),
    );
  }
}
