import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class dropdownbutton extends StatefulWidget{
  const dropdownbutton({ Key? key }) : super(key: key);

  @override
  _dropdownbuttonState createState() => _dropdownbuttonState();
}
class _CustomCheckboxState extends State<CustomCheckbox> {
  List<String> ItemLokasi = ['Dago','Riau','Lembang','Buah Batu','Lengkong'];
  String _itemLokasi='Riau';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffEEEDDE),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(width:14),
                Icon(
                  Icons.location_on_outlined,
                  size:24.0,
                ),
                SizedBox(width:8),
                DropdownButton(
                    value: _itemLokasi,
                    items: ItemLokasi.map((String value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Text(value)
                      );
                    }).toList(),
                    onChanged: (String? value){
                      setState(){
                        _itemLokasi=value.toString();
                      };
                    }
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(left: 21, right: 21),
              height: 40,
              child: TextField(
                decoration: new InputDecoration(
                  icon: new Icon(Icons.search),
                  labelText: "Search for Restaurant",
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 14,
                ),
                Text('Collections',style: TextStyle(
                  fontFamily: 'Moul',
                  fontSize: 14,
                  color: Colors.black,
                ),
                ),
                SizedBox(
                  width: 151,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.red),
                  ),
                  onPressed: (){},
                  child: const Text('See More',style: TextStyle(
                      fontFamily: 'Moul',
                      fontSize: 14,
                      color: Colors.red
                  ),),
                )
              ],
            ),
            SizedBox(
              height: 13,
            ),
            Container(
              height: 118,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                        width: 98,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),
                        child: Center(child: Image.asset('assets/collec1.png'),),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                        width: 98,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),
                        child: Center(child: Image.asset('assets/collec2.png'),),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                        width: 98,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),
                        child: Center(child: Image.asset('assets/collec3.png'),),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              children: [
                SizedBox(
                  width: 14,
                ),
                Text('Popular Restaurant',style: TextStyle(
                  fontFamily: 'Moul',
                  fontSize: 14,
                  color: Colors.black,
                ),
                ),
              ],
            ),
            SizedBox(
              height: 13,
            ),
            Container(
              height: 118,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                        width: 98,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),
                        child: Card(
                          child: Wrap(
                            children: <Widget>[
                              Image.asset('assets/fav1.png'),
                              ListTile(
                                title: Text("RamenYa",style: TextStyle(
                                  fontFamily: 'Moul',
                                  fontSize: 10,
                                ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                        width: 98,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),
                        child: Card(
                          child: Wrap(
                            children: <Widget>[
                              Image.asset('assets/fav2.png'),
                              ListTile(
                                title: Text("Sei Sapi",style: TextStyle(
                                  fontFamily: 'Moul',
                                  fontSize: 10,
                                ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                        width: 98,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffEEEDDE)),
                        child: Card(
                          child: Wrap(
                            children: <Widget>[
                              Image.asset('assets/fav3.png',
                                height: 122,
                                width: 98,
                                fit: BoxFit.fill,
                              ),
                              ListTile(
                                title: Text("Ambrogio",style: TextStyle(
                                  fontFamily: 'Moul',
                                  fontSize: 10,
                                ),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
}
}
