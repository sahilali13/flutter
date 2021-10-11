import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = ProductProvider(
    description: '',
    id: '',
    imageUrl: '',
    price: 0.0,
    title: '',
  );

  @override
  void initState() {
    _imageUrlController.addListener(() {
      _updateImageUrl;
    });
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https') ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('jpg') &&
              !_imageUrlController.text.endsWith('jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final _isValid = _form.currentState!.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Product',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  autocorrect: true,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onSaved: (_value) {
                    _editedProduct = ProductProvider(
                      description: _editedProduct.description,
                      id: _editedProduct.id,
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price,
                      title: _value as String,
                    );
                  },
                  validator: (_value) {
                    if (_value!.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autocorrect: true,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onSaved: (_value) {
                    _editedProduct = ProductProvider(
                      description: _editedProduct.description,
                      id: _editedProduct.id,
                      imageUrl: _editedProduct.imageUrl,
                      price: _value as double,
                      title: _editedProduct.title,
                    );
                  },
                  validator: (_value) {
                    if (_value!.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(_value) == null) {
                      return 'Please enter a valid number';
                    }
                    if (double.parse(_value) <= 0) {
                      return 'Please enter a number greater than zero.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autocorrect: true,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Description'),
                  textInputAction: TextInputAction.next,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onSaved: (_value) {
                    _editedProduct = ProductProvider(
                      description: _value as String,
                      id: _editedProduct.id,
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price,
                      title: _editedProduct.title,
                    );
                  },
                  validator: (_value) {
                    if (_value!.isEmpty) {
                      return 'Please enter a description.';
                    }
                    if (_value.length < 10) {
                      return 'Should be atleast 10 characters long';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.contain,
                            ),
                    ),
                    Expanded(
                        child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onFieldSubmitted: (_) => _saveForm(),
                      onSaved: (_value) {
                        _editedProduct = ProductProvider(
                          description: _editedProduct.description,
                          id: _editedProduct.id,
                          imageUrl: _value as String,
                          price: _editedProduct.price,
                          title: _editedProduct.title,
                        );
                      },
                      validator: (_value) {
                        if (_value!.isEmpty) {
                          return 'Please enter an image URL.';
                        }
                        if (!_value.startsWith('http') &&
                            !_value.startsWith('https')) {
                          return 'Please enter a valid URL';
                        }
                        if (!_value.endsWith('.png') &&
                            !_value.endsWith('jpg') &&
                            !_value.endsWith('jpeg')) {
                          return 'Please enter a valid image URL.';
                        }
                        return null;
                      },
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
