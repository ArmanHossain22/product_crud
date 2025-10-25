import 'dart:convert';

import 'package:to_do_application/Models/product_model.dart';
import 'package:to_do_application/Utils/urls.dart';
import 'package:http/http.dart' as http;

class ProductController
{
  List<Data> productList = [];

  Future fetchProduct() async
  {
    final response = await http.get(Uri.parse(Urls.readProduct));
    print(response.statusCode);

    if(response.statusCode == 200)
    {
      final data = jsonDecode(response.body);
      ProductModel model = ProductModel.fromJson(data);
      productList = model.data ?? [];
    }
  }

  Future<bool> deleteProduct(String productId) async
  {
    final response = await http.get(Uri.parse(Urls.deleteProduct(productId)));
    print(response.statusCode);

    if(response.statusCode == 200)
    {
      return true;
    } else  {
      return false;
    }
  }

  Future<bool> createProduct(String name, String img, int qty, int unitPrice, int totalPrice) async
  {
    final response = await http.post(Uri.parse(Urls.createProduct),
      headers: {'Content-Type' : 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice" : totalPrice
      })
    );
    print(response.statusCode);

    if(response.statusCode == 200)
    {
      await fetchProduct();
      return true;
    } else  {
      return false;
    }
  }

  Future<bool> updateProduct(String productId, String name, String img, int qty, int unitPrice, int totalPrice) async
  {
    final response = await http.post(Uri.parse(Urls.updateProduct(productId)),
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode({
          "ProductName": name,
          "ProductCode": DateTime.now().microsecondsSinceEpoch,
          "Img": img,
          "Qty": qty,
          "UnitPrice": unitPrice,
          "TotalPrice" : totalPrice
        })
    );
    print(response.statusCode);

    if(response.statusCode == 200)
    {
      await fetchProduct();
      return true;
    } else  {
      return false;
    }
  }
}