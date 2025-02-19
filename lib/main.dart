import 'package:flutter/material.dart';
import 'package:gumball_state/machine.dart';
import 'package:gumball_state/state.dart';

void main() {
  runApp(const GumballMachineApp());
}

class GumballMachineApp extends StatelessWidget {
  const GumballMachineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gumball Machine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GumballMachineScreen(),
    );
  }
}

class GumballMachineScreen extends StatefulWidget {
  const GumballMachineScreen({super.key});

  @override
  GumballMachineScreenState createState() => GumballMachineScreenState();
}

class GumballMachineScreenState extends State<GumballMachineScreen> {
  late final GumballMachine machine;

  @override
  void initState() {
    machine = GumballMachine(context, 5);
    super.initState();
  }

  void insertCoin() {
    machine.insertCoin();
    setState(() {});
  }

  void turnCrank() {
    machine.turnCrank();
    setState(() {});
  }

  void dispenseGumball() {
    machine.dispenseGumball();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Аппарат для жевательной резинки'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.monetization_on,
              size: 100,
              color: (machine.state is HasCoinState) ? Colors.yellow : Colors.grey,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: insertCoin,
              child: const Text('Вставить монету'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: turnCrank,
              child: const Text('Потянуть рычаг'),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: dispenseGumball,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: machine.state is SoldState ? Colors.red : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Осталось шариков: ${machine.gumballsCount}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
