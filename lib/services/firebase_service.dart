// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

///
/// Service used for Firebase manipulation
/// Has lots of helper methods which ease our Firebase use
///

class FirebaseService<T> extends GetxService {
  ///
  /// CONSTRUCTOR
  ///

  final String collection;
  final T Function(Map<String, dynamic> map) fromMap;
  final Map<String, dynamic> Function(T model) toMap;
  final firestore = FirebaseFirestore.instance;

  FirebaseService(
    this.collection, {
    required this.fromMap,
    required this.toMap,
  });

  ///
  /// METHODS
  ///

  Future<T?> getSingle(String id) async {
    final documentSnapshot = await firestore.collection(collection).doc(id).get();

    if (!documentSnapshot.exists) {
      return null;
    }

    return fromMap(documentSnapshot.data()!);
  }

  Stream<T> streamSingle(String id) => firestore.collection(collection).doc(id).snapshots().map((snap) => fromMap(snap.data()!));
  Stream<List<T>> streamList() {
    final ref = firestore.collection(collection);
    return ref.snapshots().map((list) => list.docs.map((doc) => fromMap(doc.data())).toList());
  }

  Future<List<T>> getQueryList({List<OrderBy>? orderBy, List<QueryArgs>? args, int? limit, startAfter}) async {
    final collectionReference = firestore.collection(collection);
    Query<Map<String, dynamic>>? ref;

    if (args != null) {
      for (final arg in args) {
        if (ref == null) {
          ref = collectionReference.where(arg.key, isEqualTo: arg.value);
        } else {
          ref = ref.where(arg.key, isEqualTo: arg.value);
        }
      }
    }

    if (orderBy != null) {
      orderBy.forEach((order) {
        if (ref == null) {
          ref = collectionReference.orderBy(order.field, descending: order.descending);
        } else {
          ref = ref!.orderBy(order.field, descending: order.descending);
        }
      });
    }

    if (limit != null) {
      if (ref == null) {
        ref = collectionReference.limit(limit);
      } else {
        ref = ref!.limit(limit);
      }
    }

    if (startAfter != null && orderBy != null) {
      if (ref != null) {
        ref = ref!.startAfter([startAfter]);
      }
    }

    late QuerySnapshot<Map<String, dynamic>> query;

    if (ref != null) {
      query = await ref!.get();
    } else {
      query = await collectionReference.get();
    }

    return query.docs.map((doc) => fromMap(doc.data())).toList();
  }

  Stream<List<T>> streamQueryList({List<OrderBy>? orderBy, List<QueryArgs>? args}) {
    final collectionReference = firestore.collection(collection);
    Query<Map<String, dynamic>>? ref;

    if (orderBy != null) {
      orderBy.forEach((order) {
        if (ref == null) {
          ref = collectionReference.orderBy(order.field, descending: order.descending);
        } else {
          ref = ref!.orderBy(order.field, descending: order.descending);
        }
      });
    }

    if (args != null) {
      for (final arg in args) {
        if (ref == null) {
          ref = collectionReference.where(arg.key, isEqualTo: arg.value);
        } else {
          ref = ref!.where(arg.key, isEqualTo: arg.value);
        }
      }
    }

    if (ref != null) {
      return ref!.snapshots().map((snap) => snap.docs.map((doc) => fromMap(doc.data())).toList());
    } else {
      return collectionReference.snapshots().map((snap) => snap.docs.map((doc) => fromMap(doc.data())).toList());
    }
  }

  Future<List<T>> getListFromTo(String field, DateTime from, DateTime to, {List<QueryArgs> args = const []}) async {
    var ref = firestore.collection(collection).orderBy(field);

    for (final arg in args) {
      ref = ref.where(arg.key, isEqualTo: arg.value);
    }

    final query = await ref.startAt([from]).endAt([to]).get();

    return query.docs.map((doc) => fromMap(doc.data())).toList();
  }

  Stream<List<T>> streamListFromTo(String field, DateTime from, DateTime to, {List<QueryArgs> args = const []}) {
    var ref = firestore.collection(collection).orderBy(field, descending: true);

    for (final arg in args) {
      ref = ref.where(arg.key, isEqualTo: arg.value);
    }

    final query = ref.startAfter([to]).endAt([from]).snapshots();

    return query.map((snap) => snap.docs.map((doc) => fromMap(doc.data())).toList());
  }

  Future<dynamic> createItem(T item, {String? id}) {
    if (id != null) {
      return firestore.collection(collection).doc(id).set(toMap(item));
    } else {
      return firestore.collection(collection).add(toMap(item));
    }
  }

  Future<void> updateItem(T item, {String? id}) => firestore.collection(collection).doc(id).set(toMap(item), SetOptions(merge: true));

  Future<void> removeItem(String id) => firestore.collection(collection).doc(id).delete();
}

class QueryArgs {
  final String key;
  final dynamic value;

  QueryArgs(
    this.key,
    this.value,
  );
}

class OrderBy {
  final String field;
  final bool descending;

  OrderBy(
    this.field, {
    this.descending = false,
  });
}
