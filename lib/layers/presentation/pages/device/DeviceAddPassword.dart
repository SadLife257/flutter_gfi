import 'package:flutter/material.dart';

class DeviceAddPassword extends StatefulWidget {
  const DeviceAddPassword({super.key});

  @override
  State<DeviceAddPassword> createState() => _DeviceAddPasswordState();
}

class _DeviceAddPasswordState extends State<DeviceAddPassword> {
  late final TextEditingController devicePasswordController;
  bool _isEmptyInput = true;
  bool _toggleObscurePassword = true;

  @override
  void initState() {
    devicePasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          extendBody: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            centerTitle: true,
            title: Text(
              'Connect to Device',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold
              ),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  size: 30,
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.primary,
                )
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Enter password for GFI - Thermostat v1.0",
                    style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 64),
                child: TextFormField(
                  controller: devicePasswordController,
                  obscureText: _toggleObscurePassword,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                  ),
                  decoration: InputDecoration(
                    labelText: 'Device Password',
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                    labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                    border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    suffix: !_isEmptyInput ? IconButton(
                        alignment: Alignment.topRight,
                        onPressed: () {
                          devicePasswordController.clear();
                          setState(() {
                            _isEmptyInput = !_isEmptyInput;
                          });
                        },
                        icon: const Icon(Icons.clear)
                    ) : null,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _toggleObscurePassword =
                            !_toggleObscurePassword;
                          });
                        },
                        icon: _toggleObscurePassword ? Icon(Icons.visibility, color: Theme.of(context).colorScheme.primary)
                            : Icon(Icons.visibility_off, color: Theme.of(context).colorScheme.primary)
                    )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your device password";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _isEmptyInput = value.isEmpty;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    minimumSize: Size.fromHeight(60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'ADD'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    minimumSize: Size.fromHeight(60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                      'CANCEL'
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
