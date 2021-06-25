import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/providers/product.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shop/core/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _form2 = GlobalKey<FormBuilderState>();
  var _isLoading = false;
  var _initializated = false;
  var _productData =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initializated) {
      Timer(Duration(seconds: 0), () {
        if (_form2.currentState != null) {
          _initializated = true;
          Product _routeProduct = ModalRoute.of(context).settings.arguments;
          if (_routeProduct != null) {
            setState(() {
              print(_routeProduct.toJson());
              _productData = _routeProduct.copyWith();
              print(_productData.toJson());
              _form2.currentState?.patchValue({
                ..._routeProduct.toJson(),
                'price': _routeProduct.price.toString()
              });
            });
          }
        }
      });
    }
  }

  void _onSave() async {
    if (_form2.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      _form2.currentState.save();
      final value = _form2.currentState.value;
      final newProduct = Product(
          id: _productData.id ?? DateTime.now().toIso8601String(),
          title: value['title'],
          description: value['description'],
          price: double.parse(value['price']),
          imageUrl: value['imageUrl']);
      try {
        if (_productData.id != null) {
          setState(() {
            _isLoading = true;
          });
          await Provider.of<ProductsProvider>(context, listen: false)
              .updateProduct(newProduct);
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
          return;
        }
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProcuct(newProduct);
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print(e);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Error'),
                  content: Text('Something went wrong'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'))
                  ],
                ));
      }
    }
  }

  String get _imageUrl {
    return (_form2?.currentState?.fields ?? const {})['imageUrl']?.value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    print('Build');
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit product'),
          actions: [
            IconButton(
                onPressed: () {
                  _onSave();
                },
                icon: Icon(Icons.save))
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    FormBuilder(
                      key: _form2,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              name: 'title',
                              decoration: InputDecoration(
                                labelText: 'Title',
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.minLength(context, 3)
                              ]),
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FormBuilderTextField(
                              textInputAction: TextInputAction.next,
                              name: 'price',
                              decoration: InputDecoration(
                                labelText: 'Price',
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.numeric(context),
                                FormBuilderValidators.min(context, 0.1),
                              ]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FormBuilderTextField(
                              textInputAction: TextInputAction.next,
                              name: 'description',
                              decoration: InputDecoration(
                                labelText: 'Description',
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(top: 8, right: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: _imageUrl.isEmpty
                                      ? Text(
                                          'Enter an url',
                                          textAlign: TextAlign.center,
                                        )
                                      : FittedBox(
                                          child: Image.network(
                                            _imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                                Expanded(
                                  child: FormBuilderTextField(
                                    name: 'imageUrl',
                                    decoration:
                                        InputDecoration(labelText: 'Image url'),
                                    keyboardType: TextInputType.url,
                                    textInputAction: TextInputAction.done,
                                    onEditingComplete: () {
                                      setState(() {});
                                    },
                                    onSubmitted: (_) {
                                      _onSave();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }
}
