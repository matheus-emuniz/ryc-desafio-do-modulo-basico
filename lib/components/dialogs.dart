import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';

AlertDialog buildAlertDialog({
  required BuildContext context,
  Icon? icon,
  required String title,
  required String content,
  required String cancelActionText,
  required String confirmActionText,
  Icon? confirmActionIcon,
}) {
  return AlertDialog(
    shape: BeveledRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
    ),
    icon: icon,
    title: Text(title),
    content: Text(content),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        child: Text(cancelActionText),
      ),
      ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        icon: confirmActionIcon,
        label: Text(confirmActionText),
        iconAlignment: IconAlignment.end,
      )
    ],
  );
}

Future<dynamic> openConfirmBuyDialog(BuildContext context, String itemName) {
  return showDialog(
    context: context,
    builder: (_) {
      return buildAlertDialog(
        context: context,
        icon: const Icon(Pixel.coin,),
        title: 'Comprar Item',
        content: 'Tem certeza que deseja comprar uma $itemName',
        cancelActionText: 'Não',
        confirmActionText: 'COMPRAR -5',
        confirmActionIcon: const Icon(Pixel.coin),
      );
    },
  );
}

Future<dynamic> openConfirmCompleteDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) {
      return buildAlertDialog(
        context: context,
        icon: const Icon(Pixel.coin,),
        title: 'Completar tarefa',
        content: 'Tem certeza que deseja completar esta tarefa?',
        cancelActionText: 'Não',
        confirmActionText: 'SIM +5',
        confirmActionIcon: const Icon(Pixel.coin),
      );
    },
  );
}
