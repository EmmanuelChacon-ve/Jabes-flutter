import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabes/src/pages/client/payment/individual_pago.dart';
import 'package:jabes/src/pages/client/payment/payment_controller_other.dart';

class ContainerFoto extends StatefulWidget {
  final BienesContenidoController controller;
  const ContainerFoto({super.key, required this.controller});

  @override
  State<ContainerFoto> createState() => _ContainerFotoState();
}

class _ContainerFotoState extends State<ContainerFoto> {
  XFile? selectedImage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(217, 217, 217, 1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Adjuntar captura de pantalla',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            BotonImagen(
              controller: widget.controller,
              onImageSelected: (XFile? image) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BotonImagen extends StatefulWidget {
  final BienesContenidoController controller;
  final void Function(XFile?)
      onImageSelected; // Callback function to handle the selected image

  const BotonImagen(
      {Key? key, required this.onImageSelected, required this.controller})
      : super(key: key);

  @override
  _BotonImagenState createState() => _BotonImagenState();
}

class _BotonImagenState extends State<BotonImagen> {
  bool _isUploading = false;

  Future<void> _pickImageFromGallery(
      BuildContext context, BienesContenidoController controller) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      controller.selectedImage = image;
    });

    widget.onImageSelected(
        image); // Pass the selected XFile to the callback function
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isUploading
          ? null
          : () => _pickImageFromGallery(context, widget.controller),
      child: GreenContainer(
        container: widget.controller.selectedImage != null ? 'Subido' : 'Subir',
        width: 180,
        height: 45,
      ),
    );
  }
}
