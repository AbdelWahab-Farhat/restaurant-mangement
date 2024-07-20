import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../models/addon.dart';
import '../../../models/item.dart';
import '../../../services/FirebaseServices/fireStore_service.dart';
import '../../../utility/helpers.dart';
import 'widgets/addon_widget.dart';

part 'add_menu_item_state.dart';

class AddMenuItemCubit extends Cubit<AddMenuItemState> {
  File? imageFile;
  String? itemName;
  double? itemPrice;
  String? itemDes;
  List<Addon> addons = [];
  String pickedMenu = 'Salads';
  List<String> menuNames = ['Desserts','Salads','Drinks','Main Course'];

  AddMenuItemCubit() : super(AddMenuItemInitial());
  Future<File?> addPhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      } else {
        emit(PhotoChanged());
        return File(image.path);
      }
    } catch (e) {
      return null;
    }
  }
  void updateMenuName(String value) {
    pickedMenu = value;
    emit(DropMenuChanged());
  }
  void removeAddon(Addon addon) {
    addons.removeWhere((element) => element.addonName == addon.addonName,);
    emit(AddonChanged());
  }
  void addAddon(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    showAlertDialog(context, 'Add Addon', '', () {
      if (nameController.text.isEmpty || priceController.text.isEmpty) {
        return;
      }
      Addon addon = Addon(addonName: nameController.text.trim(),
          addonPrice: double.parse(priceController.text.trim()));
      nameController.clear();
      priceController.clear();
      addons.add(addon);
      emit(AddonChanged());
    },
        SizedBox(
          height: 80,
          child: Column(
            children: [
              AddonWidget(
                nameController: nameController, priceController: priceController,)
            ],
          ),
        )
    );
  }
  // only will used when everything not null (not addons)
  Future<void> addMenuItem()async{
    emit(AddMenuItemLoading());
    String? itemImageURL = await uploadImageToFirebase(imageFile!);
    if (itemImageURL == null) {
      emit(AddMenuItemFailure(message: 'Failed Adding Item'));
    }
    Item item = Item(itemID: const Uuid().v1(), itemName: itemName!, itemImageURL: itemImageURL!, price: itemPrice!, des: itemDes!);
    bool result = await FirebaseService().addingMenuItem(item, pickedMenu);
    if (result) {
      emit(AddMenuItemSuccess());
      imageFile = null;
      addons.clear();
    }
    else {
      emit(AddMenuItemFailure(message: 'Failed Adding Item'));
    }
  }


  Future<String?> uploadImageToFirebase(File file) async {
    try {
      String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';

      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(file);

      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return null;
    }
  }
}
