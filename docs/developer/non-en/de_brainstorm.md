[TOC]

# Ziele
 x-Force 2 soll ein leicht verbessertes x-Force 1 mit neuen Sounds und Grafik werden (sofern nicht mehr völlig nachvollziehbar ist was von wo stammt und unter welche Lizenz unterliegt)

 Die Entwicklung muss mit frei zugänglicher und kostenloser Software möglich sein

 Mögliche Helfer sollten es so leicht wie möglich habe eine Entwicklungsumgebung einzurichten => Entwicklung in einem Container (Vagga oder Docker)

 Einzelkomponenten sollten notfalls austauschbar sein => lieber bekannte offene Formate als "optimale" (besser XML / Json als eine Eigenentwicklung)

 Möglichst schnelle Umsetzung

## Nicht-Ziele

 Kompatibilität zu x-Force 1

# Versionierung:

Da man praktisch immer noch etwas verbessern kann, mag ich nicht "1.0" als feriges Spiel definieren und irgendwann bei "0.997" enden.
Daher mein Vorschlag:

0.X.Y => Geocape und Co werden entwickelt, Bodeneinsatz nur minimal
1.X.Y => Geocape und Co sind vorerst fertig, X-Force ist nun ansich spielbar, nun wird primär der Bodeneinsatz entwickelt
2.X.Y => Bodeneinsatz vorerst fertig, Fokus liegt nun auf die Zusatztools und Erstellung der Gamsets
3.X.Y => wir sind nun etwa auf den derzeitigen Stand von X-Force 1 (nur hoffentlich ohne grobe Desingfehler) und setzen wünsche um

Eine Erhöhung der X-Nummern bedeutet dass entweder grösere Neuerungen gibt, ein Teilbereich "ferig" ist oder aber nun irgendetwas anders funktioniert und alte Spielstände/Maps nicht mehr verwendet werden kann.
Die Y-Nummern erhöhen sich jedes mal wenn eine neue Version zum Download bereitgestellt wird. Sie wird auf 0 zurückgesetzt, wenn X erhöht wird.

# Name

Einfach nur "X-Force 2: (Gameset)"

# Spielsätze

(Fremde) Spielsätze werden erst ab Version 3 unterstützt. Bis dahin werden nur 3 offizielle angeboten.

  - Ein "Demo" nur zum zeigen und testen was möglich ist, man sollte sich direkt mit einem *sehr gut ausgerüstetem* Team sich austoben können und Geschmack auf mehr bekommen.
   Vllt ein BE aus 3 Teilen bei dem man im ersten kurzen Teil nur einen Soldaten steuern kann und einige gesprintete Sachen passieren.
   Im 2. Teil wird das Team per Skript vergrößert und man hat  ein paar einfache Gegner, im 3. Teil dann ein starkes Team mit wahnsinnigen Waffen und fiese Aliens.
  -  eins für Einsteiger ala "Das Tagebuch des William Walker"
  - ein für die erfahrenen Spieler -> "GalWar"

# Meine Wunschliste

 Spielen und Entwicklung unter Linux ohne Umwege möglich

## Geocape
   - 2D ~~hexglobe?  http://forum.unity3d.com/threads/hexglobe-hex-based-planetary-globes-for-strategy-games.156601/~~
   - ETA
   - Tag/Nacht bzw lokale Uhrzeit
   - verschiedene Klimazonen die an BE weitergegeben werden
   -  Menü/Features deaktivierbar z.b. kein Basisbau, Arbeitsmarkt
   - mehrere Fraktionen und Fraktionsgruppen erstellbar, denen kann man Ausrüstungen zuweisen Namen erscheinen in den Meldungen anstelle von "Alien". Zb. Gruppen "Menschen", "Maschienen", "Tiere" und "Aliens" eine Ausrüstung die "Maschienen" zugeortnet wird, kann nicht von den anderen 3 Gruppen benutzt werden. Ein Roboter kann aber zudem der x-Force oder einer Alien-Rasse gehören.
   - Ufo und Aliens bekommen eine Liste von Namen (erst nennt man alles nur "UFO" dann unterscheidet man in "kleines/großes UFO" später "Scout/Frachter" und irgendwann stellt man fest dass es mehre Rassen gibt und ordnen die UFOs entsprechend neu zu), Script kann nach Forschung etc den Index ändern, Index 0 => nimm den Index aus einer Globalen.
   - Musik einstellen, mute
   - mit Rechts-Klick zurück zum Geocape
   - Mehrere Nachrichten zusammen fassen (5 neue Artefakte => eine Meldung mit Auflistung)
   -  Missionen & Events
  Für alles was keine reine Forschung ist, für die Story besser ist als eine Forschung oder Bodeneinsatz (Event Tagebucheintrag)
  Oder auch als Voraussetzung für Forschung ist ("Produziere 3 Prototypen" irgendwo im Wiki stehen zu haben ist nicht so günstig)
  Möglich: Nahrung im Lager < 2 * Personal => neue Mission "Nahrungsbeschaffung" => Auswahl wie/wo => entsprechender BE oder einfach nur ein Soldat ne Zeitlang "unterwegs"
   - Alphatron, Bergwerke und Technicker ersetzen durch 3D-Drucker-Patronen und -Experten.
 Bergwerke ggf als Einnahmequelle


