import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:population_app_api/view/population_count_screen.dart';
import 'dart:convert';
import '../model/pop_model.dart';

class PopulationScreen extends StatefulWidget {
  const PopulationScreen({super.key});

  @override
  State<PopulationScreen> createState() => _PopulationScreenState();
}

class _PopulationScreenState extends State<PopulationScreen> {
  late Future<List<Data>> _populationData;

  @override
  void initState() {
    super.initState();
    _populationData = getPopulationData();
  }

  Future<List<Data>> getPopulationData() async {
    const url =
        'https://countriesnow.space/api/v0.1/countries/population/cities';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      PopulationModel populationModel =
          PopulationModel.fromJson(json.decode(response.body));
      return populationModel.data ?? [];
    } else {
      throw Exception('Failed to load population data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Population Data'),
      ),
      body: Center(
        child: FutureBuilder<List<Data>>(
          future: _populationData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    return Card(
                      color: Colors.amber,
                      child: ListTile(
                        title: Text('City: ${data.city}'),
                        subtitle: Text('Country: ${data.country}'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PopulationCountScreen(populationCounts: data.populationCounts!),
                          ));
                        },

                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // void _showPopulationCountsDialog(
  //     BuildContext context, List<PopulationCounts>? populationCounts) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Population Counts'),
  //         content: SizedBox(
  //           width: double.maxFinite,
  //           height: 200,
  //           child: populationCounts != null
  //               ? ListView.builder(
  //                   itemCount: populationCounts.length,
  //                   itemBuilder: (context, index) {
  //                     final count = populationCounts[index];
  //                     return ListTile(
  //                       title: Text('Year: ${count.year}'),
  //                       subtitle: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text('Value: ${count.value}'),
  //                           Text('Sex: ${count.sex}'),
  //                           Text('Reliability: ${count.reliabilty}'),
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 )
  //               : const Center(
  //                   child: Text('No population counts available.'),
  //                 ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
