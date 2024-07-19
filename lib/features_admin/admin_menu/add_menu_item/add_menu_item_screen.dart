import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:restaurant_management/core/widgets/buttons.dart';
import 'package:restaurant_management/core/widgets/custom_TextformField.dart';
import 'package:restaurant_management/core/widgets/custom_appbar.dart';
import 'package:restaurant_management/features_admin/admin_menu/add_menu_item/add_menu_item_cubit.dart';
import 'package:restaurant_management/utility/constents.dart';
import 'package:restaurant_management/utility/helpers.dart';
import 'package:restaurant_management/utility/size_config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../models/addon.dart';
import '../../../utility/functions/validate_functions.dart';

class AddMenuItemScreen extends StatefulWidget {
  const AddMenuItemScreen({super.key});

  @override
  State<AddMenuItemScreen> createState() => _AddMenuItemScreenState();
}

class _AddMenuItemScreenState extends State<AddMenuItemScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'ADD MENU ITEM',
        isCentred: true,
        hasBackButton: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _photoWidget(context),
              _customTextFieldsInputs(context),
              BlocConsumer<AddMenuItemCubit, AddMenuItemState>(
                listener: (context, state) {
                  if (state is AddMenuItemSuccess) {
                    snackBarShowing(context, 'Item Added');
                    Navigator.pop(context);
                    context.read<AddMenuItemCubit>().imageFile = null;
                  }
                },
                builder: (context, state) {
                  if (state is AddMenuItemLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomFilledButton(
                    onTap: () {
                      if (context.read<AddMenuItemCubit>().imageFile == null) {
                        snackBarShowing(context, 'Enter photo');
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context.read<AddMenuItemCubit>().addMenuItem();
                      }
                    },
                    text: 'Add Item',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _photoWidget(BuildContext context) {
    return BlocBuilder<AddMenuItemCubit, AddMenuItemState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            context.read<AddMenuItemCubit>().imageFile = await context.read<AddMenuItemCubit>().addPhoto();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(),
            ),
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight / 5,
            child: Center(
              child: (context.read<AddMenuItemCubit>().imageFile != null)
                  ? Image.file(
                      context.read<AddMenuItemCubit>().imageFile!,
                      fit: BoxFit.cover,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Pick Image'),
                        SizedBox(
                          height: SizeConfig.space * 0.5,
                        ),
                        const Icon(LineAwesomeIcons.camera_retro_solid),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _customTextFieldsInputs(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Item Name',
              style: TextStyle(
                  color: kDarkPrimaryColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: SizeConfig.space,
            ),
            CustomTextFormField(
              icon: LineAwesomeIcons.glass_cheers_solid,
              validator: validateName,
              labelText: '',
              onSaved: (value) =>
                  context.read<AddMenuItemCubit>().itemName = value,
            ),
            const Text(
              'Item Price',
              style: TextStyle(
                  color: kDarkPrimaryColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: SizeConfig.space,
            ),
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth / 3,
                  child: CustomTextFormField(
                    icon: LineAwesomeIcons.dollar_sign_solid,
                    isNum: true,
                    onSaved: (value) => context
                        .read<AddMenuItemCubit>()
                        .itemPrice = double.parse(value!),
                    validator: (String? value) {
                      RegExp decimalPattern = RegExp(r'^\d+(\.\d+)?$');
                      if (value == null || value.isEmpty) {
                        return 'Enter value';
                      } else if (!decimalPattern.hasMatch(value)) {
                        return 'Enter Number value';
                      } else {
                        return null;
                      }
                    },
                    labelText: '',
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth / 3,
                  child: _dropdownButton(context),
                ),
              ],
            ),
            const Text(
              'Item description',
              style: TextStyle(
                  color: kDarkPrimaryColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w600),
            ),
            CustomTextFormField(
              icon: LineAwesomeIcons.amilia,
              onSaved: (value) =>
                  context.read<AddMenuItemCubit>().itemDes = value,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'please enter description for item';
                }
              },
              labelText: '',
            ),
            Center(
              child: CustomOutLinedButton(
                onTap: () => context.read<AddMenuItemCubit>().addAddon(context),
                text: "Add Addon's",
                width: 200,
              ),
            ),
            _addonBuild(context),
            SizedBox(
              height: SizeConfig.space * 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropdownButton(BuildContext context) {
    return BlocBuilder<AddMenuItemCubit, AddMenuItemState>(
      builder: (context, state) {
        final cubit = context.read<AddMenuItemCubit>();
        return DropdownButton2<String>(
          value: cubit.pickedMenu,
          items: cubit.menuNames
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              cubit.updateMenuName(value);
            }
          },
          hint: const Text('Select Menu'),
          dropdownStyleData: DropdownStyleData(
            elevation: 5,
            maxHeight: 200,
            width: SizeConfig.screenWidth * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget _addonBuild(BuildContext context) {
    return BlocBuilder<AddMenuItemCubit, AddMenuItemState>(
      builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.space * 2),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: context.read<AddMenuItemCubit>().addons.length,
              itemBuilder: (context, index) {
                List<Addon> addons = context.read<AddMenuItemCubit>().addons;
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.space * 0.5,
                        horizontal: SizeConfig.space),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(SizeConfig.space * 0.5),
                      title: Text(
                        addons[index].addonName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Price: ${addons[index].addonPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle,
                            color: Colors.redAccent),
                        onPressed: () => context
                            .read<AddMenuItemCubit>()
                            .removeAddon(addons[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
      },
    );
  }
}
