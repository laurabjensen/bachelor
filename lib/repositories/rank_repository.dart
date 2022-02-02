import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/rank.dart';

class RankRepository {
  Future<List<Rank>> getRanks() async {
    var snapshot = await FirebaseFirestore.instance.collection('ranks').get();
    return snapshot.docs.map((e) => Rank.fromJson(e)).toList();
  }
}
