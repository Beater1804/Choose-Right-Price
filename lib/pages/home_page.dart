import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductInfo {
  final String name;
  final double price;

  ProductInfo(this.name, this.price);
}

final products = [
  ProductInfo('Chuột bluetooth', 3),
  ProductInfo('Gà', 4),
  ProductInfo('Vịt', 5),
  ProductInfo('Heo bluetooth', 6),
  ProductInfo('Bò bluetooth', 7),
  ProductInfo('Nai bluetooth', 8),
  ProductInfo('hep', 9),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _indexProduct = 0;
  int? _inputPrice;
  String _result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(products[_indexProduct].name),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextField(
                    key: const Key('priceInput'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (val) {
                      _inputPrice = int.tryParse(val);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _result = _inputPrice == products[_indexProduct].price
                            ? 'pass'
                            : 'fail';
                      });
                    },
                    child: const Text('Kiểm tra'),
                  ),
                ),
                Visibility(
                  visible: _result.isNotEmpty,
                  child: Text(
                    _result,
                    key: const Key('resultStatus'),
                  ),
                ),
                Visibility(
                  visible: _result.isNotEmpty,
                  child: ElevatedButton(
                    child: const Text('Tiếp tục'),
                    onPressed: () {
                      setState(() {
                        _result = '';
                        if (_indexProduct < 6) {
                          _indexProduct++;
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
