import 'dart:convert';
import 'dart:io';

import 'package:dog_picture_app/dogclass.dart';
import 'package:dog_picture_app/hive_urls.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class DogService {
  static const _dogApiUrl = 'https://dog.ceo/api/breeds/image/random';

  static Future<List<Dog>> fetchDogs() async {
    final cacheManager = DefaultCacheManager();
    const cacheKey = _dogApiUrl;
    // final file = await cacheManager.getSingleFile(_dogApiUrl);

    final response = await http.get(Uri.parse(_dogApiUrl));
    if (response.statusCode == 200) {
      final imageUrl = jsonDecode(response.body)['message'];
      final dog = Dog(imageUrl: imageUrl);
      cacheManager.putFile(imageUrl, response.bodyBytes);
      addUrl(imageUrl);

      return [dog];
    } else {
      throw Exception('Failed to fetch dog images');
    }
  }

  static Future<List<Dog>> getCachedDogs() async {
    final cacheManager = DefaultCacheManager();
    var box = Hive.box('urlList');
    final urls = List<String>.from(box.get('urls') ?? []);
    // print(urls);
    File? file;
    List<Dog> dogs = [];
    for (var i = 0; i < urls.length; i++) {
      file = await cacheManager.getSingleFile(urls[i]);
      // print(file);
      print(i);
      final imageUrl = jsonDecode(await file.readAsString())['message'];
      print(imageUrl);
      final dog = Dog(imageUrl: imageUrl);
      dogs.add(dog);
    }

    if (file == null) {
      return [];
    }
    print(dogs);
    return dogs;
  }
}
