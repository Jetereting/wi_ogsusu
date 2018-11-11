import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/entities/product_info.dart';
import 'package:wi_ogsusu/entities/product_sku_info.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/common/utils/modal_util.dart';
import 'package:wi_ogsusu/widget/page_loading_list7.dart';

// ignore: must_be_immutable
class ProductDetailPage extends StatefulWidget{

  ProductInfo _productInfo;

  ProductDetailPage(ProductInfo productInfo){
    this._productInfo = productInfo;
  }

  @override
  ProductDetailPageState createState() => new ProductDetailPageState(_productInfo);

}


enum AppBarBehavior { normal, pinned, floating, snapping }

class ProductDetailPageState extends State<ProductDetailPage> with AutomaticKeepAliveClientMixin{


  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  ProductInfo _productInfo;
  Dio dio = new Dio();
  bool _skuLoading = true;
  List<ProductSkuInfo> _productSkuInfoList = [];



  String _selectedColor;
  String _selectedModel;
  String _selectedSize;

  ProductDetailPageState(ProductInfo productInfo){
    this._productInfo = productInfo;
  }

  @override
  void initState() {
    super.initState();
    _getProductSkuData(_productInfo.id);
  }

  @override
  bool get wantKeepAlive => true;


  _getProductSkuData(int productId) async {
    setState(() {
      _skuLoading = true;
    });
    String url = Constant.URL_MALL_PRODUCT_SKUS + productId.toString() ;
    Response response = await dio.get(url)
        .catchError((DioError e){
      print("DioError: " + e.toString());
    });
    int code = response.data['code'];
    if(code == 200) {
      List dataList = response.data['data'];
      if(mounted) {
        setState(() {
          _skuLoading = false;
          _productSkuInfoList = dataList.map((dataStr) {
            return ProductSkuInfo.fromJson(dataStr);
          }).toList();
          print(_productSkuInfoList);
        });
      }
    }else{
      print(response.data['msg']);
      if(mounted) {
        setState(() {
          _skuLoading = false;
        });
      }
    }
  }

  void _addShoppingCart(){
    showNotice(context, 'coming soon ...');
  }

  Widget buildDetail(){
    var deviceSize = MediaQuery.of(context).size;
    return _productSkuInfoList.length <= 0 ?
    new Container(
      alignment: Alignment.center,
      child: new Column(
        children: <Widget>[
          SizedBox(height: 60.0,),
          Image.asset('res/img/icon_sad_80.png', width: 40.0, height: 40.0,),
          Text(
            "No more stock!",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
            ),
          ),
        ]
      )
    ):
    new Container(
      child: new Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 3.0, right: 10.0),
                child: Text('Color: '),
              ),
              Expanded(
                child: new Wrap(
                  children: buildColorChips(),
                ),
              ),
            ],
          ),

          new Row(
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 3.0, right: 10.0),
                child: Text('QTY: '),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 3.0, right: 10.0),
                child: Text('1'),
              ),
            ],
          ),
          SizedBox(height: 40.0,),
          RaisedButton.icon(
            color: Colors.deepOrange,
            onPressed: _selectedColor != null && _selectedColor.length > 0 ? (){
              _addShoppingCart();
            }: null,
            icon: Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
            ),
            label: Text(
              'Add to shopping cart',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ],
      )
    );
  }



  List<Widget> buildColorChips(){
    final List<Widget> choiceChips = _productSkuInfoList.where((ProductSkuInfo productSkuInfo) {
      return productSkuInfo.color != null && productSkuInfo.color.length > 0;
    }).map<Widget>((ProductSkuInfo productSkuInfo) {
      return new Padding(
        padding: EdgeInsets.all(1.0),
        child: new ChoiceChip(
          key: new ValueKey<String>(productSkuInfo.color),
          padding: EdgeInsets.all(1),
          backgroundColor: Colors.grey,
          label: new Text(productSkuInfo.color),
          labelStyle: TextStyle(
            fontSize: 11.0,
            color: Colors.white
          ),
          selected: _selectedColor == productSkuInfo.color,
          selectedColor: Colors.purpleAccent,
          onSelected: (bool value) {
            setState(() {
              _selectedColor = value ? productSkuInfo.color : '';
              print(_selectedColor);
            });
          },
        ),
      );
    }).toList();
    if(choiceChips.length <= 0){
      choiceChips.add(
        Padding(
          padding: EdgeInsets.only(top: 10.0, right: 10.0),
          child: Text('N/A'),
        )
      );
      _selectedColor = 'N/A';
    }
    return choiceChips;
  }

  void show(BuildContext context){
    showModalBottomSheet<Widget>(context: context, builder: (BuildContext context) {
      return new Container(
          child: new Padding(
              padding: const EdgeInsets.all(32.0),
              child: new Text('This is the modal bottom sheet. Tap anywhere to dismiss.',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 24.0
                  )
              )
          )
      );
    });
  }




  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    double _appBarHeight = deviceSize.width /16 * 9;
    return new Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: _appBarHeight,
            pinned: _appBarBehavior == AppBarBehavior.pinned,
            floating: _appBarBehavior == AppBarBehavior.floating ||
                _appBarBehavior == AppBarBehavior.snapping,
            snap: _appBarBehavior == AppBarBehavior.snapping,
            actions: <Widget>[
              new IconButton(
                icon: const Icon(Icons.shopping_cart),
                tooltip: 'ShoppingCart',
                onPressed: () {
                  _addShoppingCart();
                },
              ),
            ],
            flexibleSpace: new FlexibleSpaceBar(
              title: new Text(
                _productInfo.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
              centerTitle: true,
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                 Container(
                   child: FadeInImage.assetNetwork(
                     placeholder: 'res/img/hold.jpg',
                     image: _productInfo.icon,
                     fit: BoxFit.fill,
                   ),
                 ),
                  // This gradient ensures that the toolbar icons are distinct
                  // against the background image.
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.4),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new SliverPadding(
            padding: new EdgeInsets.all(3.0),
            sliver: new SliverList(
              delegate: new SliverChildListDelegate([
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _productInfo.currency + _productInfo.price.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 23.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Text(
                      _productInfo.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    Container(
                        child: _skuLoading ?
                        LoadingList7Page() : buildDetail()
                    ),
                  ],
                ),
              ])
              ),
          ),
        ]
      )
    );
  }

}