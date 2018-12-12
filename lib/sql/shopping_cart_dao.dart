import 'package:sqflite/sqflite.dart';
import 'package:wi_ogsusu/entities/product_sku_info.dart';
import 'dart:convert';

class ShoppingCartDao {

  String tableShoppingCart = 'shopping_cart';
  Database db;

  String columnId = 'id';
  String columnProductId = 'productId';
  String columnLabel = 'label';
  String columnColor = 'color';
  String columnType = 'type';
  String columnSize = 'size';
  String columnStock = 'stock';
  String columnPrice = 'price';
  String columnDiscount = 'discount';
  String columnDescription = 'description';
  String columnIcon = 'icon';
  String columnLink = 'link';
  String columnRemark = 'remark';

  Future open(String path) async {
    db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
        create table $tableShoppingCart ( 
          $columnId integer primary key autoincrement, 
          $columnProductId text not null,
          $columnLabel text not null,
          $columnColor text not null,
          $columnType text not null,
          $columnSize text not null,
          $columnStock integer not null,
          $columnPrice float not null,
          $columnDiscount float not null,
          $columnDescription text not null,
          $columnIcon text not null,
          $columnLink text not null,
          $columnPrice text not null)
        '''
      );
    });
  }

  Future<ProductSkuInfo> insert(ProductSkuInfo productSkuInfo) async {
    productSkuInfo.id = await db.insert(tableShoppingCart, json.decode(productSkuInfo.toString()));
    return productSkuInfo;
  }

  Future<ProductSkuInfo> getTodo(int id) async {
    List<Map> maps = await db.query(tableShoppingCart,
        columns: [columnId, columnProductId, columnLabel],
        where: "$id = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new ProductSkuInfo.fromJson(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableShoppingCart, where: "id = ?", whereArgs: [id]);
  }

  Future<int> update(ProductSkuInfo productSkuInfo) async {
    return await db.update(tableShoppingCart, json.decode(productSkuInfo.toString()),
        where: "id = ?", whereArgs: [productSkuInfo.id]);
  }

  Future close() async => db.close();
}