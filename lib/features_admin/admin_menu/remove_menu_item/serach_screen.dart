import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../core/widgets/custom_appbar.dart';
import '../../../models/item.dart';
import '../../../utility/helpers.dart';
import 'remove_menu_item_cubit.dart';

class SearchScreen extends StatelessWidget {
  final List<Item> items;
  const SearchScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: '',
        isCentred: false,
        hasBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SearchableList<Item>(
          shrinkWrap: true,
          initialList: items,
          itemBuilder: (item) => GestureDetector(
            onTap: () => showAlertDialog(context, 'Deleting',
                  'Are you sure You want to delete the item with name ${item.itemName}',
                      () => context.read<RemoveMenuItemCubit>().removeItem(item),null),
            child: ListTile(
              title: Text(item.itemName),
              trailing: Text(
                item.price.toStringAsFixed(0) + " LY",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          filter: (value) => items
              .where(
                (element) => element.itemName
                    .toLowerCase()
                    .contains(value.toLowerCase()),
              )
              .toList(),
          emptyWidget: const Center(
            child: Text('There is no Matching Item'),
          ),
          inputDecoration: InputDecoration(
            labelText: "Search On Item For Delete",
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.search),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
