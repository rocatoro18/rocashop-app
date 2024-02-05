// PATRON ADAPTADOR
// AQUI SOLO SE DEFINEN LAS REGLAS QUE NECESITO PARA LOS
// PAQUETES QUE VAYAN A USAR LA CAMARA
abstract class CameraGalleryService {
  Future<String?> takePhoto();
  Future<String?> selectPhoto();
  //Future<List<String>> selectMultiplePhoto();
}
