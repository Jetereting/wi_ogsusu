import 'package:flutter/material.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/entities/product_info.dart';
import 'package:wi_ogsusu/entities/product_sku_info.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/widget/page_loading_list8.dart';
import 'package:url_launcher/url_launcher.dart';


class MallPage extends StatefulWidget{
  @override
  MallPageState createState() => new MallPageState();

}

class MallPageState extends State<MallPage> with AutomaticKeepAliveClientMixin{

  Dio dio = new Dio();
  bool _loading = true;
  bool _skuLoading = true;
  List<ProductInfo> _productInfoList = [];
  List<ProductSkuInfo> _productSkuInfoList = [];

  @override
  void initState() {
    super.initState();
    print("mall init");
    _getProductsData();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _getProductsData() async{
    setState(() {
      _loading = true;
    });
    String url = Constant.URL_MALL_PRODUCTS ;
    Response response = await dio.get(url, data:{"type": Constant.PARAM_TYPE,
      "agent": Constant.PARAM_AGENT, "platform": Constant.PARAM_PLATFORM})
        .catchError((DioError e){
          print("DioError: " + e.toString());
        });
    int code = response.data['code'];
    if(code == 200) {
      List dataList = response.data['data'];
      if(mounted) {
        setState(() {
          _loading = false;
          _productInfoList = dataList.map((dataStr) {
            return ProductInfo.fromJson(dataStr);
          }).toList();
//          print(_newsInfoList);
        });
      }
    }else{
      print(response.data['msg']);
      if(mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

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

  _showLink(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not open page, network connect error';
    }
  }

  Widget buildProductListItem(ProductInfo productInfo){
    return GestureDetector(
      onTap: (){
//        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
//          return new WebViewPage(Constant.URL_MALL_PRODUCT + productInfo.id.toString());
//        }));
        _showLink(Constant.URL_MALL_PRODUCT + productInfo.id.toString());
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: new Column(
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: 'res/img/hold.jpg',
                image: productInfo.icon,
                fit: BoxFit.fill,
              ),
              Text(
                productInfo.label,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              Expanded(child: SizedBox(),),
              Row(
                children: <Widget>[
                  Text(
                    "\$" + productInfo.price.toString(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Expanded(child: SizedBox(),),
                  IconButton(
                    icon: Icon(Icons.more_vert, size: 18.0,),
                    onPressed: (){
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF0A0126),
        automaticallyImplyLeading: false,
        title: new Text(
          Translations.of(context).text('mall'),
        ),
        actions: <Widget>[
//          new IconButton(
//            tooltip: 'ShoppingCart',
//            icon: const Icon(Icons.shopping_cart),
//            onPressed: () async {
//
//            },
//          ),
        ],
      ),
      body: new Container(
        color: Color(0xFFEEEEEE),
        alignment: Alignment.center,
        child: _loading ?
        LoadingList8Page() :
        _productInfoList.length > 0 ?
        new RefreshIndicator(
          onRefresh: _getProductsData,
          child: new GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 4.0,
            padding: const EdgeInsets.all(4.0),
            childAspectRatio: 8/9,
            children: _productInfoList.map((ProductInfo productInfo) {
              return buildProductListItem(productInfo);
            }).toList(),
          ),
        ): new Container(
          alignment: Alignment.center,
          child: new Column(
            children: <Widget>[
              SizedBox(height: 60.0,),
              Image.asset('res/img/icon_sad_80.png', width: 40.0, height: 40.0,),
              Text(
                "No data yet!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                ),
              ),

            ],
          ),
        )
      )
    );
  }

}