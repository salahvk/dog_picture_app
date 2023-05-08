import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_picture_app/dogclass.dart';
import 'package:dog_picture_app/dogservice.dart';

import 'package:flutter/material.dart';

class DogScreen extends StatefulWidget {
  const DogScreen({super.key});

  @override
  _DogScreenState createState() => _DogScreenState();
}

class _DogScreenState extends State<DogScreen> {
  final List<Dog> _dogs = [];

  @override
  void initState() {
    super.initState();
    _getCachedDogs();
  }

  Future<void> _getCachedDogs() async {
    final dogs = await DogService.getCachedDogs();
    print("Last");
    print(dogs.length);
    setState(() {
      _dogs.addAll(dogs);
    });
  }

  Future<void> _fetchDogs() async {
    final dogs = await DogService.fetchDogs();
    setState(() {
      _dogs.addAll(dogs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dog Images'),
      ),
      body: ListView.builder(
        itemCount: _dogs.length,
        itemBuilder: (context, index) {
          final dog = _dogs[index];
          return SizedBox(
            width: 300,
            height: 300,
            child: CachedNetworkImage(
              imageUrl: dog.imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) {
                print(error);
                return const Icon(Icons.error);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _fetchDogs();
          },
          child: const Icon(Icons.plus_one)),
    );
  }
}