## Basen
 Reparatur => http://www.xforce-online.de/forum/index.php?action=vthread&forum=9&topic=2702

## Start
 Erst Auswahl des Gameset, dann Into & Hauptmenü
 Quick-Start: Parameter "--gameset last | (NAME)" überspringt Auswahl und Intro
 Highscore und Singelplayer weg

## Personal
 Typen im Spielsatz frei definierbar, im Grunde braucht man nur eine ID (für Scripts), Name und Daten für den Arbeitsmarkt
 "sonstiges Personal"? Köche, Putzkräfte sind "unsichtbar" brauchen aber auch Quartiere und Sold

### Soldaten
 - Filter und Sortierung

### Einheiten-Werte
Alles 100  (intern 100.000?) entspricht einem Durchschnitts-Soldat
Zivilisten liegen wohl meist bei 80.
Bei Menschen sind Werte von 0 - 200% (Trainingslimit) vorgesehen, Maschinen und Aliens können höhere Werte haben.
Der Trainingseffekt sollte schwach sein, man rekrutiert ja bereits gut ausgebildete Soldaten. Zudem soll es eigentlich auch normal sein dass man Verluste hat, da dürfen die alten Hasen nicht unersetzbar werden.
Je weiter der Wert von der 100 entfernt ist, je schlechter trainiert man. Wer etwas sehr schlecht kann, sollte schlecht darin bleiben.



## Raumschiffskampf
 - Per Script simuliert
 - Scripte "Offensiv", "Defensiv" und "Rückzug" werden bereitgestellt, können aber vom Spielsatzersteller ersetzt werden

## Labor & Werkstatt
 - Personal wird automatisch ausgebildet wenn es nichts zu tun hat
 - Zuweisung per Schiebregler statt Klicks
 -  Forschungen benötigen ggf auch Werkraum und Techniker/Assistenten
 - ein Projekt sollte eine Mindest und Optimale Anzahl von Wissenschaftler/Techniker haben, außerhalb des Bereichs arbeiten sie ineffizient => besser für Ballancing? Paralleles Forschen macht Sinn

