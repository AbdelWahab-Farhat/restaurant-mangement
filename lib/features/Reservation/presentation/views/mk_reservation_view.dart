import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/Features/Profile/profile_cubit.dart';
import 'package:restaurant_management/core/widgets/buttons.dart';
import 'package:restaurant_management/core/widgets/custom_TextformField.dart';
import 'package:restaurant_management/core/widgets/custom_appbar.dart';
import 'package:restaurant_management/models/order/order.dart';
import 'package:restaurant_management/models/order/orderItem.dart';
import 'package:restaurant_management/models/reservation.dart';
import 'package:restaurant_management/models/user/user.dart';
import 'package:restaurant_management/utility/constents.dart';
import 'package:restaurant_management/utility/helpers.dart';
import 'package:restaurant_management/utility/size_config.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/user/customer.dart';
import '../../../../services/FirebaseServices/fireStore_service.dart';
import '../../../payment/presentation/views/loading_payment_screen.dart';


class MkReservationView extends StatefulWidget {
  const MkReservationView({super.key});

  @override
  State<MkReservationView> createState() => _MkReservationViewState();
}

class _MkReservationViewState extends State<MkReservationView> {
  // Initial reservation date set to current date
  DateTime _reservationDate = DateTime.now();

  final TextEditingController _controllerTableNum = TextEditingController();

  Time _timePicked = Time(hour: 0, minute: 0);
  bool _isTimePicked = false;
  bool _isRequsting = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Make Reservation', isCentred: false , hasBackButton: true,),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pick Date For Reservation',
                  style: TextStyle(
                    color: kDarkPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 280,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SfDateRangePicker(
                      showNavigationArrow: true,
                      showTodayButton: true,
                      initialDisplayDate: DateTime.now(),
                      initialSelectedDate: _reservationDate,
                      cancelText: 'Cancel',
                      confirmText: 'Confirm',
                      view: DateRangePickerView.year,
                      todayHighlightColor: Colors.blue,
                      allowViewNavigation: true,
                      minDate: DateTime.now(),
                      selectionColor: kDarkSecondaryColor.withOpacity(0.5),
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        if (args.value is DateTime) {
                          _reservationDate =
                              args.value; // Save selected date in the variable
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Reservation Time',
                  style: TextStyle(
                    color: kDarkPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: SizeConfig.screenWidth,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kAccentColor.withOpacity(0.8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        showPicker(
                          context: context,
                          value: _timePicked,
                          sunrise:
                          const TimeOfDay(hour: 6, minute: 0), // optional
                          sunset:
                          const TimeOfDay(hour: 18, minute: 0), // optional
                          duskSpanInMinutes: 120, // optional
                          onChange: (time) {
                            setState(() {
                              _timePicked = time;
                              _isTimePicked = true;
                            });
                            snackBarShowing(
                                context, 'Time Picked Successfully');
                          },
                        ),
                      );
                    },
                    child: Text(
                      _isTimePicked ? _timePicked.format(context) : "Pick Time",
                      style: const TextStyle(
                          color: kDarkSecondaryColor, fontSize: 17),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enter Table Number',
                  style: TextStyle(
                    color: kDarkPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  labelText: '',
                  icon: Icons.table_bar,
                  controller: _controllerTableNum,
                  validator: (String? value) {
                    try {
                      int.parse(value!);
                    } catch (_) {
                      return 'Enter Valid Table Number';
                    }
                    if (value.isEmpty) {
                      return 'Enter Valid Table Number';
                    } else if (int.parse(value) > 40) {
                      return 'Only 40 tables';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _isRequsting
                    ? const Center(child: CircularProgressIndicator())
                    : CustomFilledButton(
                    onTap: () async {
                      setState(() {
                        _isRequsting = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        User? user = await FirebaseService().getUser();
                        if (user is Customer) {
                          Customer customer = user;
                          List<OrderItem>? orderItems =
                          await FirebaseService().loadUserOrderItems();
                          double totalPrice = 0;
                          for (var item in orderItems!) {
                            totalPrice += item.totalItemPrice;
                          }
                          Order order = Order(
                              orderID: const Uuid().v1(),
                              customerID: customer.customerID,
                              orderStatus: OrderStatus.pending,
                              orderDate: DateTime.now(),
                              orderItems: orderItems!,
                              totalPrice: totalPrice);
                          Reservation rev = Reservation(
                              reservationID: const Uuid().v1(),
                              orderID: order.orderID,
                              customerID: customer.customerID,
                              tableNumber: int.parse(
                                  _controllerTableNum.text.trim()),
                              time: _timePicked,
                              reservationDate: _reservationDate);
                          bool result = await FirebaseService().addFullOrderWithReservation(order,rev);
                          if (result) {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoadingPaymentScreen(),), (route) => false,);
                          }
                        }
                        _isRequsting = false;
                        setState(() {});
                      }
                    },
                    text: 'Submit Reservation')
              ],
            ),
          ),
        ),
      ),
    );
  }
}