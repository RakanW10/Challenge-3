import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocatortest/services/location/checkPermission.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? position;
  double? theDiffPosi;
  String? inputOne, inputTwo;
  final TextEditingController liController = TextEditingController();
  final TextEditingController lgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Center(
        child: Column(
          children: [
            position == null
                ? Text("device loc: null")
                : Text("device loc: ${position?.altitude}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  child: TextField(
                    controller: liController,
                    decoration: const InputDecoration(
                      labelText: 'longitude',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Container(
                  width: 100,
                  child: TextField(
                    controller: lgController,
                    decoration: const InputDecoration(
                      labelText: 'latitude',
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                inputOne = liController.text;
                inputTwo = lgController.text;
                print("1-$inputOne");
                print("2-$inputTwo");
              },
              icon: Icon(Icons.edit_note_rounded),
            ),
            IconButton(
              icon: const Icon(Icons.location_city),
              onPressed: () async {
                try {
                  await determinePosition();

                  position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high,
                  );

                  theDiffPosi = Geolocator.distanceBetween(
                    position!.altitude,
                    position!.latitude,
                    double.parse(inputOne!),
                    double.parse(inputTwo!),
                  );

                  setState(() {});
                } catch (error) {
                  print(error);
                }
              },
            ),
            theDiffPosi == null
                ? const Text("data")
                : Text(theDiffPosi.toString())
          ],
        ),
      ),
    );
  }
}
