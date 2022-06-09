import 'package:flutter/material.dart';
import 'package:findeat/model/restaurantModel.dart';

class DetailView extends StatelessWidget {
  const DetailView({Key? key, required this.product}) : super(key: key);

  final ProductDataModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Restaurant Profile",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black54,
        ),
        body: Column(children: [
          Image.network(
            product.imageURL.toString(),
            fit: BoxFit.cover,
          ),
          Text(
            "Nama: ${product.name}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Category: ${product.category.toString()}",
            style: const TextStyle(
                fontSize: 12
            ),
          ),
          Text(
            "Lokasi : ${product.Lokasi}",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Range Harga : ${product.price}",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),


        ]));
  }
}