import '../models/models.dart';

abstract class SaveCurrentAccount{
  Future save(Account account);
}