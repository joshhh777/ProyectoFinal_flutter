import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/screens/homeScreens/detalles_screen.dart';
import 'package:proyecto_final/servicios/authentication_servicios/auth_services.dart';
import 'package:http/http.dart' as http;
import 'accesorios_screen.dart';
import 'detalles_screen.dart';
import 'ninos_screen.dart';
import 'dart:async';
import 'dart:convert';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoriasScroller categoriasScroller = CategoriasScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  late Map data;
  late List biciData;
  getBicicletas() async {
    http.Response response = await http.get(Uri.parse("http://10.0.2.2:3001"));
   var data = json.decode(response.body);
    setState(() {
      
      biciData = data['Adultos'];
    });
    debugPrint("responseeeeee"+response.body);
  }
  
  @override
  void initState() {
    super.initState();
    getBicicletas();
    controller.addListener(() {

      double value = controller.offset/119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    final loginProvider = Provider.of<AuthServices>(context);
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => print('Mas destacado'),
              );
            },
          ), 
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.search, color: Colors.white60,)
            ),
          IconButton(
            onPressed: () async => await loginProvider.logout(), 
            icon: Icon(Icons.exit_to_app)
            ),
        ],
      ),
      body: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[ 
                    Text(
                      "AQP BIKE",
                      style: TextStyle(color: Colors.red, fontSize: 25, fontFamily: "Times new Roman")
                    ),
                  ],
                ),
                const SizedBox(
                  height: 1,
                ),
                AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer?0:1,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: size.width,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer?0:categoryHeight,
                    child: categoriasScroller),
                ),
                Expanded(
                  child: ListView.builder(
                    
                    controller: controller,
                    itemCount: biciData == null ? 0 : biciData.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index){
                      double scale = 1.0;
                        if (topContainer > 0.5) {
                          scale = index + 0.5 - topContainer;
                          if (scale < 0) {
                            scale = 0;
                          } else if (scale > 1) {
                            scale = 1;
                          }
                        }
                      return Opacity(
                          opacity: scale,
                          child: Transform(
                            transform:  Matrix4.identity()..scale(scale,scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter, 
                                child: Container(
                                    height: 150,
                                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                                      BoxShadow(color: Colors.green, blurRadius: 10.0),
                                    ]),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${biciData[index]["nombre"]}",
                                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "${biciData[index]["precio"]} soles",
                                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                              ), 
                                              IconButton(
                                                onPressed: (){
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context, 
                                                    builder: (context) => AlertDialog(
                                                      title: Text("${biciData[index]["nombre"]}"),
                                                      content: Text('Desea comprarlo?'),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          onPressed: (){
                                                            Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                builder: (context) => DetalleeScreen(
                                                                  imagen: '${biciData[index]["imagen"]}', 
                                                                  nombre: '${biciData[index]["nombre"]}',
                                                                  precio: '${biciData[index]["precio"]}')
                                                            ),
                                                            );
                                                            debugPrint("Adultosss");
                                                          },
                                                          child: Text('OK')
                                                          ),
                                                          FlatButton(
                                                          onPressed: (){
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text('Cancel')
                                                          ),
                                                      ]
                                                    )
                                                    );
                                                },  
                                                icon: Icon(Icons.shopping_cart, color: Colors.black54,)
                                                )
                                              ],
                                            
                                          ),
                                          Image.network(
                                              "${biciData[index]["imagen"]}",
                                              height: double.infinity,
                                              width: 120,
                                            )
                                        ],
                                      ),
                                    )
                                )
                                ),
                          ),
                        );
                              },
                            ),
                          ),
                        ],
                      ),
          ),     
    );
    // ignore: dead_code   
  }
}

class CategoriasScroller extends StatelessWidget {
  const CategoriasScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                ),
                );
                debugPrint("Adultosss");
              },
              child: Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(20.0)), boxShadow: [
                  BoxShadow(color: Colors.white, blurRadius: 5.0),
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "ADULTOS",
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "15 Items",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              ),
              InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NinosScreen(),
                ),
                );
                debugPrint("nIÑOSSSS");
              },
              child: Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(20.0)), boxShadow: [
                  BoxShadow(color: Colors.white, blurRadius: 5.0),
                ]),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "NIÑOS",
                          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "2 Items",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ),
              InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AccesoriosScreen(),
                ),
                );
                debugPrint("ACCESORIOSSS");
              },
              child: Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(20.0)), boxShadow: [
                  BoxShadow(color: Colors.white, blurRadius: 5.0),
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "ACCESORIOS",
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "5 Items",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ), 
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

