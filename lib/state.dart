import 'package:gumball_state/machine.dart';
import 'package:gumball_state/utils.dart';

abstract class GumballState {
  final GumballMachine machine;

  GumballState(this.machine);

  void insertCoin();
  void ejectCoin();
  void turnCrank();
  void dispenseGumball();
}

class SoldState extends GumballState {
  SoldState(super.machine);

  @override
  void dispenseGumball() {
    machine.releaseGumball();
    if (machine.gumballsCount > 0) {
      showSnackBar(machine.context, 'Вы получили шарик');
      machine.setState(machine.noCoinState);
    } else {
      showSnackBar(machine.context, 'Шариков больше нет');
      machine.setState(machine.soldOutState);
    }
  }

  @override
  void ejectCoin() {
    showSnackBar(machine.context, 'Нет монеты для вывода');
  }

  @override
  void insertCoin() {
    showSnackBar(machine.context, 'Сначала заберите шарик');
  }

  @override
  void turnCrank() {
    showSnackBar(machine.context, 'Заберите шарик');
  }
}

class SoldOutState extends GumballState {
  SoldOutState(super.machine);

  @override
  void dispenseGumball() {
    showSnackBar(machine.context, 'Нет шариков');
  }

  @override
  void ejectCoin() {
    showSnackBar(machine.context, 'Нет шариков');
  }

  @override
  void insertCoin() {
    showSnackBar(machine.context, 'Нет шариков');
  }

  @override
  void turnCrank() {
    showSnackBar(machine.context, 'Нет шариков');
  }
}

class NoCoinState extends GumballState {
  NoCoinState(super.machine);

  @override
  void dispenseGumball() {
    showSnackBar(machine.context, 'Нет шарика для выдачи');
  }

  @override
  void ejectCoin() {
    showSnackBar(machine.context, 'Нет монеты');
  }

  @override
  void insertCoin() {
    machine.setState(machine.hasCoinState);
  }

  @override
  void turnCrank() {
    showSnackBar(machine.context, 'Нет монеты');
  }
}

class HasCoinState extends GumballState {
  HasCoinState(super.machine);

  @override
  void dispenseGumball() {
    showSnackBar(machine.context, 'Шариков нет для выдачи');
  }

  @override
  void ejectCoin() {
    machine.setState(machine.noCoinState);
    showSnackBar(machine.context, 'Вы вернули монету');
  }

  @override
  void insertCoin() {
    showSnackBar(machine.context, 'Нельзя вставить дополнительную монету');
  }

  @override
  void turnCrank() {
    machine.setState(machine.soldState);
    showSnackBar(machine.context, 'Вы дернули рычаг');
  }
}
