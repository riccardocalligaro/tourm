# Tourm 🏛️

A prototype of a mobile application, available both on iOS and Android, intended for use by an eighteenth-century villa that wants to reorganise its audioguide mechanism so that visitors can use their personal devices.

<div style="text-align:center"><img src="https://i.imgur.com/IrEAPTJ.png"></div>


<a href="https://www.youtube.com/watch?v=zTZOG-2ZkQ4"><div style="text-align:center"><img height="200px" style="text-align:center" src="https://i.imgur.com/Q0zSB16.png"></div></a>


# Used technologies

- 💻 Backend & Admin panel: Laravel + Laravel Breeze for authentication
- 📱 Mobile app: Flutter
- ⚙️ Hardware: Bluetooth beacons

# Paper

<a href="paper.pdf">Read</a> the full paper.

The following work aims at analysing and designing the prototype of a mobile application, available both on iOS and Android, intended for use by an eighteenth-century villa that wants to reorganise its audioguide mechanism so that visitors can use their personal devices. The general requirements for such a service will be studied, with particular attention to the basic functionalities that the application must offer; the characteristics of the network infrastructure will be evaluated, with a focus to the devices that allow to detect the position of the visitor. Furthermore, the administration panel used by the staff to access the actual visitor count and to close or open access to the rooms will be analysed. The tools made available by the various programming languages, frameworks and libraries that have allowed the development of some of the functionalities will be presented. A part will also be devoted to security, a fundamental aspect of any application. Finally, the results achieved and possible improvements to be made in the future will be analysed in order to obtain a quality product.


Il presente lavoro mira ad analizzare e progettare il prototipo di un’applicazione mobile, disponibile sia su iOS che su Android, destinata all’uso in una villa storica risalente al diciottesimo secolo. Lo scopo è quello di riorganizzare il meccanismo di audioguide in modo che i visitatori possano utilizzare i loro dispositivi personali. Verranno studiati i requisiti generali di tale servizio, con particolare attenzione alle funzionalità di base che l’applicazione deve offrire; saranno valutate le caratteristiche dell’infrastruttura di rete, con particolare attenzione ai dispositivi che permettono di rilevare la posizione del visitatore. A questo farà seguito l’analisi del pannello di amministrazione utilizzato dal personale per accedere al conteggio effettivo dei visitatori e per chiudere o aprire l’accesso alle stanze. Verranno presentati gli strumenti messi a disposizione dai vari linguaggi di programmazione, framework e librerie che hanno permesso lo sviluppo di alcune delle funzionalità. Una parte sarà anche dedicata alla sicurezza, un aspetto fondamentale di qualsiasi applicazione. Infine, verranno analizzati i risultati raggiunti e i possibili miglioramenti da apportare in futuro per ottenere un prodotto di qualità.
# Objectives

Tourm aims to achieve the following objectives:
- to develop an application for smartphones, available both on iOS and
Android, intended for the end user to allow him to:
    - download the application through a QR code present inside the villa
    - access the exhibition part of the application with the code of the ticket purchased online or at the sales counter
    - interact with the exhibitions by automating the playback of pre-recorded audio explanations
    - interact with the exhibitions by scanning a QR code that allows you to read an article and listen to the associated audio guide
    - receive automatic notifications about the availability of guided tours or events
- develop an administrative web portal for organizers to enable them to:
    - access the actual visitor count
    - view statistics about exhibitions and interactions made by users - close or open access to rooms
- develop a secure, fast and reliable network infrastructure that allows visitors to:
    - connect to a free wireless network without internet access
    - use the application without any mobile data charges
    - use the network securely without having to worry about threats

