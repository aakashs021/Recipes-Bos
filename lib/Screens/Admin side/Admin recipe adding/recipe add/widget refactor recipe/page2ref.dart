import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/valuenotify.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';

showdialog(
    {required context,
    bool isedit = true,
    required TextEditingController txtedit,
    required var formkey,
    required ValueNotifier<List<String>> list,
    required int index}) {
  Valnotify notify = Valnotify();
  txtedit.text = list.value[index];
  showDialog(
    context: context,
    builder: (context) {
      return Form(
          key: formkey,
          child: AlertDialog(
            title: isedit ? text(name: list.value[index]) : null,
            content: isedit
                ? TextFormField(
                    maxLines: null,
                    minLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: txtedit,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill';
                      }
                      return null;
                    },
                  )
                : text(
                    name:
                        'Are you sure you want to delete ${list.value[index]}'),
            actions: [
              TextButton(
                  onPressed: () {
                    isedit
                        ? notify.itemeditting(
                            formkey: formkey,
                            list: list,
                            index: index,
                            editingController: txtedit,
                            context: context)
                        : notify.itemdelete(
                            list: list, index: index, context: context);
                  },
                  child: isedit ? text(name: 'Update') : text(name: 'Delete')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: text(name: 'Cancel'))
            ],
          ));
    },
  );
}

Widget listenablebuilder(
    {required TextEditingController editingController1,
    required double width,
    required var formkey,
    required ValueNotifier<List<String>> list}) {
  return ValueListenableBuilder(
    valueListenable: list,
    builder: (context, value, child) {
      return list.value.isEmpty
          ? const SizedBox()
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.value.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text(name: '${index + 1})'),
                    SizedBox(
                        width: width * 0.6,
                        child: text(name: list.value[index])),
                    InkWell(
                      onTap: () {
                        showdialog(
                            context: context,
                            txtedit: editingController1,
                            formkey: formkey,
                            list: list,
                            index: index);
                      },
                      child: Icon(Icons.edit),
                    ),
                    InkWell(
                      onTap: () {
                        showdialog(
                            context: context,
                            txtedit: editingController1,
                            formkey: formkey,
                            list: list,
                            index: index,
                            isedit: false);
                      },
                      child: Icon(Icons.delete),
                    ),
                 
                  ],
                );
              },
            );
    },
  );
}

Widget textformfeild(
    {required TextEditingController txtedit,
    required ValueNotifier<List<String>> list,
    required String hint}) {
  Valnotify notify = Valnotify();

  return TextFormField(
    controller: txtedit,
    maxLines: null,
    minLines: null,
    decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: 'Tap here to add $hint',
        suffixIcon: IconButton(
            onPressed: () {
              notify.itemsadding(txtedit: txtedit, list: list);
            },
            icon: const Icon(Icons.add))),
  );
}
