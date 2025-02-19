import 'package:flutter/material.dart';
import 'package:gumball_state/state.dart';

class GumballMachine {
  int gumballsCount;

  late final GumballState soldOutState;
  late final GumballState soldState;
  late final GumballState noCoinState;
  late final GumballState hasCoinState;

  late GumballState state;

  BuildContext context;

  GumballMachine(this.context, this.gumballsCount) {
    soldOutState = SoldOutState(this);
    soldState = SoldState(this);
    noCoinState = NoCoinState(this);
    hasCoinState = HasCoinState(this);
    if (gumballsCount > 0) {
      state = noCoinState;
    } else {
      state = soldOutState;
    }
  }

  void insertCoin() {
    state.insertCoin();
  }

  void ejectCoin() {
    state.ejectCoin();
  }

  void turnCrank() {
    state.turnCrank();
  }

  void dispenseGumball() {
    state.dispenseGumball();
  }

  void releaseGumball() {
    gumballsCount--;
  }

  void setState(GumballState newState) {
    state = newState;
  }
}
