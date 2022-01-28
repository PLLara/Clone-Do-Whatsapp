// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/1_initial_screen/global/location_state.dart';

class CountryCodeSelector extends StatefulWidget {
  final List<Location> locations;
  final Function(Location) onSelectCountry;
  
  const CountryCodeSelector(
      {Key? key,
      this.locations = const [
        Location('Afghanistão', 'af', 93),
        Location('África do Sul', 'za', 27),
        Location('Albânia', 'al', 355),
        Location('Alemanha', 'de', 49),
        Location('Andora', 'ad', 376),
        Location('Angola', 'ao', 244),
        Location('Anguilla', 'ai', 1),
        Location('Antarctica', 'aq', 672),
        Location('Antígua e Barbuda', 'ag', 1),
        Location('Argentina', 'ar', 54),
        Location('Argélia', 'dz', 213),
        Location('Arménia', 'am', 374),
        Location('Aruba', 'aw', 297),
        Location('Arábia Saudita', 'sa', 966),
        Location('Austrália', 'au', 61),
        Location('Áustria', 'at', 43),
        Location('Azerbaijão', 'az', 994),
        Location('Bahamas', 'bs', 1),
        Location('Bahrein', 'bh', 973),
        Location('Bangladesh', 'bd', 880),
        Location('Barbados', 'bb', 1),
        Location('Bélgica', 'be', 32),
        Location('Belize', 'bz', 501),
        Location('Benim', 'bj', 229),
        Location('Bermuda', 'bm', 1),
        Location('Butão', 'bt', 975),
        Location('Bielorrússia', 'by', 375),
        Location('Bolívia', 'bo', 591),
        Location('Bósnia e Herzegovina', 'ba', 387),
        Location('Botswana', 'bw', 267),
        Location('Brasil', 'br', 55),
        Location('Brunei', 'bn', 673),
        Location('Bulgária', 'bg', 359),
        Location('Burkina Faso', 'bf', 226),
        Location('Myanmar (Burma)', 'mm', 95),
        Location('Burundi', 'bi', 257),
        Location('Camarões', 'cm', 237),
        Location('Cabo Verde', 'cv', 238),
        Location('Camboja', 'kh', 855),
        Location('Canadá', 'ca', 1),
        Location('Catar', 'qa', 974),
        Location('Chad', 'td', 235),
        Location('Chile', 'cl', 56),
        Location('China', 'cn', 86),
        Location('Chipre', 'cy', 357),
        Location('Christmas Island', 'cx', 61),
        Location('Cingapura', 'sg', 65),
        Location('Colômbia', 'co', 57),
        Location('Comores', 'km', 269),
        Location('Coreia do Norte', 'kp', 850),
        Location('Coreia do Sul', 'kr', 82),
        Location('Costa do Marfim', 'ci', 225),
        Location('Costa Rica', 'cr', 506),
        Location('Croácia', 'hr', 385),
        Location('Cuba', 'cu', 53),
        Location('Dinamarca', 'dk', 45),
        Location('Djibouti', 'dj', 253),
        Location('Dominica', 'dm', 1),
        Location('Egito', 'eg', 20),
        Location('El Salvador', 'sv', 503),
        Location('Emirados Árabes Unidos', 'ae', 971),
        Location('Equador', 'ec', 593),
        Location('Eritreia', 'er', 291),
        Location('Estónia', 'ee', 372),
        Location('Espanha', 'es', 34),
        Location('Etiópia', 'et', 251),
        Location('Fiji', 'fj', 679),
        Location('Finlândia', 'fi', 358),
        Location('França', 'fr', 33),
        Location('Gabão', 'ga', 241),
        Location('Gâmbia', 'gm', 220),
        Location('Geórgia', 'ge', 995),
        Location('Gana', 'gh', 233),
        Location('Gibraltar', 'gi', 350),
        Location('Grécia', 'gr', 30),
        Location('Groelândia', 'gl', 299),
        Location('Granada', 'gd', 1),
        Location('Guam', 'gu', 1),
        Location('Guatemala', 'gt', 502),
        Location('Guiana', 'gy', 592),
        Location('Guiné', 'gn', 224),
        Location('Guiné Equatorial', 'gq', 240),
        Location('Guiné-Bissau', 'gw', 245),
        Location('Haiti', 'ht', 509),
        Location('Honduras', 'hn', 504),
        Location('Hong Kong', 'hk', 852),
        Location('Hungria', 'hu', 36),
        Location('Islândia', 'is', 354),
        Location('Ilhas Cayman', 'ky', 1),
        Location('Ilhas Cocos (Keeling)', 'cc', 61),
        Location('Ilha de Man', 'im', 44),
        Location('Ilhas Cook', 'ck', 682),
        Location('Ilhas Falkland (Malvinas)', 'fk', 500),
        Location('Ilhas Feroé', 'fo', 298),
        Location('Ilhas Mariana do Norte', 'mp', 1),
        Location('Ilhas Marshall', 'mh', 692),
        Location('Ilhas Pitcairn', 'pn', 870),
        Location('Ilhas Salomão', 'sb', 677),
        Location('Ilhas Turcas e Caicos', 'tc', 1),
        Location('Ilhas Virgens Americanas', 'vi', 1),
        Location('Ilhas Virgens Britânicas', 'vg', 1),
        Location('India', 'in', 91),
        Location('Indonésia', 'id', 62),
        Location('Inglaterra (Reino Unido)', 'gb', 44),
        Location('Irã', 'ir', 98),
        Location('Iraque', 'iq', 964),
        Location('Irlanda', 'ie', 353),
        Location('Israel', 'il', 972),
        Location('Itália', 'it', 39),
        Location('Jamaica', 'jm', 1),
        Location('Japão', 'jp', 81),
        Location('Jordânia', 'jo', 962),
        Location('Cazaquistão', 'kz', 7),
        Location('Quénia (Kenya)', 'ke', 254),
        Location('Kiribati', 'ki', 686),
        Location('Kuwait', 'kw', 965),
        Location('Quirguistão', 'kg', 996),
        Location('Laos', 'la', 856),
        Location('Letônia', 'lv', 371),
        Location('Líbano', 'lb', 961),
        Location('Lesoto', 'ls', 266),
        Location('Libéria', 'lr', 231),
        Location('Líbia', 'ly', 218),
        Location('Liechtenstein', 'li', 423),
        Location('Lituânia', 'lt', 370),
        Location('Luxemburgo', 'lu', 352),
        Location('Macau', 'mo', 853),
        Location('Macedónia', 'mk', 389),
        Location('Madagáscar', 'mg', 261),
        Location('Malawi', 'mw', 265),
        Location('Malásia', 'my', 60),
        Location('Maldivas', 'mv', 960),
        Location('Mali', 'ml', 223),
        Location('Malta', 'mt', 356),
        Location('Mauritânia', 'mr', 222),
        Location('Maurícia', 'mu', 230),
        Location('Mayotte', 'yt', 262),
        Location('México', 'mx', 52),
        Location('Micronésia', 'fm', 691),
        Location('Moldávia', 'md', 373),
        Location('Monaco', 'mc', 377),
        Location('Mongólia', 'mn', 976),
        Location('Montenegro', 'me', 382),
        Location('Montserrat', 'ms', 1),
        Location('Marrocos', 'ma', 212),
        Location('Namíbia', 'na', 264),
        Location('Nauru', 'nr', 674),
        Location('Nepal', 'np', 977),
        Location('Netherlands Antilles', 'an', 599),
        Location('Nova Caledônia', 'nc', 687),
        Location('Nova Zelândia', 'nz', 64),
        Location('Nicaragua', 'ni', 505),
        Location('Níger', 'ne', 227),
        Location('Nigéria', 'ng', 234),
        Location('Niue', 'nu', 683),
        Location('Noruega', 'no', 47),
        Location('Omã', 'om', 968),
        Location('Países Baixos', 'nl', 31),
        Location('Paquistão', 'pk', 92),
        Location('Palau', 'pw', 680),
        Location('Panamá', 'pa', 507),
        Location('Papua-Nova Guiné', 'pg', 675),
        Location('Paraguai', 'py', 595),
        Location('Peru', 'pe', 51),
        Location('Filipinas', 'ph', 63),
        Location('Polónia', 'pl', 48),
        Location('Polinésia Francesa', 'pf', 689),
        Location('Portugal', 'pt', 351),
        Location('Porto Rico', 'pr', 1),
        Location('República do Congo', 'cg', 242),
        Location('República Democrática do Congo', 'cd', 243),
        Location('República Centro-Africana', 'cf', 236),
        Location('República Checa', 'cz', 420),
        Location('República Dominicana', 'do', 1),
        Location('Roménia', 'ro', 40),
        Location('Ruanda', 'rw', 250),
        Location('Rússia', 'ru', 7),
        Location('Saint Barthelemy', 'bl', 590),
        Location('Samoa', 'ws', 685),
        Location('Samoa Americana', 'as', 1),
        Location('San Marino', 'sm', 378),
        Location('Sao Tome e Principe', 'st', 239),
        Location('Senegal', 'sn', 221),
        Location('Serbia', 'rs', 381),
        Location('Serra Leoa', 'sl', 232),
        Location('Seychelles', 'sc', 248),
        Location('Slovakia', 'sk', 421),
        Location('Slovenia', 'si', 386),
        Location('Somalia', 'so', 252),
        Location('Sri Lanka', 'lk', 94),
        Location('Saint Helena', 'sh', 290),
        Location('Saint Kitts and Nevis', 'kn', 1),
        Location('Saint Lucia', 'lc', 1),
        Location('Saint Martin', 'mf', 1),
        Location('Saint Pierre and Miquelon', 'pm', 508),
        Location('Saint Vincent and the Grenadines', 'vc', 1),
        Location('Sudão', 'sd', 249),
        Location('Suriname', 'sr', 597),
        Location('Suazilândia', 'sz', 268),
        Location('Suécia', 'se', 46),
        Location('Suiça', 'ch', 41),
        Location('Syria', 'sy', 963),
        Location('Taiwan', 'tw', 886),
        Location('Tajiquistão', 'tj', 992),
        Location('Tanzânia', 'tz', 255),
        Location('Timor-Leste', 'tl', 670),
        Location('Tailândia', 'th', 66),
        Location('Togo', 'tg', 228),
        Location('Tokelau', 'tk', 690),
        Location('Tonga', 'to', 676),
        Location('Trinidad e Tobago', 'tt', 1),
        Location('Tunísia', 'tn', 216),
        Location('Turquemenistão', 'tm', 993),
        Location('Turquia', 'tr', 90),
        Location('Tuvalu', 'tv', 688),
        Location('Uganda', 'ug', 256),
        Location('Ucrânia', 'ua', 380),
        Location('Uruguai', 'uy', 598),
        Location('Estados Unidos (EUA)', 'us', 1),
        Location('Uzbequistão', 'uz', 998),
        Location('Vanuatu', 'vu', 678),
        Location('Vaticano', 'va', 39),
        Location('Venezuela', 've', 58),
        Location('Vietnã (Vietname)', 'vn', 84),
        Location('Wallis e Futuna', 'wf', 681),
        Location('Iémen (Iémen, Yemen)', 'ye', 967),
        Location('Zimbabwe(Zimbabué)', 'zw', 263),
        Location('Zâmbia', 'zm', 260),
      ],
      required this.onSelectCountry})
      : super(key: key);

