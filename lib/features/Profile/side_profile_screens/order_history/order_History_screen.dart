import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/core/widgets/custom_cached_Image.dart';
import 'order_history_cubit.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: BlocProvider(
        create: (context) => OrderHistoryCubit(),
        child: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderHistoryError) {
              return Center(child: Text(state.message));
            } else if (state is OrderHistorySuccess) {
              final orders = state.userOrders;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: const Icon(
                          Icons.receipt_long,
                          color: Colors.orangeAccent,
                          size: 40.0,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status: ${order.orderStatus.toString().split('.').last}',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              'Date: ${order.orderDate.toLocal().toString().split(' ')[0]}',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                title:  Container(
                                   clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: CustomCachedImage(
                                    imageUrl: order.orderItems.first.itemImageURL,
                                  ),
                                ),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: order.orderItems.map((item) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text(
                                            item.itemName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          trailing: Text(
                                            '\$${item.price.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              color: Colors.green[700],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
            return Container(); // Default case if none of the above states match
          },
        ),
      ),
    );
  }
}
