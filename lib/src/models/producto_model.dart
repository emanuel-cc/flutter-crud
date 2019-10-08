// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

//Recibe un json y regresa una nueva instancia del mismo
ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));
//Toma el modelo y lo genera en json
String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    String id;
    String titulo;
    double valor;
    bool disponible;
    String fotoUrl;

    ProductoModel({
        this.id,
        this.titulo = '',
        this.valor = 0.0,
        this.disponible = true,
        this.fotoUrl,
    });

    //Recibe un mapa
    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id          : json["id"],
        titulo      : json["titulo"],
        valor       : json["valor"],
        disponible  : json["disponible"],
        fotoUrl     : json["fotoUrl"],
    );

    //Al modelo, lo transforma a un json
    Map<String, dynamic> toJson() => {
       // "id"        : id,
        "titulo"    : titulo,
        "valor"     : valor,
        "disponible": disponible,
        "fotoUrl"   : fotoUrl,
    };
}
