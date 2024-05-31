import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';

class ShopItem extends StatelessWidget {
  final String title;
  final Widget description;
  final int price;
  final Function() onBuyPressed;

  const ShopItem({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.onBuyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 40,
            child: Image.asset('assets/images/potion.png'),
          ),
          title: Text(title),
          subtitle: description,
          trailing: SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(price.toString()),
                const Icon(
                  Pixel.coin,
                  color: Colors.orangeAccent,
                ),
                IconButton.outlined(
                  onPressed: onBuyPressed,
                  icon: const Icon(Pixel.coin),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
