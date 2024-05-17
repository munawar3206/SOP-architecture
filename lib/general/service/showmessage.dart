import 'package:native_toast/native_toast.dart';
void showMessage(String msg) async {
  await NativeToast().makeText(
    message: msg,
    duration: NativeToast.shortLength,
  );
}
