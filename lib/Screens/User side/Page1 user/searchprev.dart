// Future<Map<String, dynamic>> Alllistformfirebaseforsearch() async {
//   print('start');
//   List<Map<String, dynamic>> sublist = [];
//   List<Map<String, dynamic>> new1 = [];
//   List<String> foodid = [];
//   List<String> subfoodid = [];
//   QuerySnapshot qs =
//       await FirebaseFirestore.instance.collection('category').get();
//   List<QueryDocumentSnapshot> documents = qs.docs;

//   var uniquelis = {};
//   var lis = [];
//   for (int i = 0; i < documents.length; i++) {
//     Map<String, dynamic> a = {};
//     a = documents[i].data() as Map<String, dynamic>;
//     for (var d in a.entries) {
//       if (d.key != 'categoryimg') {
//         uniquelis[d.key] = d.value;
//         // lis.add({d.key: d.value});
//       }
//     }

//     for (var d in a.keys) {
//       if (d != 'categoryimg') {
//         new1.add(a);
//         subfoodid.add(d);
//       }
//     }
//     for (var d in a.values) {
//       if (d is Map<String, dynamic>) {
//         if (!foodid.contains(d)) {
//           sublist.add(d);
//         }
//       }
//     }
//   }
//   bool areListsEqual<T>(List<T> list1, List<T> list2) {
//     bool r = true;
//     if (list1.length != list2.length) {
//       r = false;
//     } else {
//       for (int i = 0; i < list1.length; i++) {
//         if (list1[i] != list2[i]) {
//           r = false;
//         }
//       }
//     }
//     r = true;
//     return r;
//   }

//   for (int i = 0; i < sublist.length; i++) {
//     for (int j = 0; j < sublist.length; j++) {
//       if (i != j &&
//           sublist[i]['foodname'] == sublist[j]['foodname'] &&
//           sublist[i]['description'] == sublist[j]['description'] &&
//           sublist[i]['hour'] == sublist[j]['hour'] &&
//           sublist[i]['min'] == sublist[j]['min'] &&
//           areListsEqual(sublist[i]['file'], sublist[j]['file']) &&
//           areListsEqual(sublist[i]['ingredients'], sublist[j]['ingredients']) &&
//           areListsEqual(sublist[i]['direction'], sublist[j]['direction'])) {
//         subfoodid.removeAt(j);
//         sublist.removeAt(j);
//       } else {
//         // print('nothing');
//       }
//     }
//   }
//   List<Map<String, dynamic>> sub = sublist.toList();
//   foodid = subfoodid;
//   // List<Map<String, dynamic>> searchfilterlist = [];
//   // print(sub);
//   // print(foodid);
//   lis = uniquelis.entries
//       .map((entry) => {entry.key.toString(): entry.value as dynamic})
//       .toList();
//   return {'sub': lis, 'foodid': foodid};
// }