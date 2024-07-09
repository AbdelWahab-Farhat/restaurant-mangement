import 'package:flutter/material.dart';
import 'package:restaurant_management/core/widgets/buttons.dart';
import 'package:restaurant_management/models/order/order.dart';
import 'package:restaurant_management/models/order/orderItem.dart';
import 'package:restaurant_management/utility/size_config.dart';

import '../models/menu/menu.dart';

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


double totalItemsPrice(List<OrderItem> items) {
  double tp = 0;
  for (var item in items) {
    tp+=item.totalItemPrice;
  }
  return tp;
}

String formatDate(DateTime datetime) {
  return '${datetime.year}-${datetime.month}-${datetime.day}';
}


// Check if name is Right
String? validateName(String? value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = RegExp(pattern);
  if (value?.isEmpty ?? true) {
    return "Name is required";
  } else if (!regExp.hasMatch(value ?? '')) {
    return "Name must be a-z and A-Z";
  }
  return null;
}
String? validateUserName(String? value) {
  print("$value <-------------------value");
  if (value?.isEmpty ?? true) {
    return "Username is required";
  } else if (value!.length <= 2) {
    return "Username must be more than 3 characters";
  }
  return null;
}


// Check if Mobile is Right
String? validateMobile(String? value) {
  String pattern = r'(^\+?[0-9]*$)';
  RegExp regExp = RegExp(pattern);
  if (value?.isEmpty ?? true) {
    return "Mobile phone number is required";
  } else if (!regExp.hasMatch(value ?? '')) {
    return "Mobile phone number must contain only digits";
  }
  return null;
}

// Check if Password is Right
String? validatePassword(String? value) {
  if ((value?.length ?? 0) < 6) {
    return 'Password must be more than 5 characters';
  } else {
    return null;
  }
}
// Check if confirm Password is Right
String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (password != confirmPassword) {
    return 'Password doesn\'t match';
  } else if (confirmPassword?.isEmpty ?? true) {
    return 'Confirm password is required';
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value ?? '')) {
    return 'Enter Valid Email';
  } else {
    return null;
  }
}

//helper method to show alert dialog
showAlertDialog(BuildContext context, String title, String content , void Function() onPressOk) {
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
    content: Text(content),
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
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

pushReplacement(BuildContext context, Widget destination) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => destination));
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

