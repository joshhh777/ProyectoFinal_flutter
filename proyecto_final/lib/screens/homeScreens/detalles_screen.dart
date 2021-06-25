import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/homeScreens/home_screen.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'ninos_screen.dart';

class DetalleeScreen extends StatelessWidget {
   DetalleeScreen({required this.nombre, required this.imagen, required this.precio});
  final String nombre;
  final String imagen;
  final String precio;
  static String routeName = 'detalles_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.withAlpha(400),
      appBar: AppBar(
            backgroundColor: Colors.greenAccent,
            leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                      ),
                      )
                    },
                  );
                },
              ), 
            
          ),
        body: new ListView(
          children: <Widget>[
            new Container(
              color: Colors.red,
              height: 387.0,//tamaño de la segunda imagen
              child: new Hero(
                tag: nombre,
                child: new Material(
                  child: new InkWell(
                    child: new SmallCard(
                      imageAssetName: "$imagen",
                     
                      
                    ),
                  ),
                ),
              )
              ),
              new IniciarNombre(
                nombre: nombre,
              ),
              new IniciarIcon(),
              new Informacion(precio: precio),
              
          ],
        ),
      );
  }
}


class IniciarNombre extends StatelessWidget {
  IniciarNombre({required this.nombre});
  final String nombre;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  nombre,
                  style: new TextStyle(fontSize: 20.0, color: Colors.blue),
                ),
                new Text(
                  "$nombre",
                  style: new TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
          new Row(
            children: <Widget>[
              new Icon(
                Icons.star,
                size: 30.0,
                color: Colors.yellow,
              ),
              new Icon(
                Icons.star,
                size: 30.0,
                color: Colors.yellow,
              ),
              new Icon(
                Icons.star,
                size: 30.0,
                color: Colors.yellow,
              ),
              new Text(
                "",
                style: new TextStyle(fontSize: 18.0),
              )
            ],
          )
        ],
      ),
    );
  }
}




class IniciarIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(10.0),
      
      child: new Row(
        children: <Widget>[
          new IconTec(
            icon: Icons.call,
            tec: "Llamar"
                ), 
                new IconTec(
            icon: Icons.message_rounded,
            tec: "WhastApp"
                ),
                new IconTec(
            icon: Icons.question_answer,
            tec: "Ayuda"
                ),
                  ],
      ),
    );
  }
}

class IconTec extends StatelessWidget {
  IconTec({required this.icon, required this.tec});
  final IconData icon;
  final String tec;
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Column(
        children: <Widget>[
          new Icon(
            icon,
            size: 50.0,
            color: Colors.blue,
          ),
          new Text(
            tec,
            style: new TextStyle(fontSize: 12.0, color: Colors.blue),
          )
        ],
      ),
    );
  }
}

class Informacion extends StatelessWidget {
  Informacion({required this.precio});
  final String precio;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(15.0),
        child: new Row(
          children: <Widget>[
           new Text(
            precio,
            style: new TextStyle(fontSize: 30.0, color: Colors.blue),
          ),
          AnimatedIconButton(
          size: 50,
          onPressed: (){
           showDialog(
             barrierDismissible: false,
              context: context, 
               builder: (context) => AlertDialog(
                title: Text("COMPRA EXITOSA"),
                 content: Text('Gracias por realizar la compra.'),
                  actions: <Widget>[
                   FlatButton(
                      onPressed: (){ 
                        Navigator.of(context).push(
                         MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                ),
                );  
                  debugPrint("Adultosss");
                  },
                  child: Text('OK')
                 ),
                     ]
                     )
                     );
          },
          duration: const Duration(milliseconds: 500),
          splashColor: Colors.transparent,
          icons: const <AnimatedIconItem>[
            AnimatedIconItem(
              icon: Icon(Icons.add_shopping_cart_rounded, color: Colors.black),
            ),
            AnimatedIconItem(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              
            ),
          ],
        ),
          ],
        ),
    );
  }
}

Route _createRoute(BuildContext parentContext, String image) {
  return PageRouteBuilder<void>(
    pageBuilder: (context, animation, secondaryAnimation) {
      return _SecondPage(image);
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var rectAnimation = _createTween(parentContext)
          .chain(CurveTween(curve: Curves.ease))
          .animate(animation);

      return Stack(
        children: [
          PositionedTransition(rect: rectAnimation, child: child),
        ],
      );
    },
  );
}

Tween<RelativeRect> _createTween(BuildContext context) {
  var windowSize = MediaQuery.of(context).size;
  var box = context.findRenderObject() as RenderBox;
  var rect = box.localToGlobal(Offset.zero) & box.size;
  var relativeRect = RelativeRect.fromSize(rect, windowSize);

  return RelativeRectTween(
    begin: relativeRect,
    end: RelativeRect.fill,
  );
}

class SmallCard extends StatelessWidget {
  const SmallCard({required this.imageAssetName, Key? key}) : super(key: key);
  final String imageAssetName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Material(
        child: InkWell(
          onTap: () {
            var nav = Navigator.of(context);
            nav.push<void>(_createRoute(context, imageAssetName));
          },
          child: Image.network(
            imageAssetName,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _SecondPage extends StatelessWidget {
  final String imageAssetName;

  const _SecondPage(this.imageAssetName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                imageAssetName,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}