  @override
  State<CountryCodeSelector> createState() => _CountryCodeSelectorState();
}

class _CountryCodeSelectorState extends State<CountryCodeSelector> {
  bool active = false;
  TextEditingController searchFieldController = TextEditingController();

  List<Location> actualLocations = [];

  @override
  void initState() {
    setState(() {
      actualLocations = widget.locations;
    });
    super.initState();
  }

  void filterLocations(String filterSearch) {
    List<Location> newFilteredLocations = [];
    for (Location location in widget.locations) {
      var countryName = location.countryName.toLowerCase();
      var search = filterSearch.toLowerCase();

      if (countryName.contains(search)) {
        newFilteredLocations.add(location);
      }
    }
    setState(() {
      actualLocations = newFilteredLocations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SwitchTitleAndSearchBar(
          active: active,
          filterLocations: filterLocations,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                active = !active;
              });
            },
            icon: active ? const Icon(Icons.close) : const Icon(Icons.search),
          )
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (e, a) {
          return const Divider(
            height: 4,
            indent: 0,
            thickness: 1,
          );
        },
        itemCount: actualLocations.length,
        itemBuilder: CountryListBuilder,
      ),
    );
  }

  Widget CountryListBuilder(BuildContext context, int index) {
    var location = actualLocations[index];
    return CountryListTile(
      onSelectCountry: widget.onSelectCountry,
      location: location,
      key: Key(location.countryName),
    );
  }
}

