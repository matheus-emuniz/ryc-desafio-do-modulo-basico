import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';

class AppElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final Icon? icon;

  const AppElevatedButton({
    super.key,
    this.onPressed,
    this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(1),
            ),
          ),

        ),
        onPressed: onPressed,
        label: const Icon(Pixel.addbox),
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(1),
          ),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
