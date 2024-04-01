import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectweek1/Firebase%20helper/firebase_adminrec3.dart';
import 'package:projectweek1/Hive%20helper/Hive%20shopping/shopping_functions.dart';
import 'package:projectweek1/Hive%20helper/Hive%20shopping/shopping_model.dart';
// import 'package:projectweek1/firebase_helper/firebase_adminrec3.dart';
// import 'package:projectweek1/hive_helper/hive_shopping/shopping_functions.dart';
// import 'package:projectweek1/hive_helper/hive_shopping/shopping_model.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';

class Usershopping extends StatefulWidget {
  const Usershopping({super.key});

  @override
  State<Usershopping> createState() => _UsershoppingState();
}

class _UsershoppingState extends State<Usershopping> {
  double bottom = 20.0;
  double left = 0.0;

  TextEditingController shopcontrol = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ReorderableListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    Shopping shop = Shopping(
                        id: shoppinglisthive[index].id,
                        shoppinlist: shoppinglisthive[index].shoppinlist,
                        count: shoppinglisthive[index].count,
                        customcheckbox:
                            !shoppinglisthive[index].customcheckbox);
                    await updateshop(shop: shop);
                    await getshop();
                    setState(() {});
                  },
                  key: ValueKey(index),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: shoppinglisthive[index].customcheckbox
                            ? Colors.green[100]
                            : Colors.blue[100],
                        borderRadius: BorderRadius.circular(20)),
                    width: double.infinity,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Shopping shop = Shopping(
                                  count: shoppinglisthive[index].count,
                                  id: shoppinglisthive[index].id,
                                  shoppinlist:
                                      shoppinglisthive[index].shoppinlist,
                                  customcheckbox:
                                      !shoppinglisthive[index].customcheckbox);
                              await updateshop(shop: shop);
                              await getshop();
                              setState(() {});
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(color: Colors.black)),
                              child: shoppinglisthive[index].customcheckbox
                                  ? const Icon(
                                      Icons.check,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.circle,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Stack(
                                    children: [
                                      shoppinglisthive[index].customcheckbox
                                          ? Positioned(
                                              top: 14,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                height: 2,
                                                color: Colors.red,
                                              ),
                                            )
                                          : const SizedBox(),
                                      Text(
                                        shoppinglisthive[index].shoppinlist,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      text(name: 'Qty:'),
                                      InkWell(
                                        onTap: () async {
                                          // Your onTap logic
                                          int count =
                                              shoppinglisthive[index].count;
                                          if (count > 1) {
                                            count =
                                                shoppinglisthive[index].count -
                                                    1;
                                          }
                                          Shopping shop = Shopping(
                                              id: shoppinglisthive[index].id,
                                              shoppinlist:
                                                  shoppinglisthive[index]
                                                      .shoppinlist,
                                              customcheckbox:
                                                  shoppinglisthive[index]
                                                      .customcheckbox,
                                              count: count);
                                          await updateshop(shop: shop);
                                          await getshop();
                                          setState(() {});
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 10,
                                          child: Icon(
                                            Icons.horizontal_rule_sharp,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      text(
                                          name:
                                              ' ${shoppinglisthive[index].count} '),
                                      InkWell(
                                        onTap: () async {
                                          // Your onTap logic
                                          int count =
                                              shoppinglisthive[index].count + 1;
                                          Shopping shop = Shopping(
                                              id: shoppinglisthive[index].id,
                                              shoppinlist:
                                                  shoppinglisthive[index]
                                                      .shoppinlist,
                                              customcheckbox:
                                                  shoppinglisthive[index]
                                                      .customcheckbox,
                                              count: count);
                                          await updateshop(shop: shop);
                                          await getshop();
                                          setState(() {});
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.green,
                                          radius: 10,
                                          child: Icon(
                                            Icons.add,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: text(
                                        name:
                                            'Are you sure you want to delete ${shoppinglisthive[index].shoppinlist}'),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            await deleteshop(
                                                shop:
                                                    shoppinglisthive[index].id);
                                            await getshop();
                                            setState(() {});
                                            // ignore: use_build_context_synchronously
                                            navigatorpop(context);
                                          },
                                          child: text(name: 'Yes')),
                                      TextButton(
                                          onPressed: () {
                                            navigatorpop(context);
                                          },
                                          child: text(name: 'No')),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: shoppinglisthive.length,
              onReorder: (oldIndex, newIndex) async {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex--;
                  }

                  Shopping a = shoppinglisthive.removeAt(oldIndex);
                  shoppinglisthive.insert(newIndex, a);
                });
              },
            ),
          ),
          Positioned(
            bottom: bottom,
            left: left,
            child: GestureDetector(
              onPanUpdate: (details) {
                bottom = max(20, bottom - details.delta.dy);
                if (bottom < 20) {
                  bottom = 20;
                } else if (bottom > 500) {
                  bottom = 500;
                }
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: shopcontrol,
                          maxLength: 30,
                          decoration: InputDecoration(
                            hintText: 'Tap here to add ingredients',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            filled: true,
                            fillColor: Colors.lightBlue[100],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (shopcontrol.text.trim().isNotEmpty) {
                            Shopping shop = Shopping(
                                id: DateTime.now().toString(),
                                shoppinlist: shopcontrol.text.trim(),
                                count: 1,
                                customcheckbox: false);
                            await addshop(shopping: shop);
                            await getshop();
                            setState(() {
                              shopcontrol.clear();
                            });
                          }
                        },
                        icon: const Icon(Icons.send),
                        iconSize: 40,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
