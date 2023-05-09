import 'package:dog_picture_app/presentation/widget/diologue_box.dart';
import 'package:dog_picture_app/services/dogservice.dart';
import 'package:dog_picture_app/components/color_manager.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    _getCachedDogs();
  }

  Future<void> _getCachedDogs() async {
    final dogs = await DogService.getCachedDogs();
    setState(() {
      dogsBox.addAll(dogs);
    });
  }

  Future<void> _fetchDogs() async {
    final dogs = await DogService.fetchDogs();
    setState(() {
      dogsBox.addAll(dogs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Dog Images'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () async {
                  final result = await showDialog(
                      context: context,
                      builder: (context) => const DeleteDiologueBox(),
                      barrierDismissible: true);
                  print(result);
                  if (result != null && result == true) {
                    setState(() {
                      // update the state here
                    });
                  }
                },
                child: const Icon(Icons.delete)),
          )
        ],
        backgroundColor: ColorManager.primary,
      ),
      body: ListView.builder(
        itemCount: dogsBox.length,
        // reverse: true,
        itemBuilder: (context, index) {
          final dog = dogsBox[dogsBox.length - 1 - index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                  height: 300,
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