## Bodeneinsatz
 - Script generierte Maps
 - Platzhalter für zufällige Tile / Objekt aus einer Liste mit Wahrscheinlichkeit (auf ner Wiese können sehr zufällig Bäume stehen / auf einem Weg mal ne Pfütze, mal Laub liegen)
 - größere Einheiten (mehrere Felder) möglich
 - mehrere Parteien mit unterschiedlichen Beziehungen per Script erstellbar
 - hockende / liegende Einheiten
 - Feuer, Rauch & Gas
 - Boden aus Hexfelder aber rechtwinklige Räume (Fallout 1+2) => Iso-Grafiken passen dann nicht so richtig, müssten dann auch Trimetric verwenden
  https://en.wikipedia.org/wiki/Axonometric_projection#/media/File:Graphical_projection_comparison.png
  Find ich natürlicher, ist aber schwerer zu handhaben http://math.stackexchange.com/questions/948705/reversing-a-trimetric-projection-matrix
 - Alternativ mit weniger? Aufwand: kleineres Gitter, Soldaten sind 3*3 Felder groß, Objekte können auch mehrere Felder belegen und Mauern werden wie normale Objekte gesetzt => Wegfindung etc ist schwerer umzusetzen, müsste aber eh gemacht werden wenn es große Einheiten geben soll. Zumindest wenn man nicht einfach ein 2. größeres Gitter drüber legen möchte. Ein größeres Gitter hätte den Nachteil das sich große Einheiten immer nur 2 Felder auf einmal weiter bewegen können. http://www.gamedev.net/topic/37929-pathfinding-for-large-units/
 - zwar nur eine begehbare Ebene aber Häuser mit Dächer (Fallout 1+2)
 - unüberdachtes dank Dohnen / Satelliten sichtbar (per Script einschaltbar) und mit Mörser (JA2) / Drohne angreifbar, Granaten können im Gebäude nicht so hoch (= weit) geworfen werden
 - Keine Kontrolle fremder Einheiten (PSI-Angriff)
 - Wenn die Basis angegriffen wird, möchte ich genau diese verteidigen, jedes Gebäude braucht dementsprechent auch einegenen Kartenabschnitt.
 - Große Maps / Basen / mehrstöckige Gebäude werden in mehreren Bodeneinsätze aufgeteilt
 - Zielbereiche (wenn alle dort ankommen ist der Bodeneinsatz gewonnen auch wen noch Feinde da sind) und Bereiche die ein Script auslösen wenn sie Betreten werden
 - Hilfsmarkierungen für die AI

## Inventar
 - verschiedene "Taschen"
 - Anzahl und Größe durch Ausrüstung änderbar
 - Items um 90° drehbar

## Bodeneinheiten:
 - verschiedene (Treffer-)Zonen (Kopf, Beine..) mit unterschiedlicher Wirkung bei Treffern (Beine -> weniger Schaden, Erhöhung der Bewegungskosten)
 - Zonen frei definierbar (Energiequelle, "Kopffüssler" ohne Torsor, 4 Beine und 4 Arme)
 - Zonen habe eigene Rüstungswerte oder können (Aus)Rüstungsteile zugewiesen bekommen
 - Links / Rechtshänder (primäre und sekundäre Waffenärme), Waffe mit Links abfeuern ist schwer für Rechtshänder, Schild in der Linken kann nicht die rechte Seite schützen
 - Einhandwaffe und eine freie Hand = etwas höhere Treffgenauigkeit
 - 2 gleiche Einhandwaffen gleichzeitig abfeuerbar, keine gezielten Schüsse

### Waffen:
 - 6+1 Schadensarten (nicht mehr wegen Balance): Hieb/Druck, Stich, Schnitt, Hitze (Feuer und Energie-Waffen), Säure, Gift (Rauch) + Heilung
 - ohne Munition möglich (Kralle, Messer)
 - "festmontierte" Waffen (Roboter, Tier mit Krallen)
 - unterschiedliche Aktionen (Messer: Werfen, Schneiden, Stechen)
 - Aktionen können keine (Schusswaffen) oder mehrerer Schadenessarten verursachen
 - Schadensarten können einen Radius haben, sind dann Flächenangriffe
 - Aktionen die nur Schaden mit Radius haben zielen auf den Boden, nicht auf eine Einheit
 - Schuss auf den Boden erzwingbar
 - Schuss in Richtung einer Position (wenn man eine Wand treffen möchte) erzwingbar
 - Treffer durch Aktionen und Munni können ein Script aufrufen

#### Munition:
 - mehrerer Schadenesarten gleichzeitig (Explosion verursacht Druck, Stich- & Schnittwunden (Schrappnelle) und Hitze)
 - sollte man verschiedenen Waffen zuordnen können, 9mm -> Pistole & MG, Akku -> Laser-Pistole & -Gewehr
 - Magazine in unterschiedlicher Größe, Pistole: 6 * 9mm , MG: 15 * 9mm
 - zusammenlegen und umfüllen im BE möglich, gegen Zeitkosten
 - angefangene Magazine verschwinden nicht nach BE, automatisches zusammenfügen nach BE
 - Leermagazine sollten nicht verschwinden, beim nachladen: fallen lassen (0 ZE) | ins Inventar (+x ZE)

http://www.mapeditor.org/
http://archivewiki.fifengine.net/FIFE%27s_map_geometry
http://vagga.readthedocs.org/en/latest/what_is_vagga.html

