import 'package:flutter/material.dart';

import '../core/widgets/buttons.dart';
import '../models/order/order.dart';
import 'size_config.dart';


Color orderStateColor(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return Colors.deepOrangeAccent;
    case OrderStatus.ongoing:
      return Colors.lightGreen;
    case OrderStatus.completed:
      return Colors.green;
    default:
      return Colors.white;
  }
}



String? formatDate(DateTime? datetime) {
  if (datetime == null) {
    return null;
  }
  return '${datetime.year}/${datetime.month}/${datetime.day}';
}




//helper method to show alert dialog
showAlertDialog(BuildContext context, String title, String content , void Function() onPressOk,Widget? widgetContent) {
  // set up the AlertDialog
  Widget okButton = CustomOutLinedButton(
      width: 80,
      height: 40,
      onTap: () {
        Navigator.pop(context);
        onPressOk();
      }, text: 'Ok');
  Widget cancelButton = CustomOutLinedButton(
      width: 80,
      height: 40,
      onTap: () => Navigator.pop(context), text: 'cancel');
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: widgetContent ?? Text(content,style: const TextStyle(fontSize: 18),),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        okButton,
        SizedBox(width: SizeConfig.space,),
        cancelButton
      ],)

    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


 // snackbar
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarShowing(BuildContext context , text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text),duration: const Duration(milliseconds: 700),));
}

pushReplacement(BuildContext context, Widget destination) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => destination));
}


push(BuildContext context, Widget destination) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => destination));
}


pushAndRemoveUntil(BuildContext context, Widget destination, bool predict) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => destination),
          (Route<dynamic> route) => predict);
}

