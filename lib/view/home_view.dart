import 'package:findeat/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:findeat/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:findeat/model/restaurantModel.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:findeat/view/detailView.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main',
      theme: ThemeData(
        primaryColor: const Color(00000),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int pageIndex = 0;

  final pages = [
    Page1(),
    const Page2(),
    const Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 35
            )
                : const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.search_sharp,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.person,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.person_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xffEEEDDE),
        appBar: AppBar(
          title: Text(
            "Popular Restaurant",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Color(0x44000000),
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
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailView(product: items[index]),
                                  ),
                                );
                              },
                              child: Card(
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
                                          image: NetworkImage(
                                              items[index].imageURL.toString()),
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
    await rootBundle.rootBundle.loadString('jsonfile/restaurant.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => ProductDataModel.fromJson(e)).toList();
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffEEEDDE),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 14),
              Text('Collection',style: TextStyle(
                fontFamily: 'Moul',
                fontSize: 25,
                color: Colors.black,
              ),
              ),
              SizedBox(
                  width: 137
              ),
              Icon(
                Icons.account_circle_outlined,
                size: 32,
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 15),
            child:
            Text(
              'Explore many collections of best places, caffe,\nrestaurants, or many places to visit',
              style: GoogleFonts.lustria(
                  fontSize: 12,
                  color: Colors.black
              ),
            ),
          ),
          SizedBox(
              height: 20
          ),
          Container(
            height: 118,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: InkWell(
                    child: Container(
                        width: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),
                        child: Stack(
                          children:[
                            Image.asset('assets/images/collec1.png'),
                            Positioned.fill(child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text('Popular This Week \n 21 Places >',
                                style: TextStyle(
                                    fontFamily: 'Moul',
                                    fontSize: 8,
                                    color: Colors.white
                                )
                                ,),
                            ))
                          ],
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 1.0),
                  child: InkWell(
                    child: Container(
                        width: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),
                        child: Stack(
                          children:[
                            Image.asset('assets/images/collec2.png'),
                            Positioned.fill(child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text('5 Popular Cafe \n 14 Places >',
                                style: TextStyle(
                                    fontFamily: 'Moul',
                                    fontSize: 8,
                                    color: Colors.white
                                )
                                ,),
                            ))
                          ],
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              height: 20
          ),
          Container(
            height: 118,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: InkWell(
                    child: Container(
                        width: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),
                        child: Stack(
                          children:[
                            Image.asset('assets/images/collec2.png'),
                            Positioned.fill(child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text('Best Cheap Ramen \n 10 Places >',
                                style: TextStyle(
                                    fontFamily: 'Moul',
                                    fontSize: 8,
                                    color: Colors.white
                                )
                                ,),
                            ))
                          ],
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 1.0),
                  child: InkWell(
                    child: Container(
                        width: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),
                        child: Stack(
                          children:[
                            Image.asset('assets/images/collec3.png'),
                            Positioned.fill(child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text('Best Coffe at Town \n 13 Places >',
                                style: TextStyle(
                                    fontFamily: 'Moul',
                                    fontSize: 8,
                                    color: Colors.white
                                )
                                ,),
                            ))
                          ],
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );

  }
  Widget myDetailsContainer1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("Candy Bliss",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 12.0
            ),
          ),
          ),
        ),
      ],
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/splash.png',
                  )
                ],
              ),
              SizedBox(height: 90,),
              Form(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14)
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Nama',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(borderSide: BorderSide.none)
                          ),
                        ),
                      ),
                      SizedBox(height: 32,),
                      Container(
                        decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14)
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(borderSide: BorderSide.none)
                          ),
                        ),
                      ),
                      SizedBox(height: 32,),
                      Container(
                        decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14)
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(borderSide: BorderSide.none)
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(height: 32,),
              Container(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                      'Log Out',
                      style: heading5.copyWith(color: Colors.red)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

