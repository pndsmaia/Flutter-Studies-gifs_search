import 'package:flutter/material.dart';
import 'package:gifs_app/controller/gifs-controller.dart';
import 'package:gifs_app/pages/gifs.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offSet = 0;
  final errorSnackBar = SnackBar(
    content: Text('Erro ao carregar os dados. Verifique sua conexão!'),
    duration: Duration(seconds: 2),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      backgroundColor: Colors.white,
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: Image.network(
          'https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif'),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: _textField('Pesquisar'),
        ),
        Expanded(
          child: _futureBuilder(),
        )
      ],
    );
  }

  Widget _textField(String labelText) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.black),
      textAlign: TextAlign.center,
      onSubmitted: (text) {
        setState(() {
          _search = text;
          _offSet = 9;
        });
      },
    );
  }

  Widget _futureBuilder() {
    return FutureBuilder(
      future: GifsController.getGifs(_search, _offSet),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return Container(
            width: 200.0,
            height: 200.0,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              strokeWidth: 5.0,
            ),
          );
        } else {
          if (snapshot.hasError) {
            Scaffold.of(context).showSnackBar(errorSnackBar);
          } else {
            return _createGifsTable(context, snapshot);
          }
        }
      },
    );
  }

  Widget _createGifsTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
        itemCount: GifsController.getCount(_search, snapshot.data['data']),
        itemBuilder: (context, index) {
          if (_search == null ||
              _search == '' ||
              index < snapshot.data['data'].length) {
            return GestureDetector(
              onLongPress: () {
                Share.share(snapshot.data['data'][index]['images']
                    ['fixed_height']['url']);
              },
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GifsPage(snapshot.data['data'][index])));
              },
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: snapshot.data['data'][index]['images']['fixed_height']['url'],
                height: 300.0,
                fit: BoxFit.cover,
              )
            );
          } else {
            return GestureDetector(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add, color: Colors.black, size: 70.0),
                  Text(
                    'Carregar mais...',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  _offSet += 9;
                });
              },
            );
          }
        });
  }
}
