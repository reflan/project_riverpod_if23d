import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/legacy.dart';

class MahasiswaNotifier extends StateNotifier<List<DocumentSnapshot>> {
  MahasiswaNotifier() : super([]);

  Stream<List<DocumentSnapshot>> streamData() {
    return FirebaseFirestore.instance
        .collection('mahasiswa')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  Future<void> addMahasiswa(String npm, String nama, String prodi) async {
    try {
      await FirebaseFirestore.instance.collection('mahasiswa').add({
        'npm': npm,
        'nama': nama,
        'prodi': prodi,
      });
    } on Exception catch (e) {
      // TODO
      print("error input data mahasiswa: $e");
    }
  }

  Future<void> deleteMahasiswa(String id) async {
    try {
      await FirebaseFirestore.instance.collection('mahasiswa').doc(id).delete();
    } on Exception catch (e) {
      // TODO
      print("error delete data mahasiswa: $e");
    }
  }
}

final MahasiswaProvider =
    StateNotifierProvider<MahasiswaNotifier, List<DocumentSnapshot>>(
      (ref) => MahasiswaNotifier(),
    );
