import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  List<Map<String, dynamic>> dataList = [
    {
      "country": "Brazil",
      "id": 1,
    },
    {
      "country": "Italia",
      "id": 2,
    },
    {
      "country": "Tunisia",
      "id": 3,
    },
    {
      "country": "Canada",
      "id": 4,
    },
    {
      "country": "Indonesia",
      "id": 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: DropdownSearch<Map<String, dynamic>>(
          // Mode.MENU, Mode.DIALOG, Mode.BOTTOM_SHEET
          mode: Mode.MENU,

          items: dataList,

          // saat dipilih otomatis yang di print/ambil adalah ID nya
          onChanged: (value) => print(value?['id'] ?? "NULL"),

          // Default yang terpilih
          selectedItem: {
            "country": "Brazil",
            "id": 1,
          },

          // icon silang untuk hapus yang sudah terpilih
          showClearButton: true,

          // inputan pencarian untuk membantu memudahkan pencarian
          showSearchBox: true,

          // Untuk custom / mempercantik tampilan list data
          popupItemBuilder: (context, item, isSelected) => ListTile(
            textColor: Colors.purple[900],
            title: Text(item['country'].toString()),
            subtitle: Text("negara@mail.com"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://picsum.photos/id/${238 + item['id']}/200/300"),
            ), // bisa juga icon
          ),

          // Yang tampil di layar hanya nama negara
          dropdownBuilder: (context, selectedItem) =>
              Text(selectedItem?['country'].toString() ?? "Belum pilih Negara"),
        ),
      ),
    );
  }
}
