import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tourm_app/core/data/remote/tm_api_config.dart';
import 'package:tourm_app/core/infrastructure/error/types/failures.dart';
import 'package:tourm_app/core/presentation/animated_qr_dialog.dart';
import 'package:tourm_app/core/presentation/customization/no_glow.dart';
import 'package:tourm_app/core/presentation/customization/tm_colors.dart';
import 'package:tourm_app/core/presentation/customization/tm_image.dart';
import 'package:tourm_app/core/presentation/states/pm_failure_view.dart';
import 'package:tourm_app/core/presentation/states/pm_loading_view.dart';
import 'package:tourm_app/core_container.dart';
import 'package:tourm_app/data/model/remote/article_remote_model.dart';
import 'package:tourm_app/domain/repository/articles_repository.dart';
import 'package:tourm_app/presentation/articles/widget/article_vertical_card.dart';

import 'article_page.dart';

class ArticlesPage extends StatefulWidget {
  ArticlesPage({Key key}) : super(key: key);

  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  ArticlesRepository articlesRepository;

  @override
  void initState() {
    articlesRepository = sl();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Either<Failure, List<ArticleRemoteModel>>>(
        future: articlesRepository.getArticles(),
        initialData: null,
        builder: (
          BuildContext context,
          AsyncSnapshot<Either<Failure, List<ArticleRemoteModel>>> snapshot,
        ) {
          if (snapshot.hasData) {
            return snapshot.data.fold(
              (f) => PMFailureView(failure: f),
              (articles) => _buildLoadedArticles(articles: articles),
            );
          } else {
            return TMLoadingView();
          }
        },
      ),
    );
  }

  Widget _buildLoadedArticles({
    @required List<ArticleRemoteModel> articles,
  }) {
    final highlightedArticles = articles.where((i) => i.highlighted).toList();
    final normalArticles = articles.where((i) => !i.highlighted).toList();

    return ArticlesLoadedState(
      articles: normalArticles,
      highlightedArticles: highlightedArticles,
    );
  }
}

class ArticlesLoadedState extends StatefulWidget {
  final List<ArticleRemoteModel> highlightedArticles;
  final List<ArticleRemoteModel> articles;

  const ArticlesLoadedState({
    Key key,
    @required this.articles,
    @required this.highlightedArticles,
  }) : super(key: key);

  @override
  _ArticlesLoadedStateState createState() => _ArticlesLoadedStateState();
}

