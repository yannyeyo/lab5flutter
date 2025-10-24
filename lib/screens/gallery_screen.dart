import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Экран "Галерея товаров"
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      'https://cdn-icons-png.flaticon.com/512/1685/1685513.png', // общее
      'https://cdn-icons-png.flaticon.com/512/415/415733.png',   // бутылка напитка
      'https://cdn-icons-png.flaticon.com/512/2954/2954918.png',   // иконка одежды
      'https://cdn-icons-png.flaticon.com/512/3362/3362661.png', // техника
      'https://cdn-icons-png.flaticon.com/512/3674/3674333.png', // аксессуары
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Галерея товаров')),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(12),
            child: CachedNetworkImage(
              imageUrl: images[index],
              placeholder: (context, url) => const SizedBox(
                height: 100, // одинаковая высота даже во время загрузки
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => const SizedBox(
                height: 100,
                child: Center(child: Icon(Icons.error, color: Colors.red)),
              ),
              height: 100, // уменьшенная высота изображений
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
