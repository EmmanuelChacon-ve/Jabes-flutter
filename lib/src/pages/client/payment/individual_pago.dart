import 'package:jabes/src/pages/client/payment/payment_controller.dart';
import './payment_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

//variable global
XFile? imagenGlobal;

//
class PagoIndividual extends StatelessWidget {
  //imagen a mostrar en el principio de la vista
  final String imagen;
  final String nombre;
  final String logo;
  PagoIndividual(
      {Key? key,
      this.imagen = "asset/img/no-image.png",
      this.nombre = 'Ah ocurrido un error',
      this.logo = 'asset/img/no-image.png'})
      : super(key: key);

  final PaymentController _paymentController = PaymentController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PrincipalContainer(
        hijo: HijoContainer(
          imagen: imagen,
          logo: logo,
          nombre: nombre,
          paymentController: _paymentController,
        ),
      ),
    );
  }
}

class HijoContainer extends StatefulWidget {
  final String imagen;
  final String nombre;
  final String logo;
  final PaymentController paymentController;

  const HijoContainer({
    Key? key,
    required this.imagen,
    required this.nombre,
    required this.logo,
    required this.paymentController,
  }) : super(key: key);

  @override
  _HijoContainerState createState() => _HijoContainerState();
}

class _HijoContainerState extends State<HijoContainer> {
  XFile? selectImage;
  final TextEditingController numericInputController = TextEditingController();
  String numericInputValue = '';

  @override
  void dispose() {
    numericInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      heightFactor: 0.96,
      child: OverflowBox(
        alignment: Alignment.topCenter,
        maxHeight: MediaQuery.of(context).size.height - 110,
        child: Padding(
          // Agregamos el Padding al HijoContainer
          padding: const EdgeInsets.all(
              //si se encuentra overflow corregir este padding
              0.0), // Espacio de 16 puntos en todos los lados
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // Aquí manejamos el botón de regresar
                  Navigator.pushNamed(context, 'client/payment/paymentMethods');
                },
                child: const Text(
                  'Regresar',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.imagen),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              ModuloLogos(logo: widget.logo, tipoPago: widget.nombre),
              const ModuloPagos(),
              NumericInput(
                  controller: numericInputController,
                  onChanged: (value) {
                    setState(() {
                      numericInputValue = value;
                    });
                  }),
              const ModuloOrganizacion(),
              const ContainerFoto(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GreenContainer(
                    container: 'Completar',
                    width: 300,
                    height: 60,
                    onPressed: () {
                      widget.paymentController.onCompleteButtonPressed(
                          context, numericInputValue, imagenGlobal);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModuloLogos extends StatelessWidget {
  final String logo;
  final String tipoPago;
  ModuloLogos({super.key, required this.logo, required this.tipoPago});
  final String nombre = 'jabes';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage(logo),
        ),
        GreenContainer(
          container: tipoPago,
          width: 270,
          height: 40,
        ),
      ],
    );
  }
}

class ModuloPagos extends StatelessWidget {
  const ModuloPagos({Key? key});
  final String jabes = 'jabes';
  final String cuenta = 'weaesdfghvjb';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: GestureDetector(
        onTap: () {
          Clipboard.setData(ClipboardData(text: cuenta));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cuenta copiada al portapapeles')),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enviar a',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Nombre: $jabes',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  'Cuenta: $cuenta',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.copy_rounded,
                  color: Color.fromARGB(255, 83, 202, 86),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NumericInput extends StatefulWidget {
  TextEditingController controller;
  final void Function(String value) onChanged;
  NumericInput({Key? key, required this.controller, required this.onChanged})
      : super(key: key);
  @override
  _NumericInputState createState() => _NumericInputState();
}

class _NumericInputState extends State<NumericInput> {
  // final TextEditingController _controller = TextEditingController();
  String _selectedCurrency = 'USD'; // Moneda seleccionada inicialmente

  //funcion para obtener el dinero donado
  String getAmount() {
    return widget.controller.text;
  }

  //

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 108, 53, 0.61),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Center(
              child: Text(
                'Monto a contribuir:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16), // Espacio vertical de 16 puntos
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24, // Aumenta el tamaño de fuente a 24
                  ),
                  onChanged: (value) {
                    widget.onChanged(value);
                  },
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _selectedCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCurrency = newValue!;
                  });
                },
                dropdownColor: const Color.fromRGBO(0, 108, 53, 0.61),
                focusColor: Colors.transparent,
                items: <String>['USD', 'EUR', 'JPY', 'GBP', 'AUD']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ModuloOrganizacion extends StatelessWidget {
  const ModuloOrganizacion({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE dd/MM/yyyy', 'es');
    final formattedDate = formatter.format(now);

    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Column(
        children: [
          const GreenContainer(
            //implementar cuando la persona ya haya seleccionado una organizacion
            container: 'Christian Science Latam',
            height: 40,
          ),
          GreenContainer(
            container: formattedDate,
            height: 40,
          ),
        ],
      ),
    );
  }
}

class GreenContainer extends StatelessWidget {
  final String container;
  final double? width;
  final double? height;
  //para manejar eventos onPressed
  final VoidCallback? onPressed;

  const GreenContainer(
      {Key? key,
      required this.container,
      this.width,
      this.height,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width:
            width, // Utiliza el width proporcionado o toma el ancho disponible si width es nulo
        height:
            height, // Utiliza el height proporcionado o toma el alto disponible si height es nulo
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 108, 53, 0.61),
          borderRadius: BorderRadius.circular(15),
        ),
        child: MaterialButton(
          onPressed: onPressed, // Asignamos la función onPressed al botón
          child: Align(
            alignment: Alignment.center,
            child: Text(
              container,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContainerFoto extends StatefulWidget {
  const ContainerFoto({Key? key});

  @override
  State<ContainerFoto> createState() => _ContainerFotoState();
}

class _ContainerFotoState extends State<ContainerFoto> {
  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
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
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            BotonImagen(
              onImageSelected: (XFile? image) {
                setState(() {
                  selectedImage = image;
                  imagenGlobal = selectedImage;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BotonImagen extends StatefulWidget {
  final void Function(XFile?)
      onImageSelected; // Callback function to handle the selected image

  const BotonImagen({Key? key, required this.onImageSelected})
      : super(key: key);

  @override
  _BotonImagenState createState() => _BotonImagenState();
}

class _BotonImagenState extends State<BotonImagen> {
  bool _isUploading = false;

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imagenGlobal = image;
    });

    widget.onImageSelected(
        image); // Pass the selected XFile to the callback function
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isUploading ? null : () => _pickImageFromGallery(context),
      child: GreenContainer(
        container: imagenGlobal != null ? 'Subido' : 'Subir',
        width: 180,
        height: 45,
      ),
    );
  }
}
