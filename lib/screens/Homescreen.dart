import 'package:dog_picture_app/models/dogModel.dart';
import 'package:dog_picture_app/services/dogservice.dart';
import 'package:dog_picture_app/components/color_manager.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Dog> _dogs = [];

  @override
  void initState() {
    super.initState();

    _getCachedDogs();
  }

  Future<void> _getCachedDogs() async {
    final dogs = await DogService.getCachedDogs();
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Dog Images'),
        backgroundColor: ColorManager.primary,
      ),
      body: ListView.builder(
        itemCount: _dogs.length,
        // reverse: true,
        itemBuilder: (context, index) {
          final dog = _dogs[_dogs.length - 1 - index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                  child: Image.network(
                dog.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  return loadingProgress == null
                      ? child
                      : Container(
                          height: 300,
                          color: ColorManager.primary,
                        );
                },
              )),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () {
              _fetchDogs();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.secondary),
            child: const Text("Fetch Random Images")),
      ),
    );
  }
}
