
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  final PermissionHandler _permissionHandler = PermissionHandler();


  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    // print(result[permission].toString());
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }
  Future<bool> requestStoragePermission() async {

    return _requestPermission(PermissionGroup.storage);
  }
  Future<bool> hasStoragePermission() async {
    return hasPermission(PermissionGroup.storage);
  }

  Future<bool> hasPermission(PermissionGroup permission) async {
    var permissionStatus =
    await _permissionHandler.checkPermissionStatus(permission);
    return permissionStatus == PermissionStatus.granted;
  }
}