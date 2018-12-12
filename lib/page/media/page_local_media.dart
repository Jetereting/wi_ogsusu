import 'package:flutter/material.dart';
import 'package:wi_ogsusu/widget/page_loading_list8.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class PageLocalMedia extends StatefulWidget{

  @override
  _PageLocalMediaState createState() => new _PageLocalMediaState();

}

class _PageLocalMediaState extends State<PageLocalMedia> with AutomaticKeepAliveClientMixin{

  bool _loading = false;

  @override
  bool get wantKeepAlive => true;


  @override
  void initState() {
    super.initState();
    _selectedImage();
  }

  Future<File> _imageFile;

  void _selectedImage() {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return new ClipOval(
              child: SizedBox(
                  width: 70.0,
                  height: 70.0,
                  child: Image.file(snapshot.data, fit: BoxFit.cover)
              ),
            );
          } else {
            return new Image.asset("images/icon_tabbar_mine_normal.png", height: 70.0, width: 70.0);
          }
        });
  }


  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: Alignment.center,
        child: _loading  ?
        LoadingList8Page() :
        new RefreshIndicator(
          color: Colors.red,
          child: Container(
            child: _previewImage(),
          ),
          onRefresh: (){
            _selectedImage();
          },
        )
    );
  }


}