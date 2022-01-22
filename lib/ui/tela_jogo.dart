import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:cobras_e_escadas/cobras_escadas.dart';

class CobrasEscadas extends StatefulWidget {
  const CobrasEscadas({Key? key}) : super(key: key);

  @override
  _CobrasEscadasState createState() => _CobrasEscadasState();
}

class _CobrasEscadasState extends State<CobrasEscadas> {
  @override
  int casaJogador1 = 0;
  int casaJogador2 = 0;
  int dado1 = 0;
  int dado2 = 0;
  bool vezJogador1 = true;
  var _random = new Random();
  String jogadorDaVez = "Jogador 1";
  String textodemensagem = "";
  bool podeJogar = true;
  var cordofundo = Colors.blue;
  bool repete1 = false;
  bool repete2 = false;

  Widget build(BuildContext context) {
    double TelaEixoX = MediaQuery.of(context).size.width;
    double TelaEixoY = MediaQuery.of(context).size.height;
    double AlturaBarra = TelaEixoX * 0.15;
    double RestanteDaTelaY =
        ((((TelaEixoX / TelaEixoY) - 1) * -1) * TelaEixoY) - TelaEixoX * 0.15;

    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
            height: AlturaBarra,
            width: TelaEixoX,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              color: cordofundo,
              child: Row(
                children: [
                  SizedBox(
                    height: AlturaBarra,
                    width: AlturaBarra,
                    child: Image.asset("assets/images/avatar.jpg"),
                  ),
                  Text("$jogadorDaVez")
                ],
              ),
            )),
        Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    height: TelaEixoX,
                    width: TelaEixoX,
                    child: Image.asset(
                      "assets/images/tabuleiro.jpeg",
                      fit: BoxFit.fill,
                    )),
              ],
            ),
          ],
        ),
        SizedBox(
          height: RestanteDaTelaY,
          width: TelaEixoX,
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(
                  height: RestanteDaTelaY,
                  width: TelaEixoX / 2,
                  child: Container(
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.black),
                          child: Text(
                            TextoJogador1(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          child: Text(
                            TextoJogador2(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: RestanteDaTelaY,
                  width: TelaEixoX / 2,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    color: cordofundo,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                            child: Text("Rolar os Dados 🎲"),
                            disabledColor: Colors.black,
                            color: Colors.green,
                            onPressed:
                                podeJogar == false ? null : () => RolarDados()),
                        Column(
                          children: [
                            Text("Dado 1: $dado1"),
                            Text("Dado 2: $dado2"),
                          ],
                        ),
                        Text(
                          "$textodemensagem",
                          textAlign: TextAlign.center,
                        ),
                        Text("Quem joga: $jogadorDaVez"),
                        SizedBox(
                          height: 30,
                          width: 70,
                          child: RaisedButton(
                              child: Text(
                                "Resetar",
                                style: TextStyle(fontSize: 10),
                              ),
                              disabledColor: Colors.black,
                              color: Colors.white,
                              onPressed: () => setState(() {
                                    ResetaJogo();
                                  })),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  String TextoJogador1() {
    String textojogador1casa = "O Jogador 1\nestá na Casa $casaJogador1";
    setState(() {
      textojogador1casa = "O Jogador 1\nestá na Casa $casaJogador1";
    });
    return textojogador1casa;
  }

  String TextoJogador2() {
    String textojogador2casa = "O Jogador 2\nestá na Casa $casaJogador2";
    setState(() {
      textojogador2casa = "O Jogador 2\nestá na Casa $casaJogador2";
    });
    return textojogador2casa;
  }

  Future<void> RolarDados() async {
    setState(() {
      podeJogar == false;
      dado1 = _random.nextInt(6) + 1;
      dado2 = _random.nextInt(6) + 1;
      Future.delayed(Duration(milliseconds: 300), () {
        AndarCasa();
        VezJogador();
        setState(() {
          if (vezJogador1 == true) {
            cordofundo = Colors.blue;
          } else if (vezJogador1 == false) {
            cordofundo = Colors.red;
          }
        });
        podeJogar == true;
      });
    });
  }

  void VezJogador() {
    if (vezJogador1 == true && repete1 == false) {
      jogadorDaVez = "Jogador 1";
    } else if (vezJogador1 == true && repete1 == true) {
      jogadorDaVez = "Jogador 1 de novo";
      repete1 = false;
    } else if (vezJogador1 == false && repete2 == false) {
      jogadorDaVez = "Jogador 2";
    } else if (vezJogador1 == false && repete2 == true) {
      jogadorDaVez = "Jogador 2 de novo";
      repete2 = false;
    }
  }

  void AndarCasa() {
    if (vezJogador1 == true) {
      if (dado1 == dado2) {
        repete1 = true;
        casaJogador1 = casaJogador1 + dado2 + dado1;
        vezJogador1 = true;

        //   jogadorDaVez = "Jogador 1 de novo";
      } else {
        casaJogador1 = casaJogador1 + dado2 + dado1;
        vezJogador1 = false;
        //  jogadorDaVez = "Jogador 2";
      }
    } else if (vezJogador1 == false) {
      if (dado1 == dado2) {
        repete2 = true;
        casaJogador2 = casaJogador1 + dado2 + dado1;
        vezJogador1 = false;
        //  jogadorDaVez = "Jogador 2 de novo";
      } else {
        casaJogador2 = casaJogador2 + dado2 + dado1;
        vezJogador1 = true;
        // jogadorDaVez = "Jogador 1";
      }
    }

    setState(() {
      casaJogador1;
      casaJogador2;
      Escadas_Sobe_Cobras_Desce();
    });
  }

  void Escadas_Sobe_Cobras_Desce() {
    setState(() {
      //JOGADOR 1
      if (casaJogador1 == 2) {
        casaJogador1 = 38;
        textodemensagem = "Jogador 1 sobe para a casa 38.";
      } else if (casaJogador1 == 7) {
        casaJogador1 = 14;
        textodemensagem = "Jogador 1 sobe para a casa 14.";
      } else if (casaJogador1 == 8) {
        casaJogador1 = 31;
        textodemensagem = "Jogador 1 sobe para a casa 31.";
      } else if (casaJogador1 == 15) {
        casaJogador1 = 26;
        textodemensagem = "Jogador 1 sobe para a casa 26.";
      } else if (casaJogador1 == 21) {
        casaJogador1 = 42;
        textodemensagem = "Jogador 1 sobe para a casa 42.";
      } else if (casaJogador1 == 28) {
        casaJogador1 = 84;
        textodemensagem = "Jogador 1 sobe para a casa 84.";
      } else if (casaJogador1 == 36) {
        casaJogador1 = 44;
        textodemensagem = "Jogador 1 sobe para a casa 44.";
      } else if (casaJogador1 == 51) {
        casaJogador1 = 67;
        textodemensagem = "Jogador 1 sobe para a casa 67.";
      } else if (casaJogador1 == 71) {
        casaJogador1 = 91;
        textodemensagem = "Jogador 1 sobe para a casa 91.";
      } else if (casaJogador1 == 78) {
        casaJogador1 = 98;
        textodemensagem = "Jogador 1 sobe para a casa 98.";
      } else if (casaJogador1 == 87) {
        casaJogador1 = 94;
        textodemensagem = "Jogador 1 sobe para a casa 94.";
      } else if (casaJogador1 == 16) {
        casaJogador1 = 6;
        textodemensagem = "Jogador 1 desce para a casa 6.";
      } else if (casaJogador1 == 46) {
        casaJogador1 = 25;
        textodemensagem = "Jogador 1 desce para a casa 25.";
      } else if (casaJogador1 == 49) {
        casaJogador1 = 11;
        textodemensagem = "Jogador 1 desce para a casa 11.";
      } else if (casaJogador1 == 62) {
        casaJogador1 = 19;
        textodemensagem = "Jogador 1 desce para a casa 19.";
      } else if (casaJogador1 == 64) {
        casaJogador1 = 60;
        textodemensagem = "Jogador 1 desce para a casa 60.";
      } else if (casaJogador1 == 74) {
        casaJogador1 = 53;
        textodemensagem = "Jogador 1 desce para a casa 53.";
      } else if (casaJogador1 == 89) {
        casaJogador1 = 68;
        textodemensagem = "Jogador 1 desce para a casa 68.";
      } else if (casaJogador1 == 92) {
        casaJogador1 = 88;
        textodemensagem = "Jogador 1 desce para a casa 88.";
      } else if (casaJogador1 == 95) {
        casaJogador1 = 75;
        textodemensagem = "Jogador 1 desce para a casa 75.";
      } else if (casaJogador1 == 99) {
        casaJogador1 = 80;
        textodemensagem = "Jogador 1 desce para a casa 80.";
      } else if (casaJogador1 > 100) {
        //ULTRAPASSA 100
        int volta1 = casaJogador1 - 100;
        casaJogador1 = 100 - volta1;
        textodemensagem = volta1 == 1
            ? "O Jogador 1 ultrapassou a casa 100.\n Precisou voltar ${volta1} casa."
            : "O Jogador 1 ultrapassou a casa 100.\n Precisou voltar ${volta1} casas.";
      } else if (casaJogador1 == 100) {
        //VENCE O JOGO
        VenceOJogo1();
      } else {
        //ZERA A MENSAGEM
        textodemensagem = "";
      }

      if (casaJogador2 == 2) {
        casaJogador2 = 38;
        textodemensagem = "Jogador 2 sobe para a casa 38.";
      } else if (casaJogador2 == 7) {
        casaJogador2 = 14;
        textodemensagem = "Jogador 2 sobe para a casa 14.";
      } else if (casaJogador2 == 8) {
        casaJogador2 = 31;
        textodemensagem = "Jogador 2 sobe para a casa 31.";
      } else if (casaJogador2 == 15) {
        casaJogador2 = 26;
        textodemensagem = "Jogador 2 sobe para a casa 26.";
      } else if (casaJogador2 == 21) {
        casaJogador2 = 42;
        textodemensagem = "Jogador 2 sobe para a casa 42.";
      } else if (casaJogador2 == 28) {
        casaJogador2 = 84;
        textodemensagem = "Jogador 2 sobe para a casa 84.";
      } else if (casaJogador2 == 36) {
        casaJogador2 = 44;
        textodemensagem = "Jogador 2 sobe para a casa 44.";
      } else if (casaJogador2 == 51) {
        casaJogador2 = 67;
        textodemensagem = "Jogador 2 sobe para a casa 67.";
      } else if (casaJogador2 == 71) {
        casaJogador2 = 91;
        textodemensagem = "Jogador 2 sobe para a casa 91.";
      } else if (casaJogador2 == 78) {
        casaJogador2 = 98;
        textodemensagem = "Jogador 2 sobe para a casa 98.";
      } else if (casaJogador2 == 87) {
        casaJogador2 = 94;
        textodemensagem = "Jogador 2 sobe para a casa 94.";
      } else if (casaJogador2 == 16) {
        casaJogador2 = 6;
        textodemensagem = "Jogador 2 desce para a casa 6.";
      } else if (casaJogador2 == 46) {
        casaJogador2 = 25;
        textodemensagem = "Jogador 2 desce para a casa 25.";
      } else if (casaJogador2 == 49) {
        casaJogador2 = 11;
        textodemensagem = "Jogador 2 desce para a casa 11.";
      } else if (casaJogador2 == 62) {
        casaJogador2 = 19;
        textodemensagem = "Jogador 2 desce para a casa 19.";
      } else if (casaJogador2 == 64) {
        casaJogador2 = 60;
        textodemensagem = "Jogador 2 desce para a casa 60.";
      } else if (casaJogador2 == 74) {
        casaJogador2 = 53;
        textodemensagem = "Jogador 2 desce para a casa 53.";
      } else if (casaJogador2 == 89) {
        casaJogador2 = 68;
        textodemensagem = "Jogador 2 desce para a casa 68.";
      } else if (casaJogador2 == 92) {
        casaJogador2 = 88;
        textodemensagem = "Jogador 2 desce para a casa 88.";
      } else if (casaJogador2 == 95) {
        casaJogador2 = 75;
        textodemensagem = "Jogador 2 desce para a casa 75.";
      } else if (casaJogador2 == 99) {
        casaJogador2 = 80;
        textodemensagem = "Jogador 2 desce para a casa 80.";
      } else if (casaJogador2 > 100) {
        //ULTRAPASSA 100
        int volta1 = casaJogador2 - 100;
        casaJogador2 = 100 - volta1;
        textodemensagem = volta1 == 1
            ? "O Jogador 2 ultrapassou a casa 100.\n Precisou voltar ${volta1} casa."
            : "O Jogador 2 ultrapassou a casa 100.\n Precisou voltar ${volta1} casas.";
      } else if (casaJogador2 == 100) {
        //VENCE O JOGO
        VenceOJogo2();
      } else {
        //ZERA A MENSAGEM
        textodemensagem = "";
      }
    });
  }

  void VenceOJogo2() {
    AlertDialog alerta = AlertDialog(
      title: Text("JOGO FINALIZADO"),
      content: Text("Parabéns! Jogador 2 venceu o jogo!"),
      actions: [],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        });

    setState(() {
      ResetaJogo();
    });
  }

  void VenceOJogo1() {
    AlertDialog alerta = AlertDialog(
      title: Text("JOGO FINALIZADO"),
      content: Text("Parabéns! Jogador 1 venceu o jogo!"),
      actions: [],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        });

    setState(() {
      ResetaJogo();
    });
  }

  void ResetaJogo() {
    casaJogador1 = 0;
    casaJogador2 = 0;
    dado1 = 0;
    dado2 = 0;
    vezJogador1 = true;
    jogadorDaVez = "Jogador 1";
    textodemensagem = "";
    podeJogar = true;
    cordofundo = Colors.blue;
    repete1 = false;
    repete2 = false;
  }
}
