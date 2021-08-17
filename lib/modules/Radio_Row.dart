import 'package:flutter/material.dart';
import 'package:radio/Network/Provider/Player_Provder.dart';
import 'package:provider/provider.dart';
import 'package:radio/model/Radio_Api_Model.dart';

class RadionRowScreen extends StatefulWidget {
  final RadioModel radioModel;
  final bool isFavouriteOnlyRadios;

  const RadionRowScreen({Key key, this.radioModel, this.isFavouriteOnlyRadios})
      : super(key: key);

  @override
  _RadionRowScreenState createState() => _RadionRowScreenState();
}

class _RadionRowScreenState extends State<RadionRowScreen> {
  @override
  Widget build(BuildContext context) {
    return buildSongRow();
  }

  Widget buildSongRow() {
    var playerProvider = Provider.of<PlayerProvider>(context, listen: false);

    final bool isSelectedRadio =
        this.widget.radioModel.id == playerProvider.currentRadio.id;

    return ListTile(
      title: new Text(
        this.widget.radioModel.radioName,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xff182545),
        ),
      ),
      leading: _image(this.widget.radioModel.radioPic),
      subtitle: new Text(this.widget.radioModel.radioDesc, maxLines: 2),
      trailing: Wrap(
        spacing: -10.0, // gap between adjacent chips
        runSpacing: 0.0, // gap between lines
        children: <Widget>[
          buildPlayStopIcon(
            playerProvider,
            isSelectedRadio,
          ),
          buildAddFavouriteIcon(),
        ],
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

  Widget buildPlayStopIcon(
      PlayerProvider playerProvider, bool _isSelectedSong) {
    return IconButton(
      icon: _buildAudioButton(playerProvider, _isSelectedSong),
      onPressed: () {
        if (!playerProvider.isStopped() && _isSelectedSong) {
          playerProvider.stopRadio();
        } else {
          if (!playerProvider.isLoading()) {
            playerProvider.initAudioPlugin();
            playerProvider.setAudioPlayer(this.widget.radioModel);

            playerProvider.playRadio();
          }
        }
      },
    );
  }

  Widget _buildAudioButton(PlayerProvider model, _isSelectedSong) {
    if (_isSelectedSong) {
      if (model.isLoading()) {
        return Center(
          child: CircularProgressIndicator(strokeWidth: 2.0),
        );
      }

      if (!model.isStopped()) {
        return Icon(Icons.stop);
      }

      if (model.isStopped()) {
        return Icon(Icons.play_circle_filled);
      }
    } else {
      return Icon(Icons.play_circle_filled);
    }

    return new Container();
  }

  Widget buildAddFavouriteIcon() {
    var playerProvider = Provider.of<PlayerProvider>(context, listen: true);

    return IconButton(
      icon: this.widget.radioModel.isBookmarked
          ? Icon(Icons.favorite)
          : Icon(Icons.favorite_border),
      color: Color(0xff9097A6),
      onPressed: () {
        playerProvider.radioBookmarked(
          this.widget.radioModel.id,
          !this.widget.radioModel.isBookmarked,
          isFavouriteOnly: this.widget.isFavouriteOnlyRadios,
        );
      },
    );
  }
}
