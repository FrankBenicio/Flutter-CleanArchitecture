import '../models/models.dart';

abstract class LoadCurrentAccount{
  Future<Account> load();
}