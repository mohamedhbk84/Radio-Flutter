import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio/Network/Provider/Player_Provder.dart';

class PlayingTemplate extends StatefulWidget {
    final String radioTitle;
  final String radioImageURL;

  const PlayingTemplate({Key key, this.radioTitle, this.radioImageURL}) : super(key: key);
  @override
  _PlayingTemplateState createState() => _PlayingTemplateState();
}

class _PlayingTemplateState extends State<PlayingTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Color(0xff182545)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _nowPlayingText(context, widget.radioTitle,widget.radioImageURL ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nowPlayingText(BuildContext context, String title, String imageURL) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: ListTile(
        title: new Text(
          title,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff),
          ),
        ),
        subtitle: new Text(
          "Now Playing",
          textScaleFactor: 0.8,
          style: new TextStyle(
            color: Color(0xffffff),
          ),
        ),
        leading: _image(imageURL, size: 50.0),
        trailing: Wrap(
          spacing: -10.0,
          children: <Widget>[
            _buildStopIcon(context),
            _buildShareIcon(),
          ],
        ),
      ),
    );
  }

  Widget _image(url, {size}) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(url),
      ),
      height: size == null ? 55 : size,
      width: size == null ? 55 : size,
      decoration: BoxDecoration(
        color: Color(0xffFFE5EC),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }

  Widget _buildStopIcon(BuildContext context) {
    var playerProvider = Provider.of<PlayerProvider>(context, listen: false);

    return IconButton(
      icon: Icon(Icons.stop),
      color: Color(0xff9097A6),
      onPressed: () {
        playerProvider.stopRadio();
      },
    );
  }

  Widget _buildShareIcon() {
    return IconButton(
      icon: Icon(Icons.share),
      color: Color(0xff9097A6),
      onPressed: () {},
    );
  }
}