class CountryListTile extends StatelessWidget {
  final Function(Location) onSelectCountry;

  CountryListTile({Key? key, required Location location, required this.onSelectCountry}) : super(key: key) {
    _location = location;
    countryFlag = location.getFlag();
    countryName = location.countryName;
    countryCode = location.countryCode;
    countryNumber = location.number;
  }

  late final Location _location;
  late final String countryFlag;
  late final String countryName;
  late final String countryCode;
  late final int countryNumber;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onSelectCountry(_location);
        Get.close(1);
      },
      onLongPress: () {
        Get.dialog(CountryDetails(
          location: _location,
          key: Key(countryName),
        ));
      },
      leading: Text(
        countryFlag,
        style: const TextStyle(fontSize: 20),
      ),
      title: Text(countryName),
      trailing: Text("+" + countryNumber.toString()),
    );
  }
}

class CountryDetails extends StatelessWidget {
  const CountryDetails({
    Key? key,
    required this.location,
  }) : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) {
    var flag = location.getFlag();
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              flag,
              style: const TextStyle(
                fontSize: 50,
              ),
            ),
          ),
          Text(
            location.countryName + " (${location.countryCode})",
          ),
        ],
      ),
    );
  }
}

class SwitchTitleAndSearchBar extends StatelessWidget {
  final bool active;
  final Function(String) filterLocations;
  const SwitchTitleAndSearchBar({Key? key, required this.active, required this.filterLocations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (active) {
      return TextField(
        onChanged: (e) {
          filterLocations(e);
        },
        autofocus: true,
      );
    }
    return const Text("Selecione um país");
  }
}
