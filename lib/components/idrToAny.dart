import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rex_currency_app/functions/fetch_api.dart';

class IdrToAny extends StatefulWidget {
  final rate;
  final Map currency;
  const IdrToAny({Key? key, @required this.rate, required this.currency})
      : super(key: key);

  @override
  State<IdrToAny> createState() => _IdrToAnyState();
}

class _IdrToAnyState extends State<IdrToAny> {
  TextEditingController idrController = TextEditingController();
  String dropdownValue = 'USD';
  String resultConv = 'Converted Currency';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'IDR to Any Currency',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              key: const Key('idr'),
              controller: idrController,
              cursorColor: Colors.white,
              style: GoogleFonts.nunito(
                // fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter IDR Amount',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.grey.shade900,
                    value: dropdownValue,
                    style: GoogleFonts.nunito(
                      // fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.white,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: widget.currency.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (widget.rate != null) {
                          resultConv = idrController.text +
                              'USD    =     ' +
                              convertIdr(widget.rate, idrController.text,
                                  dropdownValue) +
                              dropdownValue;
                        } else {
                          // Tampilkan pesan error atau nilai default jika widget.rate bernilai null
                          resultConv = 'Terjadi kesalahan dalam mengambil data';
                        }
                      });
                    },
                    child: Text(
                      'Convert',
                      style: GoogleFonts.nunito(
                        // fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (state) => Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              child: Text(
                resultConv,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
