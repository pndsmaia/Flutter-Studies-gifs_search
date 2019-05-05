import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class GifsPage extends StatelessWidget {
  final Map _gifData;

  GifsPage(this._gifData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text(_gifData['title']),
      backgroundColor: Colors.black,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            Share.share(_gifData['images']['fixed_height']['url']);
          },
        ),
      ],
    );
  }

  Widget _body() {
    return Center(
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: _gifData['images']['fixed_height']['url'],
      ),
    );
  }
}
