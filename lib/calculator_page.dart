import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController tipController = TextEditingController();

  String selectedCurrency = "\$";

  final List<String> currencies = [
    "\$ USD",
    "€ EUR",
    "£ GBP",
    "ل.ل LBP",
    "ر.س SAR",
    "د.إ AED",
  ];

  double finalPrice = 0;
  double discountAmount = 0;
  double priceAfterDiscount = 0;
  double tipAmount = 0;
  double totalSaved = 0;

  void calculate() {
    double price = double.tryParse(priceController.text) ?? 0;
    double discount = double.tryParse(discountController.text) ?? 0;
    double tip = double.tryParse(tipController.text) ?? 0;

    setState(() {
      discountAmount = (price * discount) / 100;
      priceAfterDiscount = price - discountAmount;
      tipAmount = (priceAfterDiscount * tip) / 100;
      finalPrice = priceAfterDiscount + tipAmount;
      totalSaved = discountAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Currency Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Currency",
                  border: OutlineInputBorder(),
                ),
                value: selectedCurrency,
                items: currencies.map((currency) {
                  return DropdownMenuItem(
                    value: currency.split(" ")[0], // symbol only
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Price Input
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Discount Input
              TextField(
                controller: discountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Discount (%)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Tip Input
              TextField(
                controller: tipController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Tip (%)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),

              // Calculate Button
              Center(
                child: ElevatedButton(
                  onPressed: calculate,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: Text("Calculate", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Results Section
              if (finalPrice > 0) ...[
                const Text(
                  "Results",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                Text("Discount Amount: $selectedCurrency${discountAmount.toStringAsFixed(2)}"),
                const SizedBox(height: 8),

                Text("Price After Discount: $selectedCurrency${priceAfterDiscount.toStringAsFixed(2)}"),
                const SizedBox(height: 8),

                Text("Tip Amount: $selectedCurrency${tipAmount.toStringAsFixed(2)}"),
                const SizedBox(height: 8),

                Text(
                  "Final Price: $selectedCurrency${finalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),

                Text("Total Saved: $selectedCurrency${totalSaved.toStringAsFixed(2)}"),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