class _ArticlesLoadedStateState extends State<ArticlesLoadedState> {
  TextEditingController _searchController;
  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    _searchController.addListener(() {
      // BlocProvider.of<SearchBloc>(context)
      //     .add(SearchArticle(query: _searchController.text));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        backgroundColor: TMColors.primary,
        color: Colors.white,
        onRefresh: () async {
          // BlocProvider.of<ArticlesUpdaterBloc>(context).add(UpdateArticles());
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildSearchBar(),
                if (_searchController.text.length < 2)
                  buildTopVisitedSection(
                    articles: widget.highlightedArticles,
                  ),
                if (_searchController.text.length < 2)
                  buildsAndExibitions(
                    articles: widget.articles,
                  ),
                // if (_searchController.text.length >= 2) buildResults()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildResults() {
  //   return BlocBuilder<SearchBloc, SearchState>(
  //     builder: (context, state) {
  //       if (state is SearchResultsLoaded) {
  //         return buildsAndExibitions(articles: state.results, search: true);
  //       }
  //       return CircularProgressIndicator();
  //     },
  //   );
  // }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: TMColors.primary,
        // borderRadius: BorderRadius.circular(16.0),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      Flexible(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 15,
                              bottom: 11,
                              top: 11,
                              right: 15,
                            ),
                            hintText: 'Cerca',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Material(
                borderRadius: BorderRadius.circular(8.0),
                child: Ink(
                  decoration: BoxDecoration(
                    color: TMColors.alternativeBackgroundColor,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AnimatedQRDialog(),
                      );
                    },
                    child: Hero(
                      tag: 'qrcode',
                      child: Container(
                        padding: EdgeInsets.all(13.0),
                        decoration: BoxDecoration(
                          // color: TMColors.alternativeBackgroundColor,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Icon(
                          CupertinoIcons.qrcode_viewfinder,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildsAndExibitions({
    @required List<ArticleRemoteModel> articles,
    bool search = false,
  }) {
    final dummyArticles = <ArticleRemoteModel>[
      ArticleRemoteModel(
          id: 1,
          title: 'Soffitto decorato e lampadario',
          subtitle: 'Arredo con stile',
          imageUrl:
              'https://www.villasagramoso.com/foto/it/1347267017-soffitto-decorato-e-lampadario-in-villa-settecentesca-in-veneto.jpg',
          body:
              """I predecessori dei lampadari erano delle strutture appese in cui bordi erano attaccate candele o delle lampade ad olio. Le prime lumiere iniziarono ad arricchire gli ambienti già dall’epoca romana. Erano molto rudimentali e molto semplici, funzionavano a olio, petrolio o grasso animale e venivano realizzati principalmente in legno o bronzo. La storia di questo complemento d’arredo trova le sue prime espressioni durante il Medioevo. Sin dall’inizio fu concepito come qualcosa di funzionale e artistico allo stesso tempo. Esso, infatti, anche uno scopo decorativo specialmente nei palazzi delle istituzioni civili e religiose.

Con la diffusione dello stile Barocco e Rococò, le decorazioni presero il sopravvento anche su questo particolare oggetto, conferendo al lampadario per la prima volta in assoluto un ruolo da protagonista. Questo periodo vede la nascita di lampadari in cristallo e in vetro, di cui la Boemia e Murano diventano i maggiori produttori.

### **Arte allo stato puro**

Decorazioni asimmetriche, curve, uccelli, foglie, frutta e fiori, decorano questi lampadari di lusso, ormai arte allo stato puro. L’eccentricità del Rococò e del Barocco viene presto sostituita dalla linearità del Neoclassicismo che propone decori che si rifanno all’epoca greco-latina. Ma è solo durante l’epoca vittoriana che si assiste alla diffusione generalizzata di lampade e lampadari.

Sul finire del 1800 e l’inizio del 1900 l’illuminazione a gas viene man mano sostituita da quella elettrica che apre le porte ai modelli proposti dall’Art Nouveau.

Sicuramente, il lampadario è una delle più raffinate fonti di luce artificiali. Sia in ambienti moderni, sia in quelli molto classici conferiscono un tocco di eleganza in più, soprattutto se fabbricati da sapienti artigiani.

I primi ambienti ad essere dotati di questo tipo di luce artificiale furono gli edifici sacri a partire dal tardo Medioevo. In questo periodo, i lampadari a più luci si diffusero anche negli ambienti di corte e della nobiltà, diventando parte integrante dell’arredo interno.

Verso la fine del XVI secolo, tra l’aristocrazia italiana cominciò ad andare di moda l’abbellimento della luce artificiale con preziosi cristalli di rocca. In realtà, questa era una strategia funzionale, visto che questo materiale rifrange maggiormente la luce rispetto al vetro, inoltre donava un aspetto particolarmente prezioso e scenografico data la loro brillantezza. Nel 1700 la produzione di lampadari di cristallo fu promossa  sotto il regno di Luigi XIV.

Dopo la scoperta del cristallo di Boemia, nel XVIII secolo avvenne la sostituzione dei costosi cristalli di rocca con questo materiale. Fu così che i lampadari di cristallo furono accessibili anche alla popolazione, visto che la produzione aumentò e il prezzo divenne più conveniente.

I Lampadari d’epoca si legano ad un passato blasonato ed elegante. Tra i modelli di lampadari di lusso sicuramente spicca quello realizzato con la sublime arte della soffiatura del vetro di Murano. Le colorazioni e le trasparenze del vetro veneziano permettevano di ottenere luminosi effetti cromatici.

### **La fusione tra estetica e funzionalità**

In tempi moderni, i lampadari hanno raggiunto l’apice in vari stili: dal vintage al country, passando da quelli più moderni come l’industrial chic. Lampadari sospesi, ma anche lampade da tavolo, da terra, applique e le più moderne strisce a LED contribuiscono a fare luce nelle case e nella vita delle persone.

I lampadari hanno una certa funzionalità estetica che permette di arredare con la luce e valorizzare una stanza, un oggetto di arredo o semplicemente dividere gli ambienti senza creare degli ostacoli. Ne esistono di tutti i tipi: modelli economici, ma anche preziosi come i lampadari con cristalli Swarovski incastonati.

La storia del lampadario è stata una storia artistica, oltre che di innovazione, e questo percorso ha lasciato in eredità dei modelli pregiati e bellissimi.""",
          name: 'Riccardo',
          surname: 'Calligaro'),
      ArticleRemoteModel(
          id: 1,
          title: 'La struttura del parco',
          subtitle: 'Il parco secolare del XVIII secolo',
          imageUrl:
              'https://www.camarcello.it/wp-content/uploads/2014/09/giardino_italiana-672x450.jpg',
          body:
              """Passeggiando nel vasto e rigoglioso parco all’inglese che si estende tutto intorno alla villa, tra lunghi viali di carpini, tigli e farnie, si incontrano alcune **essenze molto rare per la loro longevità**: i più meritevoli di nota sono un carpino e un liriodendro tricentenari, tra i più antichi del Veneto, un tiglio, un faggio rosso e un platano, anch’essi secolari e in ottima salute. Una piccola parte del parco è riservata ai fiori da taglio e al **vivaio**, che garantisce il rinnovamento continuo delle essenze.

Oltre al patrimonio botanico-naturalistico, la passeggiata porta il visitatore ad ammirare diverse [architetture funzionali](https://www.camarcello.it/architetture-funzionali) come una torre colombaia, una cappella gentilizia e un ampio specchio d’acqua, la ‘Peschiera’, che in origine costituiva la cava da cui furono estratte l’argilla e la sabbia per produrre i mattoni per costruire la villa, e in seguito fu riempita d’acqua per svolgere la funzione di allevamento ittico di casa.

Infine, alcune parti del parco sono a **bosco**, con alberi secolari e numerose [statue](https://www.camarcello.it/statue-di-ca-marcello) raffiguranti animali e personaggi realistici o fiabeschi, tipici del gusto Rococò (curiose sono le serie ‘dei nani’ e ‘delle scimmie musicanti’).
""",
          name: 'Riccardo',
          surname: 'Calligaro'),
      ArticleRemoteModel(
        id: 1,
        title: 'Il patrimonio botanico',
        subtitle: 'Le essenze rare per la loro longevità',
        imageUrl:
            'https://www.camarcello.it/wp-content/uploads/2014/09/giardino_italiana2-672x450.jpg',
        body:
            """Il parco è composto da molte essenze rare per la loro longevità: le più meritevoli di nota sono un carpino e un liriodendro tricentenari, tra i più antichi del Veneto. Passeggiando tra viali e percorsi romantici, il visitatore può scoprire un patrimonio botanico ricco e affascinante. 
Adagiata sul Naviglio del Brenta, a Stra, in provincia di Venezia, Villa Pisani è considerata uno degli esempi più rappresentativi di villa veneta della Riviera del Brenta. Costruita nel XVIII secolo, oggi ospita un Museo Nazionale dove sono custoditi arredi ed opere d'arte risalenti ai primi due secoli a partire dalla sua costruzione. Se visitando le stanze si rimane immediatamente colpiti dalle tipice atmosfere settecente ed ottocentesche che emanano da ogni mobile e da ogni parete,passeggiando per i magnifici giardini che la incorniciano la suggestiva sensazione di tuffo nel passato si arricchisce della meraviglia di trovarsi al cospetto di un vero e proprio capolavoro di interazione tra uomo e natura.

Ispirato ad alcuni antichi testi che fornirono preziose linee guida per la realizzazione di numerosi giardini dell'epoca, il parco occupa 14 ettari di superficie e rivela tanto le sue origini settecentesche, quanto le preziose opere di abbellimento e rivistazione effettuate nel corso dei secoli successivi. Oggi, dunque, il grande giardino di Villa Pisani si mostra agli occhi dei suoi visitatori come una perfetta fusione tra la struttura geometrica settecentesca e la revisione paesaggistica ottocentesca. Se esplporando la zona orientale del parco si possono ammirare la maggior parte delle opere d'arte in esso custodite, è passeggiando per i lunghi viali prospettici che attraversano la zona occidentale che si può constatare il valore botanico e naturalistico del giardino.

Chi varca la soglia di Villa Pisani ci si trova al cospetto di due magnifici viali costeggiati da ippocastani in fondo ai quali si ergono le scuderie settecentesche ispirate, nelle strutture architettoniche, ad antiche suggestioni rinascimentali, al vasto parterre centrale ed alla lunga piscina che si integra alla perfezione con il territorio circostante. Ma è il labirinto il vero capolavoro di questo romantico giardino d'altri tempi.
Realizzato con siepi di bosso, si sviluppa attorno ad una torretta centrale sormontata da una statua di Minerva ed è stato oggetto, nel corso del tempo, di numerose modifiche che gli hanno conferito i suo aspetto attuale.

Bellissima anche la pittoresca terrazza belvedere di forma esagonale raggiungibile con un viale punteggiato di tigli secolari, dalla quale si dipanano assi ottici adornati da gruppi di statue, romantici tunnel di glicini e le vestigia delle antiche cedraie, delle quali rimangono le tracce nei muretti delle vasche. Da non perdere una sosta all'antica ghiacciaia, la cllinetta artificiale cava bordata da cipressi di palude e circondata da un fossato dal quale, un tempo, si prelevava il ghiaccio, dove sorge la pittoresca "coffee-house". Passaggiando, infine, nei pressi delle scuderie, sarà un piacere aosservare l'orangerie e le serre adibite alla coltivazione di profumatissimi agrumi e delle piante tropicali.""",
        name: 'Riccardo',
        surname: 'Calligaro',
      ),
      ArticleRemoteModel(
        id: 1,
        title: 'Architetture funzionali',
        subtitle: 'Le essenze rare per la loro longevità',
        imageUrl:
            'https://www.camarcello.it/wp-content/uploads/2014/09/Gruppo_scimmie_2-672x450.jpg',
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (search)
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Text(
              'Results',
              style: TextStyle(
                fontSize: 18,
                color: TMColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        if (!search)
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Text(
              'News e mostre',
              style: TextStyle(
                fontSize: 18,
                color: TMColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          shrinkWrap: true,
          itemCount: dummyArticles.length,
          itemBuilder: (context, index) {
            final article = dummyArticles[index];
            return ArticleVerticalCard(article: article);
          },
        ),
      ],
    );
  }

  Widget buildTopVisitedSection({
    @required List<ArticleRemoteModel> articles,
  }) {
    final dummyTopArticles = <ArticleRemoteModel>[
      ArticleRemoteModel(
          id: 1,
          name: 'Riccardo',
          surname: 'Calligaro',
          title: 'Alessandro, Apelle e Campaspe',
          subtitle: 'Dipinto olio su tela',
          imageUrl:
              'https://www.camarcello.it/wp-content/uploads/2014/11/alessandro-campaspe-apelle-672x450.jpg',
          body:
              """La società che regge la produzione della scuola di Sicione non è solo una civiltà di cittadini, ma quella che confluiva nell’unità degli Elleni sotto il regime di un monarca: la pittura, come la plastica, era al servizio del potere e l’appoggio dato da [Filippo](http://www.treccani.it/enciclopedia/filippo-ii-di-macedonia_(Enciclopedia-Italiana)/) alla parte aristocratica si risolveva nell’accentuazione di tendenze allegoriche intese all’esaltazione dell’autorità politica.

Attorno al 343, quando Filippo convocò Aristotele per curare l’educazione di Alessandro, anche [Apelle](http://www.treccani.it/enciclopedia/apelle_%28Enciclopedia-Italiana%29/) fu introdotto alla corte di Macedonia per i buoni uffici di Aristrato e i rapporti mantenuti da [Pamfilo](http://www.treccani.it/enciclopedia/panfilo-di-anfipoli/) con il paese di origine. Apelle diviene così protagonista del passaggio dal sistema delle scuole, in qualche modo legate alla tradizione delle città di maggior prestigio culturale, all’impostazione di un’arte aulica**[1]**:

> È superfluo dire quante volte dipinse Filippo ed Alessandro.

Dalla romantica scoperta della bellezza di [Laide](http://www.treccani.it/enciclopedia/laide/), si passa al privilegio del pittore cortigiano ([Plinio, _Naturalis Historia_, XXXV 86](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D36)):

> Alessandro gli dimostrò in quale onore lo tenesse con un esempio famosissimo, e infatti avendo ordinato che la più diletta fra le sue concubine, di nome [Campaspe](https://it.wikipedia.org/wiki/Campaspe), fosse dipinta da Apelle nuda, per ammirazione della sua bellezza, e quello essendosi accorto di essersi innamorato mentre lavorava, gliela diede in dono.

<figure data-shortcode="caption" id="attachment_7372" aria-describedby="caption-attachment-7372" style="width: 400px" class="wp-caption aligncenter">![](https://studiahumanitatispaideia.files.wordpress.com/2014/09/john-william-godward-campaspe.-olio-su-tela-1896.-art-renewal-center..jpg?w=809)

<figcaption id="caption-attachment-7372" class="wp-caption-text">John William Godward, _Campaspe_. Olio su tela, 1896\. Art Renewal Center.</figcaption>

</figure>

La disponibilità del pittore è confermata dalla notizia dell’editto col quale Alessandro, all’avvento al trono, gli avrebbe confermato la prerogativa di riprodurre la propria effige.

Le imprese di Alessandro in Oriente diedero occasione ad Apelle di cogliere il riflesso storico della vicenda personale del sovrano, che egli aveva iniziato ad illustrare in Macedonia con i suoi ritratti. Ad Efeso, dove il pittore era tornato a stabilirsi al suo seguito, Alessandro partecipò ad una _pompḗ_, che era insieme una festa religiosa e una parata militare ([Arriano, _Anabasi_, I 18, 2](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A2008.01.0530%3Abook%3D1%3Achapter%3D18%3Asection%3D2)): probabilmente è questa**[2]** «la processione di Megabizo, sacerdote di Diana Efesina» dipinta da Apelle, insieme ad un Alessandro a cavallo (Eliano, _Varia historia_, II 3) ed al _keraunophóros_**[3]**. La dimestichezza dell’artista con il sovrano alimenta nella letteratura artistica il _tópos_ retorico della visita all’_atelier_, dove tuttavia si riconosce l’autenticità della _cháris_ ionica, intesa non solo come un ideale estetico, ma come stile di vita, a contrasto con la severità di Melanzio e di altri artisti sicioni**[4]**:

> Aveva anche grazia, per cui era molto gradito ad Alessandro il Grande che veniva frequentemente in bottega[…] ma quando si metteva a dire troppe cose inesatte, lo persuadeva con grazia al silenzio, dicendo che veniva deriso dai ragazzi che preparavano i colori.

Alla stessa fonte biografica, d’impronta peripatetica, risale l’episodio relativo all’_Alessandro a cavallo_:

> Alessandro, vedendo ad Efeso la propria immagine dipinta da Apelle, non la lodò secondo il merito della pittura, ma condotto avanti il cavallo, ed avendo esso nitrito al cavallo nel quadro, come fosse stato vero anche quello, Apelle esclamò: «Maestà, ma il cavallo sembra essere molto più esperto di te in pittura».

Il giudizio di verità naturale, respinto da [Zeusi](http://www.treccani.it/enciclopedia/zeusi_%28Enciclopedia-Italiana%29/), è divenuto un «esperimento» ([Plinio, _Naturalis Historia_, XXXV 95](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)) normale per le immagini di animali, mentre nella figura umana l’aspirazione alla _cháris_ porta il pittore ad un’interpretazione soggettiva, che non lasciava persuaso lo stesso Alessandro, poiché Apelle non ne rappresentava ([Plutarco](https://studiahumanitatispaideia.wordpress.com/2020/11/22/plutarco-di-cheronea/)[, _De Alexandri fortuna_, II 335f](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A2008.01.0229%3Astephpage%3D335f)) «la virilità e il carattere leonino», bensì «il volgere del collo e la vaghezza e liquidità dello sguardo». In particolare ([Plutarco, _Vita Alexandri_, 4, 2](http://www.perseus.tufts.edu/hopper/text?doc=Plut.+Alex.+4.2&fromdoc=Perseus%3Atext%3A2008.01.0129)) «dipingendolo portatore di fulmine, non imitò l’incarnato, ma lo fece più scuro e abbronzato». L’effetto nasceva forse dall’elaborazione del chiarore del fulmine in un’atmosfera altrimenti poco illuminata ([Plinio, _Naturalis Historia_, XXXV 92](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)): «le dita sembrano sporgere e pare che il fulmine sia fuori della tavola», ma la distanza dal modello era segnata da un esplicito motto del pittore (Plutarco, [_De Alexandri fortuna_, II 335a](http://www.perseus.tufts.edu/hopper/text?doc=Plut.+De+Alex.+335a&fromdoc=Perseus%3Atext%3A2008.01.0229)):

> Dipinse Alessandro portatore di fulmine con tanta evidenza e colorito da poter dire che dei due Alessandri, quello di Filippo era invincibile, ma quello di Apelle inimitabile.

La diatriba che divise gli artisti nel confronto tra il _keraunophóros_ e l’_Alessandro con la lancia_ di [Lisippo](http://www.treccani.it/enciclopedia/lisippo_%28Enciclopedia-Italiana%29/), riuscirebbe meglio giustificata pensando che anche la pittura di Apelle rappresentasse una figura stante, quale l’_Alessandro col fulmine_ inciso da Pirgotele nel conio di un decadramma e tramandato dalle gemme. Ma la pittura pompeiana offre per molti aspetti una seducente alternativa nella figura in trono nella Casa dei Vettii. Il personaggio giovanile è seduto frontalmente, con una dislocazione di piani che ne rende estremamente mobile la posa: la gamba sinistra è avanzata, mentre la destra è fortemente ripiegata, sicché le ginocchia segnano sotto il mantello una profonda obliquità e divaricazione; il torso è in scorcio verso destra, ma il braccio corrispondente porta avanti lo scettro, puntato a terra in primo piano; la sinistra abbassata stringe il fascio delle folgori che prolunga al centro la diagonale dell’avambraccio, mentre la testa diverge verso l’alto, aprendo in lontananza l’irrequieta composizione. L’impressione di trovarci all’inizio del processo di apoteosi nasce dalla fusione di elementi propri della figura del sovrano ispirato dal dio, con quelli della trasfigurazione nella divinità. Simboli regali e insieme divini sono il trono con lo scranno, lo scettro, il manto di porpora e la corona di fronde di quercia, attributo divino il fascio di folgori stretto nella sinistra, motivo di congiunzione tra le sfere del potere celeste ed umano il movimento verso l’alto della testa e dello sguardo. Ma dove le parole di Plinio trovano il più eloquente riscontro è nella folgore obliqua sul grembo, sporgente dalle ginocchia, ottenuta col bianco e col giallo a contrasto della porpora – _fulmen extra tabula esse_ – e nelle dita del piede sinistro che ricevono dall’alto il bagliore ed urtano immediatamente lo spettatore con i riflessi bianchi che le distinguono una ad una nel calzare – _digiti eminere videtur_. In Nicia il problema è quello di dare risalto plastico all’intera figura, in Apelle l’organicità classica è compromessa dall’evidenza del particolare violentemente illuminato: alla funzione plastica della prospettiva, del colore e della luce, perseguita da Melanzio e da [Pausia](http://www.treccani.it/enciclopedia/pausias_(Enciclopedia-dell'-Arte-Antica)/), si è aggiunto lo _splendor_, come rappresentazione della fonte di luce nel quadro e dei suoi riflessi sulla figura ([Plinio, _Naturalis Historia_, XXXV 29](http://latin.packhum.org/loc/978/1/0#2535)).

<figure data-shortcode="caption" id="attachment_4125" aria-describedby="caption-attachment-4125" style="width: 306px" class="wp-caption aligncenter">![](https://studiahumanitatispaideia.files.wordpress.com/2013/01/alessandro-magno-affresco-pompeiano-i-sec-a-c-dalla-casa-dei-vettii-the-bridgeman-art-library.jpg?w=809)

<figcaption id="caption-attachment-4125" class="wp-caption-text">Alessandro Magno. Affresco pompeiano, I sec. a.C., dalla Casa dei Vettii. The Bridgeman Art Library.</figcaption>

</figure>

Plinio ripeteva a proposito del _keraunophóros_ ([_Naturalis Historia_, XXXV 92](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)):

> I lettori ricorderanno che tutte queste cose sono state fatte con quattro colori.

In Apelle, la tecnica di applicazione è quella della velatura, osservata da Aristotele**[5]**:

> I colori si mostrano gli uni attraverso gli altri come talora fanno i pittori che passano un colore sopra un altro più vivo.

Una vernice trasparente equilibrava i contrasti**[6]**:

> Le sue invenzioni giovarono nell’arte anche ad altri; una sola cosa nessuno poté imitare: ossia che, terminata l’opera la cospargeva di un atramento così tenue che questo stesso, illuminato, suscitava il colore bianco della lucentezza e proteggeva dalla polvere e dalle impurità, apparendo infine alla mano di chi lo osservasse, ma anche allora con grande accortezza, perché la lucentezza dei colori non offendesse la vista a chi osservava come attraverso una pietra speculare, e di lontano la medesima cosa desse inavvertitamente austerità ai colori troppo floridi.

Le consumate risorse di una tecnica vicina al virtuosismo consentono all’artista di esprimere ogni sfumatura della vita interiore e di dare l’interpretazione dei casi individuali nell’inquietudine del tempo: il «demone» di cui parlava l’epigramma a proposito di Apelle, è quanto avvince ed affascina lo spettatore nella rappresentazione dell’animo umano. Nella straordinaria galleria di re, cortigiani ed artisti, dipinti da Apelle insieme al primo autoritratto di cui si abbia notizia nella pittura antica ([_Anthologia Palatina_, IX 595](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A2008.01.0474%3Abook%3D9%3Achapter%3D595)), l’audace introspezione ed un’individuazione senza riserve consentivano ai _metoposkópoi_ di indovinare il passato e il futuro da ciascun volto ([Plinio, _Naturalis Historia_, XXXV 88](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)). Clito il Nero, «che si affrettava a battaglia col cavallo e l’attendente che porge l’elmo a lui che lo chiedeva» ([Plinio, _Naturalis Historia_, XXXV 93](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)), è colui che aveva salvato la vita ad Alessandro al Granico nel 334\. «Neottolemo a cavallo contro i Persiani» ([Plinio, _Naturalis Historia_, XXXV 96](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)) ricorda parimenti le dediche di statue equestri ai caduti del Granico e in qualche modo viene evocato dai cavalieri nel mosaico di Alessandro e nella battaglia sul sarcofago di Sidone. Abrone ([Plinio, _Naturalis Historia_, XXXV 93](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)), rappresentato in un quadro a Samo, potrebbe essere il pittore altrimenti noto nella cerchia di Apelle. Menandro, che Plinio ([_Naturalis Historia_, XXXV 93](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)) indica come «re di Caria», potrebbe essere il satrapo della Lidia, noto tra il 327 e il 321: il dipinto era a Rodi, dove ci porta la notizia di una breve permanenza di Apelle e dei suoi rapporti con Protogene ([_Naturalis Historia_, XXXV 81-83; 88](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)). «Archelao con moglie e figlia» ([_Naturalis Historia_, XXXV 96](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)) può essere identificato con lo stratego figlio di Teodoro, governatore di Susa sotto Alessandro, poi satrapo di Mesopotamia; Anteo ([_Naturalis Historia_, XXXV 93](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)) eventualmente con il padre di Leonnato. Ad Alessandria si trovava il ritratto di Gorgostene ([Plinio, _Naturalis Historia_, XXXV 93](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)), attore tragico, ed alla corte di Tolomeo il pittore avrebbe eseguito la caricatura di un buffone ([_Naturalis Historia_, XXXV 89](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)), qualcosa come i _grýlloi_ di Antifilo.

Le forze inquietanti della pittura di Apelle sublimano nell’allegoria. Nell’_Odeîon_ di Smirne si conservava una _Cháris_ ([Pausania, IX 35, 6](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.01.0159%3Abook%3D9%3Achapter%3D35%3Asection%3D6)) da intendere come la personificazione dell’ideale estetico del pittore, che si può identificare con la figura di un mosaico di Biblo. D’incerta collocazione la _Tychḗ_ seduta**[7]**, che avrà comunque esercitato un’influenza sull’opera di [Eutichide](http://www.treccani.it/enciclopedia/eutichide_(Enciclopedia-Italiana)/). Ad Alessandria, con l’allegoria della Calunnia, Apelle espresse la crisi dei suoi rapporti con Tolomeo. La necessità di rendersi in qualche modo indipendente dall’ordine costituito delle corti solleva il realismo dell’osservatore ad invenzioni straordinarie. Dalla descrizione di Luciano ([_Calumniae non temere credendum_, 2-5](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A2008.01.0432%3Asection%3D2)) s’intende che ogni elemento della figurazione era arricchito di sfumature, finezze ed accentuazioni. Luciano metteva in relazione il quadro con un episodio avvenuto un secolo più tardi, il tradimento di Teodote a Tiro del 219, ma se la confusione è nata dall’assedio di Tiro sostenuto nel 315 dalla guarnigione tolemaica contro Antigono, abbiamo un opportuno riferimento cronologico per i rapporti con Tolomeo I ([Plinio, _Naturalis Historia_, XXXV 89](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)), compromessi dalla simpatia di Apelle per Antigono e dalla rivalità di Antifilo.

Il ritratto e l’allegoria si fondono col genere storico nell’Alessandro trionfante sul carro, che Plinio ([_Naturalis Historia_, XXXV 93-94](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.02.0138%3Abook%3D35%3Achapter%3D37)) descrive a Roma, e suggerisce la partecipazione di Apelle alla prima commissione pittorica che conosciamo da parte dei Diadochi. Si tratta con ogni probabilità di una parte della decorazione del carro funebre di Alessandro**[8]**, attorno al quale erano

> quattro tavole figurate parallele e uguali alle pareti. Di queste la prima aveva un carro cesellato, e seduto su questo Alessandro, che aveva tra le mani uno scettro straordinario: attorno al re si trovava una guardia armata di Macedoni ed un’altra di Persiani melofori, e davanti a questi i portatori delle sue armi. La seconda aveva gli elefanti che seguivano la guardia, bardati da guerra, che avanzavano portando sul davanti Indiani, sul dorso Macedoni, armati secondo il costume consueto. La terza torme di cavalieri che mostravano di raccogliersi in schiera. La quarta navi preparate alla naumachia.

La visione prospettica corrisponde a quella descritta da un autore di scuola aristotelica (_De audibilibus_, 801a 33), con figura che indietreggiano, mentre altre vengono innanzi, e i soggetti ricordano la preferenza espressa da Nicia (Demetrio, _De elocutione_, 76) per «ippomachie e naumachie». Apelle doveva già aver rappresentato qualcosa di simile ad Efeso, per quel che riguarda lo schieramento di cavalieri.

Nella prima tavola, l’eccezionalità della forma dello scettro, messa in luce dalla descrizione di Diodoro, fa pensare ad un tirso, e la presenza degli elefanti rafforza l’ipotesi che si tratti di una rappresentazione di Alessandro come Dioniso di ritorno dall’India. Poiché il corpo del re fu trasferito ad Alessandria, le tavole che decoravano il carro possono essere state tra quelle che Ottaviano portò più tardi a Roma dall’Egitto: il concetto del tiaso vittorioso attraverso la Carmania interessava particolarmente gli abitanti di Alessandria, che veneravano il fondatore come un giovane dio, coperto dalla spoglia di elefante, e rimase all’origine della processione che i Tolomei organizzavano al momento dell’accessione alla _basiléia_. Elementi di questa _pompḗ_ passarono al trionfo romano, ma l’interpretazione offerta dal pittore era così lontana dal programma augusteo da farci credere che la prima sistemazione dei dipinti nel Foro di Augusto fosse prevalentemente decorativa (Plinio, _Naturalis Historia_, XXXV 27). Come il quadro giovanile con Aristrato a Sicione, anche quest’opera apologetica della maturità di Apelle era però destinata a subire un  travisamento. Affermatosi in Roma il processo di apoteosi, Claudio fece sostituire la testa di Alessandro con quella di Augusto**[9]**, e allora accadde che le figure di prigionieri divenissero personificazioni di _Bellum_ e _Furor_, avvinti dalla _Pax Augusta_, secondo l’interpretazione di Plinio (_Naturalis Historia_, XXXV 27; 94) e di Servio (_Scholia ad Aeneidem_, I 294). L’altra tavola di Apelle portata nel Foro di Augusto rappresentava Alessandro con i Dioscuri (Plinio, _Naturalis Historia_, XXXV 27; 93): quando la testa del sovrano fu mutata anche qui in quella di Augusto, i Romani poterono travisare nelle giovani divinità le immagini di Gaio e Lucio Cesare.

I capolavori si addensarono negli ultimi anni, quando Apelle andò a stabilirsi a Coos e ne assunse la cittadinanza (Ovidio, _Ars amandi_, III 401; Plinio, _Naturalis Historia_, XXXV 79). Nell’_Asklepieîon_, Eroda (_Mimiambo_ IV, 72-78) celebrava la decorazione di un interno con un giudizio che, nell’apparente ingenuità del dialogo tra Kokkálē e Kynnō, conferma la tradizione della «linea» (Plinio, _Naturalis Historia_, XXXV 81-84) del pittore e la vivacità della polemica con Antifilo:

> Vere, cara, sono le mani dell’Efesio in ogni linea di Apelle […]; chi ha visto lui o le sue opere senza restar stupito in contemplazione, come giusto, quello sia appeso per un piede nella bottega di un tintore.

Leonida di Taranto (_Anthologia Palatina_, XVI 182), raggiungendo Teocrito a Coos, vide l’Afrodite _Anadyoménē_, lasciandocene la prima, insuperata descrizione:

> Nascente dal grembo della madre, ancora ruscellante di spuma, vedi la nuziale Cipride, come Apelle l’espresse, bellezza amabilissima, non dipinta, ma animata. Dolcemente con la punta delle dita spreme la chioma, dolcemente irraggia dagli occhi luminoso desiderio, e il seno, annuncio del suo fiorire, inturgidisce come un pomo. Atena stessa e la consorte di Zeus diranno: «Zeus, siamo vinte al giudizio!».

<figure data-shortcode="caption" id="attachment_7374" aria-describedby="caption-attachment-7374" style="width: 640px" class="wp-caption aligncenter">![](https://studiahumanitatispaideia.files.wordpress.com/2014/09/venere-anadyomene.-affresco-pompeiano-i-sec.-a.c.-dalla-casa-di-venere.jpg?w=809)

<figcaption id="caption-attachment-7374" class="wp-caption-text">Afrodite _Anadyoménē_ esce dal mare con due amorini. Affresco pompeiano del I secolo d.C., dalla Casa di Venere.</figcaption>

</figure>

La notizia di Strabone (XIV 2, 19) che nell’_Asklepieîon_ si conserva tra le opere di Apelle un ritratto di Antigono, consente di datare questo periodo fino agli anni tra il 306 e il 301, quando l’isola fu sotto il controllo del Monoftalmo: si tratta probabilmente dell’Antigono a cavallo (Plinio, _Naturalis Historia_, XXXV 93) che chiude l’elenco pliniano dei ritratti ed era preferito, insieme ad un’Artemide (Plinio, _Naturalis Historia_, XXXV 96), da «i più esperti d’arte». Da Coos fu portata a Roma anche l’ultima opera del maestro, un’Afrodite, interrotta dalla morte**[10]**.

La critica antica faceva culminare con Apelle il processo di scoperta della pittura classica, poiché il pittore apparentemente non ha inteso rompere col passato, ha espresso la propria ammirazione per i seguaci di scuole diverse ed ha rivissuto in una sintesi più vasta precedenti esperienze. Ma sul piano della teoria artistica egli ha portato a compimento l’innovazione dei maestri di Sicione, che consiste nella relatività e soggettività della rappresentazione. Le motivazioni per cui il pittore avrebbe superato «tutti quelli nati prima e quelli destinati a nascere dopo» (Plinio, _Naturalis Historia_, XXXV 79), non sono infatti omogenee alla serie delle precedenti invenzioni: l’ultima di quelle citate da Plinio, lo _splendor_, per quanto fosse nota all’artista e certamente da lui sviluppata, non gli veniva esplicitamente attribuita […]. Quintiliano**[11]** invece afferma che Apelle era superiore agli altri per «ingegno e grazia», e di ciò il pittore stesso si sarebbe vantato. Ora i frammenti derivati dagli scritti di Apelle «sulla teoria della pittura» (Plinio, _Naturalis Historia_, XXXV 79; 111), non lasciano dubbi sul fatto che _cháris_ e _gnōmē_ fossero doti naturali dell’artista, che nulla avevano a che vedere con i fondamenti obiettivi dell’estetica classica: Apelle stesso ammetteva di venire superato da Melanzio nella composizione, da Asclepiodoro nelle proporzioni (Plinio, _Naturalis Historia_, XXXV 79) e da Protogene nella diligenza. […]

Apelle aveva colto un aspetto moderno dell’operare, il senso di una conclusione dal punto di vista artistico che non coincideva con la preoccupazione classica della completezza (Plinio, _Naturalis Historia_, XXXV 80):

> Altra gloria acquistò ammirando un’opera di Protogene d’immenso lavoro e di quanto mai travagliata cura, disse infatti che in quello ogni cosa era pari o anche superiore a lui, ma che egli in una sola cosa era superiore, e cioè che sapeva togliere la mano dalla tavola, col memorabile precetto che spesso l’eccessiva diligenza nuoce.

Apelle credeva alla soluzione del quadro con un colpo di spugna, alla felicità del momento ispirato da Hermes (_Hḗrmaion_), aveva fede in ciò che si produce da se (_autómaton_), secondo la formulazione aristotelica – «l’arte ama fortuna e la fortuna ama l’arte» – che compromette il merito convenzionale della ricerca (Dione Crisostomo, _Orationes_, LXIII 4-5):

> Non riusciva a dipingere la schiuma del cavallo travagliato dal combattimento. Sempre più in difficoltà, alla fine, per smetterla gettò la spugna sulla pittura in direzione del morso. Ma poiché questa aveva molti colori, applicò alla pittura il colore più simile alla schiuma desiderato. Apelle vedendo ciò si rallegrò, nella sua incapacità, dell’opera di fortuna e terminò l’opera non per arte, ma per fortuna.

La _cháris_ non è una regola valida per ragioni obiettive e razionali, non è trasferibile attraverso l’insegnamento, come la precettistica sicionia, ma è affidata a sua volta ad una qualità personale, il «genio» dell’artista, che risolve le difficoltà contingenti del modello. Questo infatti non è più scelto secondo il criterio classico del bello, ma viene offerto da circostanze estranee alla selezione estetica […].
"""),
      ArticleRemoteModel(
        id: 1,
        title: 'Decorazione del soffitto',
        subtitle: 'Decorazione settecentesca',
        imageUrl:
            'https://www.villasagramoso.com/foto/it/1347283436-decorazione-settecentesca-del-soffitto-nella-villa-veneta.jpg',
      ),
      ArticleRemoteModel(
        id: 1,
        title: 'Sala da pranzo principale',
        subtitle: 'Decorazione settecentesca',
        imageUrl:
            'https://www.villasagramoso.com/foto/it/1347271094-settecentesche-ville-venete-a-verona-sala-da-pranzo-di-villa-pompei.jpg',
      ),
    ];

    // return Text(articles.map((e) => e.title).toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Row(
            children: [
              Text(
                'In primo piano',
                style: TextStyle(
                  fontSize: 18,
                  color: TMColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (_) => Colors.transparent),
                ),
                onPressed: () {
                  // TODO: view all
                },
                child: Text(
                  'Visualizza tutti',
                  style: TextStyle(
                    fontSize: 16,
                    color: TMColors.primary,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Text(articles.map((e) => e.title).toString()),
        SizedBox(
          height: 230,
          child: ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(dummyTopArticles.length, (index) {
                  final article = dummyTopArticles[index];
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: buildTopVisitedCard(article: article),
                    );
                  } else if (index == 15) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: buildTopVisitedCard(article: article),
                    );
                  }

                  return buildTopVisitedCard(article: article);
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTopVisitedCard({
    @required ArticleRemoteModel article,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0.0, 16.0, 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              goToArticlePage(article);
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).cardColor.withOpacity(0.9),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: TMImage(article.imageUrl)
                          // child: TMImage('${getBaseUrl()}/${article.imageUrl}'),
                          ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      article.title,
                      style: TextStyle(
                        // fontWeight: FontWeight.w200,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      article.subtitle,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void goToArticlePage(ArticleRemoteModel articleDomainModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ArticlePage(
          article: articleDomainModel,
        ),
      ),
    );
  }
}
