import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as myhttp;
import '../models/province.dart';
import '../models/city.dart';

class HomePage extends StatelessWidget {
  // API Key
  final String apiKey =
      "1621ebb772814b171e424f6c92821d6dac9706c8642aec22c2bd5c074ead0eeb";

  // Deklarasikan id provinsi, untuk pencarian kota
  String? idProv;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown API"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          // Dropdown Provinsi, nama <Provinsi> dari model
          DropdownSearch<Province>(
            mode: Mode.DIALOG,
            showSearchBox: true,
            showClearButton: true,

            // Jika dipilih, isi variable idProv dengan id provinsi terpilih
            onChanged: (value) => idProv = value?.id,

            // Custom tampilan hasil dropdown saat tidak memunculkan list data
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.name ?? "Belum Pilih Provinsi"),

            // Custom tampilan list/data
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: Text(item.name),
            ),

            // Ambil Data Ke API
            onFind: (text) async {
              var response = await myhttp.get(Uri.parse(
                  "https://api.binderbyte.com/wilayah/provinsi?api_key=$apiKey"));

              if (response.statusCode != 200) {
                return [];
              }

              List allProvince =
                  (json.decode(response.body) as Map<String, dynamic>)["value"];

              List<Province> allModelProvince = [];

              allProvince.forEach((element) {
                allModelProvince.add(Province(
                  id: element['id'],
                  name: element['name'],
                ));
              });

              return allModelProvince;
            },
          ),

          SizedBox(height: 10),

          // Dropdown Kota
          DropdownSearch<City>(
            mode: Mode.DIALOG,
            showSearchBox: true,
            showClearButton: true,

            // Jika dipilih, lakukan sesuatu, ini hanya contoh print isi di debug (harusnya bisa di ganti perintah lain)
            onChanged: (value) => print(value),

            // Custom tampilan dropdown awal/saat telah dipilih
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.name ?? "Belum Pilih Kota"),

            // Custom tampilan list data
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: Text(item.name),
            ),

            // Panggil data kota dari API
            onFind: (text) async {
              var response = await myhttp.get(Uri.parse(
                  "https://api.binderbyte.com/wilayah/kabupaten?api_key=$apiKey&id_provinsi=$idProv"));

              if (response.statusCode != 200) {
                return [];
              }

              List allCity =
                  (json.decode(response.body) as Map<String, dynamic>)["value"];

              List<City> allModelCity = [];

              allCity.forEach((element) {
                allModelCity.add(City(
                  id: element['id'],
                  idProvinsi: element['id_provinsi'],
                  name: element['name'],
                ));
              });

              return allModelCity;
            },
          ),
        ],
      ),
    );
  }
}
