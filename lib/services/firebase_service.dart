// // ignore_for_file: public_member_api_docs

// import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseService<T> {
//   final String collection;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final T Function(String, Map<String, dynamic>) fromDS;
//   final Map<String, dynamic> Function(T) toMap;

//   DatabaseService(
//     this.collection, {
//     required this.fromDS,
//     required this.toMap,
//   });

//   Future<T?> getSingle(String id) async {
//     final snap = await firestore.collection(collection).doc(id).get();

//     if (!snap.exists) {
//       return null;
//     }

//     return fromDS(snap.documentID, snap.data);
//   }

//   Stream<T> streamSingle(String id) => firestore.collection(collection).document(id).snapshots().map((snap) => fromDS(snap.documentID, snap.data));
//   Stream<List<T>> streamList() {
//     final ref = firestore.collection(collection);

//     return ref.snapshots().map((list) => list.documents.map((doc) => fromDS(doc.documentID, doc.data)).toList());
//   }

//   Future<List<T>> getQueryList({List<OrderBy> orderBy, List<QueryArgs> args, int limit, dynamic startAfter}) async {
//     CollectionReference collref = firestore.collection(collection);
//     Query ref;
//     if (args != null) {
//       for (QueryArgs arg in args) {
//         if (ref == null)
//           ref = collref.where(arg.key, isEqualTo: arg.value);
//         else
//           ref = ref.where(arg.key, isEqualTo: arg.value);
//       }
//     }
//     if (orderBy != null) {
//       orderBy.forEach((order) {
//         if (ref == null)
//           ref = collref.orderBy(order.field, descending: order.descending);
//         else
//           ref = ref.orderBy(order.field, descending: order.descending);
//       });
//     }
//     if (limit != null) {
//       if (ref == null)
//         ref = collref.limit(limit);
//       else
//         ref = ref.limit(limit);
//     }
//     if (startAfter != null && orderBy != null) {
//       ref = ref.startAfter([startAfter]);
//     }
//     QuerySnapshot query;
//     if (ref != null)
//       query = await ref.getDocuments();
//     else
//       query = await collref.getDocuments();

//     return query.documents.map((doc) => fromDS(doc.documentID, doc.data)).toList();
//   }

//   Stream<List<T>> streamQueryList({List<OrderBy> orderBy, List<QueryArgs> args}) {
//     CollectionReference collref = firestore.collection(collection);
//     Query ref;
//     if (orderBy != null) {
//       orderBy.forEach((order) {
//         if (ref == null)
//           ref = collref.orderBy(order.field, descending: order.descending);
//         else
//           ref = ref.orderBy(order.field, descending: order.descending);
//       });
//     }
//     if (args != null) {
//       for (QueryArgs arg in args) {
//         if (ref == null)
//           ref = collref.where(arg.key, isEqualTo: arg.value);
//         else
//           ref = ref.where(arg.key, isEqualTo: arg.value);
//       }
//     }
//     if (ref != null)
//       return ref.snapshots().map((snap) => snap.documents.map((doc) => fromDS(doc.documentID, doc.data)).toList());
//     else
//       return collref.snapshots().map((snap) => snap.documents.map((doc) => fromDS(doc.documentID, doc.data)).toList());
//   }

//   Future<List<T>> getListFromTo(String field, DateTime from, DateTime to, {List<QueryArgs> args = const []}) async {
//     var ref = firestore.collection(collection).orderBy(field);
//     for (QueryArgs arg in args) {
//       ref = ref.where(arg.key, isEqualTo: arg.value);
//     }
//     QuerySnapshot query = await ref.startAt([from]).endAt([to]).getDocuments();
//     return query.documents.map((doc) => fromDS(doc.documentID, doc.data)).toList();
//   }

//   Stream<List<T>> streamListFromTo(String field, DateTime from, DateTime to, {List<QueryArgs> args = const []}) {
//     var ref = firestore.collection(collection).orderBy(field, descending: true);
//     for (QueryArgs arg in args) {
//       ref = ref.where(arg.key, isEqualTo: arg.value);
//     }
//     var query = ref.startAfter([to]).endAt([from]).snapshots();
//     return query.map((snap) => snap.documents.map((doc) => fromDS(doc.documentID, doc.data)).toList());
//   }

//   Future<dynamic> createItem(T item, {String id}) {
//     if (id != null) {
//       return firestore.collection(collection).document(id).setData(toMap(item));
//     } else {
//       return firestore.collection(collection).add(toMap(item));
//     }
//   }

//   Future<void> updateItem(T item) => firestore.collection(collection).document(item.id).setData(toMap(item), merge: true);
//   Future<void> removeItem(String id) => firestore.collection(collection).document(id).delete();
// }

// class QueryArgs {
//   final String key;
//   final dynamic value;

//   QueryArgs(
//     this.key,
//     this.value,
//   );
// }

// class OrderBy {
//   final String field;
//   final bool descending;

//   OrderBy(
//     this.field, {
//     this.descending = false,
//   });
// }
