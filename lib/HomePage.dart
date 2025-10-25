import 'package:flutter/material.dart';
import 'package:to_do_application/Controllers/product_controller.dart';
import 'package:to_do_application/Widgets/product_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ProductController productController = ProductController();

  Future fetchData() async
  {
    await productController.fetchProduct();
    setState(() {

    });
  }

  productDialog({String? id, String? name, String? img, int? qty, int? unitPrice, int? totalPrice, required bool isFromUpdate})
  {
    TextEditingController productNameController = TextEditingController(text: name);
    TextEditingController imageController = TextEditingController(text: img);
    TextEditingController quantityController = TextEditingController(text: qty != null ? qty.toString() : '');
    TextEditingController unitPriceController = TextEditingController(text: unitPrice != null ? unitPrice.toString() : '');
    TextEditingController totalPriceController = TextEditingController(text: totalPrice != null ? totalPrice.toString() : '');
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text(!isFromUpdate ? "Add Product" : "Update Product"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: productNameController,
            decoration: InputDecoration(
              labelText: "Product Name"
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: imageController,
            decoration: InputDecoration(
                labelText: "Image"
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: quantityController,
            decoration: InputDecoration(
                labelText: "Quantity"
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: unitPriceController,
            decoration: InputDecoration(
                labelText: "Unit Price"
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: totalPriceController,
            decoration: InputDecoration(
                labelText: "Total Price"
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")
              ),
              ElevatedButton(
                  onPressed: () async {
                    !isFromUpdate ? await productController.createProduct(productNameController.text, imageController.text, int.parse(quantityController.text),
                        int.parse(unitPriceController.text), int.parse(totalPriceController.text)) : await productController.updateProduct( id!,
                        productNameController.text, imageController.text, int.parse(quantityController.text), int.parse(unitPriceController.text), int.parse(totalPriceController.text));
                    setState(() {

                    });
                    Navigator.pop(context);
                  },
                  child: Text("Submit")
              )
            ],
          )
        ],
      ),
    ));
  }

  @override
  void initState(){
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product CRUD"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8
          ),
          itemCount: productController.productList.length,
          itemBuilder: (context, index){
            return ProductCard(
              product: productController.productList[index],
              onDelete: (){
                productController.deleteProduct(productController.productList[index].sId.toString()).then((value) async {
                  if(value){
                    await productController.fetchProduct();
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Product Deleted"))
                      );
                    });
                  } else {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Product can not be Deleted"))
                      );
                    });
                  }
                });
              },
              onEdit: (){
                productDialog(
                    id: productController.productList[index].sId,
                    name: productController.productList[index].productName,
                    img: productController.productList[index].img,
                    qty: productController.productList[index].qty,
                    unitPrice: productController.productList[index].unitPrice,
                    totalPrice: productController.productList[index].totalPrice,
                    isFromUpdate: true
                );
              },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          productDialog(
            isFromUpdate: false,
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
