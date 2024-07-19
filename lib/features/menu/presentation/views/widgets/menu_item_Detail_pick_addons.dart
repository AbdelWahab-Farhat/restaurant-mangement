import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../../models/addon.dart';
import '../../../../../models/item.dart';
import '../../../../../utility/constents.dart';
import '../../../../../utility/size_config.dart';
import '../../viewModel/price_cubit/price_cubit.dart';

class MenuItemDetailPickAddons extends StatelessWidget {
  final Item item;

  const MenuItemDetailPickAddons({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    if (item.addons == null) {
      return const SizedBox();
    }
    return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Customize your Order',
                  style: TextStyle(
                      color: kDarkPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () => _showMultiSelect(context, item.addons!),
                child: Container(
                  width: SizeConfig.screenWidth,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.25),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        '- Select Your Favorite Addon',
                        style: TextStyle(color: kDarkSecondaryColor),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: kDarkPrimaryColor,
                      )
                    ],
                  ),
                ),
              )
            ],
          );
  }

  void _showMultiSelect(BuildContext context, List<Addon> addons) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          itemsTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: kDarkPrimaryColor),
          selectedColor: kAccentColor,
          backgroundColor: kLightPrimaryColor,
          confirmText: const Text(
            'Confirm',
            style: TextStyle(color: kDarkSecondaryColor, fontSize: 19),
          ),
          cancelText: const Text(
            'Cancel',
            style: TextStyle(color: kDarkSecondaryColor, fontSize: 19),
          ),
          title: Text('Addon On ${item.itemName}'),
          height: 200,
          items: addons
              .map((addon) => MultiSelectItem<Addon>(
            addon,
            "${addon.addonName}\t\t\t\t${addon.addonPrice} LY",
          ))
              .toList(),
          initialValue: context.read<PriceCubit>().addons,
          onConfirm: (values) {
            context.read<PriceCubit>().updateAddons(values.cast<Addon>());
          },
        );
      },
    );
  }
}
