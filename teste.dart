void main(List<String> args) {
  var hoje = DateTime.now();
  double ano = hoje.year * 3.154e10;
  double mes = hoje.month * 2.628e9;
  double dia = hoje.day * 8.64e7;
  double hora = hoje.hour * 3.6e6;
  double minuto = hoje.minute * 60000;
  double segundos = hoje.second * 1000;
  int millissegundos = hoje.millisecond;

  print(ano+mes+dia+hora+minuto+segundos+millissegundos);
}
