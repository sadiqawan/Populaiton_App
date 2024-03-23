import 'package:flutter/material.dart';

import '../model/pop_model.dart';

class PopulationCountScreen extends StatelessWidget {
  List<PopulationCounts> populationCounts ;
  PopulationCountScreen({super.key , required this.populationCounts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Population Count'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: populationCounts.length,
          itemBuilder: (context, index) {
            final count = populationCounts[index];
            return ListTile(
              title: Text('Year: ${count.year}'),
              subtitle: Card(
                color: Colors.amberAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Value: ${count.value}'),
                      Text('Sex: ${count.sex}'),
                      Text('Reliability: ${count.reliabilty}'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
