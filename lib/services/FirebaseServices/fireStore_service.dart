import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_management/models/menu/menu.dart';
import 'package:restaurant_management/models/order/orderItem.dart';
import 'package:restaurant_management/models/user/admin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/item.dart';
import '../../models/order/order.dart' as or;
import '../../models/reservation.dart';
import '../../models/user/customer.dart' as cust;
import '../../models/user/user.dart' as account;
import '../../models/user/user.dart' as role;

class FirebaseService {
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth frAuth = FirebaseAuth.instance;
  // Get menu with all items.
  Future<List<Menu>?> getMenus() async {
    try {
      final querySnapshot = await store.collection('menus').get();
      return querySnapshot.docs.map((doc) {
        return Menu.fromJson(doc.data());
      }).toList();
    } catch (e) {
      return null;
    }
  }

  // get the current user who sign in successfully
  Future<account.User?> getUser() async {
    // Saving the user in phone memory so when close the app the current user state will stay ( not done ).
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // instance of firebaseAuth (backend Server for auth)
      User? authUser = frAuth.currentUser;
      if (authUser != null) {
        // Try to get user data from SharedPreferences
        String? cachedUserData = prefs.getString('user');
        if (cachedUserData != null) {
          final data = jsonDecode(cachedUserData);
          if (data['role'] == role.Role.customer.name) {
            return cust.Customer.fromJson(data);
          } else {
            final data = jsonDecode(cachedUserData);
            return Admin.fromJson(data);
          }
        }

        // If no cached data, fetch from Firestore server
        final documentSnapshot =
        await store.collection('users').doc(authUser.uid).get();
        final data = documentSnapshot.data();
        if (data == null) {
          return null;
        } else if (data['role'] == role.Role.customer.name) {
          prefs.setString('user', jsonEncode(data));
          return cust.Customer.fromJson(data);
        } else {
          prefs.setString('user', jsonEncode(data));
          return Admin.fromJson(data);
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  // Logout of the app.
  Future<void> logoutUser() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.remove('user');
      await frAuth.signOut();
    } catch (e) {
      // no error for now.
    }
  }

  // Update User Data
  Future<bool> updateCustomer(
      cust.Customer customer, String oldPassword) async {
    try {
      // Update password in Firebase Authentication if password is not empty
      if (customer.password.isNotEmpty) {
        try {
          // Re-authenticate the user
          User? user = frAuth.currentUser;
          AuthCredential credential = EmailAuthProvider.credential(
            email: user!.email!,
            password: oldPassword,
          );
          await user.reauthenticateWithCredential(credential);
          await user.updatePassword(customer.password);
        } on FirebaseAuthException {
          // Handle specific Firebase Auth errors if needed
          return false;
        }
      }

      // Update other customer information in Firestore
      await store.collection('users').doc(customer.userID).update({
        'userName': customer.userName,
        'phoneNumber': customer.phoneNumber,
        'password': customer.password,
      });

      // If everything went well, return true
      return true;
    } catch (e) {
      // Return false to indicate failure
      return false;
    }
  }
  // add full order to database.

  Future<bool> addItemOrder(OrderItem orderItem) async {
    try {
      // Check if the item already exists
      var itemSnapshot =
      await store.collection('orderItems').doc(orderItem.itemID).get();

      if (itemSnapshot.exists) {
        // Item exists, update the quantity
        int currentQuantity = itemSnapshot['quantity'] ?? 0;
        int newQuantity = currentQuantity + orderItem.quantity;
        // Update the item with new quantity
        await store.collection('orderItems').doc(orderItem.itemID).update({
          'quantity': newQuantity,
        });

        return true; // Updated successfully
      } else {
        // Item does not exist, add new item
        await store
            .collection('orderItems')
            .doc(orderItem.itemID)
            .set(orderItem.toJson());
        return true; // Added successfully
      }
    } catch (e) {
      return false; // Error occurred
    }
  }

  Future<bool> removeItemOrder(OrderItem orderItem) async {
    try {
      final query = await store.collection('orderItems').get();
      for (var doc in query.docs) {
        OrderItem item = OrderItem.fromJson(doc.data());
        if (item.orderItemId == orderItem.orderItemId) {
          await store.collection('orderItems').doc(orderItem.itemID).delete();
        }
      }
      return true;
    } on FirebaseException {
      return false;
    }
  }

  Future<List<OrderItem>?> loadUserOrderItems() async {
    List<OrderItem> items = [];
    try {
      final querySnapShot = await store.collection('orderItems').get();
      for (var doc in querySnapShot.docs) {
        final OrderItem orderItem = OrderItem.fromJson(doc.data());
        if (orderItem.userID == frAuth.currentUser!.uid) {
          items.add(orderItem);
        }
      }
      return items;
    } on FirebaseException {
      // Error Happened
      return null;
    }
  }

  // saveCustomer rev
  Future<void> saveCustomerOrders(cust.Customer customer) async {
    try {
      // Retrieve orders from 'orders' collection
      final query = await store.collection('orders').get();
      List<or.Order> orders = [];

      // Convert each document to Order object and add to orders list
      for (var item in query.docs) {
        or.Order order = or.Order.fromJson(item.data());
        if (customer.customerID == order.customerID) {
          orders.add(order);
        }
      }



      // Update 'users' collection with the orders for current user
      await store.collection('users').doc(frAuth.currentUser!.uid).update({
        "orders": orders.map((order) => order.toJson()).toList(),
      });

    } catch (e) {
      // Handle error appropriately, e.g., show error message to user
    }
  }
  // TODO: TRY IT LATER
  Future<bool> addFullOrderWithReservation(or.Order order, Reservation rev) async {
    try {
      account.User? user = await getUser();
      await store.collection('orders').doc(order.orderID).set(order.toJson());
      for (var item in order.orderItems) {
        await store.collection('orderItems').doc(item.itemID).delete();
      }
      if (user is cust.Customer) {
        cust.Customer customer = user;
        await saveCustomerOrders(customer);
        await saveReservations(rev);
        bool result = await addReservation(rev);
        if (!result) {
          return false;
        }
      }
      return true;
    } catch (e) {
      print('Error adding order: $e');
      return false;
    }
  }

  // TODO: TRY IT LATER
  FutureOr<bool> addReservation(Reservation reservation) async {
    try {
      await store
          .collection('reservations')
          .doc(reservation.reservationID)
          .set(reservation.toJson());
      return true;
    } on FirebaseException {
      return false;
    }
  }

// TODO: TRY IT LATER
  FutureOr<bool> cancelReservation(Reservation reservation) async {
    try {
      await store
          .collection('reservation')
          .doc(reservation.reservationID)
          .delete();
      return true;
    } on FirebaseException {
      return false;
    }
  }

  // TODO: TRY IT LATER
  Future<List<Reservation>?> getCustomerReservation() async {
    final account.User? user = await getUser();
    if (user == null) {
      return null;
    } else {
      if (user is cust.Customer) {
        cust.Customer customer = user;
        QuerySnapshot querySnapshot = await store
            .collection('reservation')
            .where('customerID', isEqualTo: customer.customerID)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          List<Reservation> reservations = querySnapshot.docs.map((doc) {
            return Reservation.fromJson(doc.data() as Map<String, dynamic>);
          }).toList();
          return reservations;
        }
      }
      return null;
    }
  }
  Future<account.Role> checkUserRole(String id) async {
    final doc = await store.collection('users').doc(id).get();
    account.User? user = account.User.fromJson(doc.data()!);
    return user.role;
  }
  Future<bool> addingMenuItem(Item item, String menuName) async {
    try {
      final querySnapshot = await store.collection('menus').where(
          'menuName', isEqualTo: menuName).get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        Menu menu = Menu.fromJson(doc.data());
        menu.menuItems ??= [];
        menu.menuItems!.add(item);

        await store.collection('menus').doc(menu.menuID).update(
            {'menuItems': menu.menuItems!.map((e) => e.toJson(),)});
        return true;
      }
    } on FirebaseException catch (e) {
      print('Error: ${e.message}');
      return false;
    }
    return false;
  }
  Future<bool> removeMenuItem(Item item) async {
    try {
      final querySnapshot = await store.collection('menus').get();

      for (var doc in querySnapshot.docs) {
        Menu menu = Menu.fromJson(doc.data());
        menu.menuItems ??= [];
        menu.menuItems!.removeWhere((menuItem) {
          return menuItem.itemID == item.itemID;
        });
        await store.collection('menus').doc(menu.menuID).update(
            {'items': menu.menuItems!.map((e) => e.toJson()).toList()});
      }
      return true;
    } on FirebaseException catch (e) {
      print('errrrrror $e');
      return false;
    }

  }


  Future<List<Item>?> fetchItems() async {
    try {
      final query = await store.collection('menus').get();
      List<Item> items = [];
      for (var doc in query.docs) {
        Menu menu = Menu.fromJson(doc.data());
        for (var item in menu.menuItems!) {
          items.add(item);
        }
      }
      return items;
    }on FirebaseException catch(_){
      return null;
    }
  }

  Future<void> saveReservations(Reservation reservation) async {
      final data  = await store.collection('users').doc(frAuth.currentUser!.uid).get();
      if (data.data()!['role'] == 'customer') {
        cust.Customer customer = cust.Customer.fromJson(data.data()!);
        customer.reservations ??= [];
        if (customer.reservations != null) {
          customer.reservations!.add(reservation);
        }
        await store.collection('users').doc(customer.userID).update({
          'reservations':customer.reservations!.map((e) => e.toJson(),).toList()
          }
        );
        }
      }
}
