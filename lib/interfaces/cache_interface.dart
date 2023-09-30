abstract class CacheInterface {
  Future<bool> saveData({key, data});
  Future<dynamic?> getData({key});
  Future<bool> deleteData({key});
  Future<bool> deleteAllData();
}
