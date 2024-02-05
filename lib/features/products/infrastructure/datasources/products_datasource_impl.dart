import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/mappers/product_mapper.dart';
import '../errors/product_errors.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  late final Dio dio;
  final String accessToken;
  ProductsDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {'Authorization': 'Bearer $accessToken'}));

  Future<List<String>> _uploadPhotos(List<String> photos) async {
    // LISTADO DE TODAS LAS FOTOS QUE TIENEN UN SLASH EN EL NOMBRE,
    // SI TIENE UN SLASH EN EL NOMBRE GENERALMENTE VIENE DEL FILE SYSTEM
    final photosToUpload =
        photos.where((element) => element.contains('/')).toList();

    // TODAS LAS FOTOS QUE NO CONTENGAN ESE SLASH
    final photosToIgnore =
        photos.where((element) => !element.contains('/')).toList();

    // TODO: CREAR UNA SERIE DE FUTURES DE CARGA DE IMAGENES
    final List<Future<String>> uploadJob = [];

    final newImages = await Future.wait(uploadJob);

    // RETURN CON FOTOS INICIALES
    return [
      ...photosToIgnore,
      ...newImages,
    ];
  }

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final String? productId = productLike['id'];
      final String method = (productId == null) ? 'POST' : 'PATCH';
      final String url =
          (productId == null) ? '/products' : '/products/$productId';
      productLike.remove('id');
      productLike['images'] = await _uploadPhotos(productLike['images']);
      final response = await dio.request(url,
          data: productLike, options: Options(method: method));
      final product = ProductMapper.jsonToEntity(response.data);
      return product;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final response = await dio.get('/products/$id');
      final product = ProductMapper.jsonToEntity(response.data);
      return product;
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) throw ProductNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 0}) async {
    // TAMBIEN SE PUEDE MANDAR COMO QUERY PARAMETERS
    final response =
        await dio.get<List>('/products?limit=$limit&offset=$offset');
    final List<Product> products = [];
    for (final product in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product));
    }
    //print(products);
    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
}
