import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/widgets/buttons.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../models/item.dart';
import '../../../../../models/order/orderItem.dart';
import '../../../../../services/FirebaseServices/fireStore_service.dart';
import '../../../../../utility/helpers.dart';
import '../../../../../utility/size_config.dart';
import '../../../../root/presentation/views/root.dart';
import '../../viewModel/menu_detail_item/menu_detail_item_cubit.dart';
import '../../viewModel/price_cubit/price_cubit.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({
    super.key,
    required this.item,
    required this.quantity,
  });

  final Item item;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuDetailItemCubit, MenuDetailItemState>(
  listener: (context, state) {
    if(state is MenuDetailItemFailure){
      snackBarShowing(context, state.errMessage);
    }
    else if (state is MenuDetailItemSuccess){
      snackBarShowing(context, state.successMessage);
      pushAndRemoveUntil(context, const Root(),false);
    }
  },
  builder: (context, state) {
    if (state is MenuDetailItemLoading) {
      return const CustomLoadingWidget();
    }
    return CustomFilledIconButton(
      onTap: () async {
        final orderItem = OrderItem(
            orderItemId: const Uuid().v1(),
            itemID: item.itemID,
            itemName: item.itemName,
            itemImageURL: item.itemImageURL,
            price: item.price,
            des: item.des,
            quantity: quantity,
            addons: context.read<PriceCubit>().addons,
            userID: FirebaseService().frAuth.currentUser!.uid);
          await context.read<MenuDetailItemCubit>().addItem(orderItem);
                context.read<PriceCubit>().addons.clear();
      },
      text: 'Add to Cart',
      icon: Icons.shopping_cart_outlined,
      height: SizeConfig.screenHeight / 20,
      width: SizeConfig.screenWidth / 2,
    );
  },
);
  }
}
