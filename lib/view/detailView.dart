import 'package:findeat/view/review_view.dart';
import 'package:flutter/material.dart';
import 'package:findeat/model/restaurantModel.dart';
import 'package:findeat/theme.dart';
import 'package:findeat/view/maps_view.dart';

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
          SizedBox(height: 15,),
          Text(
            "Menu Makanan",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10,),
          Image.network(
            product.MenuUrl.toString(),
            fit: BoxFit.fill,
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: Colors.black54,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Text(
                    'Lokasi',
                    style: heading5.copyWith(color: Colors.white)
                ),
              ),
              SizedBox(height: 10,),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: Colors.black54,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestMe(),
                    ),
                  );
                },
                child: Text(
                    'Review',
                    style: heading5.copyWith(color: Colors.white)
                ),
              ),

            ],
          )




        ]));
  }
}