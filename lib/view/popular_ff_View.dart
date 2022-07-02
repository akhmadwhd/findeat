import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:findeat/model/ffModel.dart';

class FFPage extends StatefulWidget {
  @override
  _FFPageState createState() => _FFPageState();
}

class _FFPageState extends State<FFPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Popular Fast Food Profile",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black54,
        ),
        body: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<ProductDataModel>;
              return ListView.builder(
                  itemCount: items == null ? 0 : items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: Image(
                                image:
                                NetworkImage(items[index].imageURL.toString()),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(
                                          items[index].name.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(items[index].category.toString()),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future<List<ProductDataModel>> ReadJsonData() async {
    final jsondata =
    await rootBundle.rootBundle.loadString('assets/jsonfile/ff.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => ProductDataModel.fromJson(e)).toList();
  }
}