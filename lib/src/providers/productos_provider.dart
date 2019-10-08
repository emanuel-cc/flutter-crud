
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';


import 'package:formvalidation/src/models/producto_model.dart';


class ProductosProvider{
  final String _url = 'https://flutter-varios-4045d.firebaseio.com';

 Future<bool> crearProducto(ProductoModel producto)async{
   final url = '$_url/productos.json';

   final resp = await http.post(url,body: productoModelToJson(producto));

   final decodedData = json.decode(resp.body);
   print(decodedData);

   return true;
  }

   Future<bool> editarProducto(ProductoModel producto)async{
   final url = '$_url/productos/${producto.id}.json';

   final resp = await http.put(url,body: productoModelToJson(producto));

   final decodedData = json.decode(resp.body);
   print(decodedData);

   return true;
  }

  Future<List<ProductoModel>> cargarProductos()async{
    final url = '$_url/productos.json';

    final resp = await http.get(url);
    final Map<String,dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();
    //print(decodedData);
    if(decodedData == null) return [];

    decodedData.forEach((id,prod){
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);
      //print(prod);
    });
    print(productos[0].id);
    return productos;
  }

  Future<int> borrarProducto(String id)async{
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));

    return 1;
  }

  Future<String> subirImagen(File imagen)async{
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dwixxnayc/image/upload?upload_preset=dkveq33q');
    final mimeType = mime(imagen.path).split('/');

    //Crear el request para adjuntar la imagen
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    //preparar mi archivo para adjuntarlo a mi uploadrequest
    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType(mimeType[0],mimeType[1])
      );

    //Se puede adjun
    imageUploadRequest.files.add(file);
  }
}