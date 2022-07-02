import 'package:flutter/material.dart';
import 'package:findeat/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:findeat/model/restaurantModel.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:findeat/view/detailView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:findeat/view/popular_cf_View.dart';
import 'package:findeat/view/popular_cr_view.dart';
import 'package:findeat/view/popular_ff_View.dart';
import 'package:findeat/view/popular_tw_View.dart';

late User loggedinUser;

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
  final _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    getCurrentUser();
  }

  //using this function you can use the credentials of the user

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  int pageIndex = 0;

  final pages = [
    Page1(),
    Page2(),
    Page3(),
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
            "List Restaurant",
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
    await rootBundle.rootBundle.loadString('assets/jsonfile/restaurant.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => ProductDataModel.fromJson(e)).toList();
  }
}

class Page2 extends StatelessWidget {
  Page2({Key? key}) : super(key: key);
  List<String> ItemLokasi = ['Dago','Riau','Lembang','Buah Batu','Lengkong'];
  String _itemLokasi='Riau';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffEEEDDE),
      appBar: AppBar(
        title: Text(
          "Collection",
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
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => twPage()
                          )
                      );
                    },
                    child: Container(
                        width: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),
                        child: Stack(

                          children:[
                            Image.asset('assets/images/collec1.png'),
                            Positioned.fill(child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text('Popular This Week >',
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => cfPage()
                          )
                      );
                    },
                    child: Container(
                        width: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),
                        child: Stack(
                          children:[
                            Image.asset('assets/images/collec2.png'),
                            Positioned.fill(child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text('Popular Cafe',
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => crPage()
                          )
                      );
                    },
                    child: Container(
                        width: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),
                        child: Stack(
                          children:[
                            Image.asset('assets/images/collec2.png'),
                            Positioned.fill(child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text('Popular Cheap Restaurant ',
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FFPage()
                          )
                      );
                    },
                    child: Container(
                        width: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),

                        child: Stack(
                          children:[
                            Image.asset('assets/images/collec3.png'),
                            Positioned.fill(child: Align(
                              alignment: Alignment.bottomLeft,

                              child: Text('Popular FastFood >',
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
  Page3({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEDDE),
      appBar: AppBar(
        title: Text(
          "Account",
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
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: 5,
                height: 88,
              ),
              SizedBox(
                width: 5,
                height: 40,
              ),
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/Profile.jpeg'),
              ),
              SizedBox(
                width: 5,
                height: 14,
              ),
              Text(
                'User 01',
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                width: 5,
                height: 4,
              ),
              Text(
                'Verified User',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 10,
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _auth.signOut();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(320, 48),
                    ),
                    icon: Icon(
                      Icons.logout,
                      size: 20,
                      color: Colors.grey,
                    ),
                    label: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )),

            ],
          )),
    );
  }
}

