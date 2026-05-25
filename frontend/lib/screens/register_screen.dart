import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nombreCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  late Future<List<dynamic>> pespData;

  @override
  void initState() {
    super.initState();
    pespData = ApiService.getPesp();
  }

  void save() async {
    await ApiService.createPesp({
      "nombre": nombreCtrl.text,
      "descripcion": descCtrl.text,
    });

    setState(() {
      pespData = ApiService.getPesp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro PESP")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(controller: nombreCtrl, decoration: InputDecoration(labelText: "Nombre")),
                TextField(controller: descCtrl, decoration: InputDecoration(labelText: "Descripción")),
                SizedBox(height: 10),
                ElevatedButton(onPressed: save, child: Text("Guardar")),
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: pespData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final data = snapshot.data as List;

                return SingleChildScrollView(
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text("Nombre")),
                      DataColumn(label: Text("Descripción")),
                    ],
                    rows: data.map((item) {
                      return DataRow(cells: [
                        DataCell(Text(item['nombre'])),
                        DataCell(Text(item['descripcion'])),
                      ]);
                    }).toList(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}