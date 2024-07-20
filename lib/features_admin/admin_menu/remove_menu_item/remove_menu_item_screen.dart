import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../models/item.dart';
import '../../../utility/helpers.dart';
import '../../../utility/size_config.dart';
import 'remove_menu_item_cubit.dart';
import 'serach_screen.dart';

class RemoveMenuItemScreen extends StatefulWidget {
  const RemoveMenuItemScreen({super.key});

  @override
  State<RemoveMenuItemScreen> createState() => _RemoveMenuItemScreenState();
}

class _RemoveMenuItemScreenState extends State<RemoveMenuItemScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RemoveMenuItemCubit>().initItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Remove Menu Item',
        isCentred: true,
        hasBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<RemoveMenuItemCubit, RemoveMenuItemState>(
          builder: (context, state) {
            if (state is RemoveMenuItemLoading) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (state is RemoveMenuItemSuccess) {
              List<Item> items = state.menuItems;
              return Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 45,
                    child: CustomFilledButton(onTap: () {
                      push(context, SearchScreen(items: items));
                    }, text: 'Search On Item')
                  ),
                   SizedBox(height: SizeConfig.space ,),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showAlertDialog(context, 'Deleting',
                                'Are you sure You want to delete the item with name ${items[index].itemName}',
                                () => context.read<RemoveMenuItemCubit>().removeItem(items[index]),
                                null);
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(10)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            items[index].itemImageURL),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    items[index].itemName,
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    '\$${items[index].price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Failed to load items'),
              );
            }
          },
        ),
      ),
    );
  }
}
