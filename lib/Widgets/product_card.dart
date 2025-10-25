import 'package:flutter/material.dart';
import 'package:to_do_application/Models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Data product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const ProductCard({super.key, required this.product, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    print(product.img.toString().startsWith('http'));
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 140,
            child: Image.network(
                (product.img != null && product.img.toString().startsWith('http')) ?
                product.img.toString() : "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png"
            ),
          ),
          Text(
            product.productName.toString(),
            style: TextStyle(
                fontSize: 19,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "Price: \$${product.unitPrice} | QTY: ${product.qty}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit, color: Colors.orange)
              ),
              IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete, color: Colors.red)
              ),
            ],
          )
        ],
      ),
    );
  }
}
