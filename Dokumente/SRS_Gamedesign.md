# Jump-and-Run

[LevelDesignDokument.docx](https://github.com/user-attachments/files/17391797/LevelDesignDokument.docx)

# Level-Überblick

- **Anzahl der Level:** Das Spiel wird 3 bis 5 Level haben.
- **Schwierigkeitskurve:** Jedes Level wird schwieriger, mit komplexeren Plattformen, schneller werdenden Gegnern und neuen Hindernissen.
- **Ziel jedes Levels:** Der Spieler muss bestimmte Ziele erreichen (z.B. Flagge, Endboss, Zeitlimit).

## Level 1: Einführung

- **Beschreibung:** Leichtes Level, um den Spieler mit den grundlegenden Mechaniken vertraut zu machen.
- **Gegner und Hindernisse:** Einfache Gegner, langsame Bewegungen, breite Plattformen, wenig tödliche Fallen.
- **Atmosphäre:** Einfacher, bunter Hintergrund, eventuell fröhliche Musik.

## Level 2: Herausforderung steigt

- **Beschreibung:** Die Schwierigkeit wird erhöht, der Spieler muss mehr Geschick beweisen.
- **Gegner und Hindernisse:** Schnellere Gegner, bewegliche Plattformen, tödliche Hindernisse wie Abgründe oder Todeszonen.
- **Ästhetik und Atmosphäre:** Hintergrund wird düsterer, die Musik eventuell schneller und bedrohlicher.

## Level 3-5: Maximale Herausforderung

- **Beschreibung:** Diese Level sind extrem anspruchsvoll und fordern perfektes Timing.
- **Gegner und Hindernisse:** Stärkere Gegner mit komplexen Bewegungsmustern, enge Plattformen, zusätzliche Fallen.
- **Ästhetik und Atmosphäre:** Dunkler, epischer Hintergrund mit dramatischer Musik, die Spannung aufbaut.

## Progression der Gegner

- **Entwicklung der Gegner:** Von einfachen Lauf- und Sprungmustern zu komplexen Angriffen, größere Gegnertypen, Endgegner mit viel HP.
- **Gegnerplatzierung:** Gegner werden an strategischen Punkten positioniert, um den Spielfluss zu stören, ohne unfair zu wirken.

## Power-ups und Belohnungen

- **Verteilung von Power-ups:** In den frühen Leveln häufiger verteilt, in späteren Leveln seltener.
- **Spezielle Mechaniken:** Teleports, versteckte Räume oder Boni, die in späteren Leveln als Belohnung für erkundungsfreudige Spieler eingebaut werden.

# Gegner

## Gegner-Typ: "Schläger" (Level 1)

- **Beschreibung:** Ein einfacher Nahkampf-Gegner, der nur einen Faustschlag ausführt.
1. **Lebenspunkte (HP):** 50 HP (5 Treffer, 10 Schaden pro Treffer).
2. **Bewegungsgeschwindigkeit:** 1.5 Einheiten pro Sekunde.
3. **Angriff:** Nahkampf-Faustschlag (1.2 Einheiten Reichweite, 10 HP Schaden, 1 Angriff alle 2 Sekunden).
4. **Verhalten:** Verfolgt den Spieler, bleibt auf der Plattform und greift nur in Nahkampfreichweite an.
5. **Spezialfähigkeit:** Keine.
6. **Animationen:** Laufen, Faustschlag, einfache Tod-Animation (kollabiert und verschwindet).

## Gegner-Typ: "Fernkämpfer" (Level 2)

- **Beschreibung:** Ein Gegner, der sowohl Nahkampf- als auch Fernkampfangriffe ausführt.
1. **Lebenspunkte (HP):** 75 HP (8 Treffer, 10 Schaden pro Treffer).
2. **Bewegungsgeschwindigkeit:** 2 Einheiten pro Sekunde.
3. **Angriff:**
   - Nahkampf: Faustschlag (1.2 Einheiten Reichweite, 15 HP Schaden, 1 Angriff pro Sekunde).
   - Fernkampf: Feuerkugel (2 Einheiten pro Sekunde Projektilgeschwindigkeit, 5 Einheiten Reichweite, 20 HP Schaden).
4. **Verhalten:** Verfolgt den Spieler, greift im Nahkampf an oder schießt, wenn der Spieler auf Abstand bleibt.
5. **Spezialfähigkeit:** Fernkampfangriffe bei größerer Entfernung.
6. **Animationen:** Laufen, Faustschlag, Feuerkugelwurf, Tod (geht in Flammen auf).

## Gegner-Typ: "Elite-Wächter" (Level 3)

- **Beschreibung:** Ein mächtiger Gegner mit starken Nah- und Fernkampfangriffen.
1. **Lebenspunkte (HP):** 120 HP (12 Treffer, 10 Schaden pro Treffer).
2. **Bewegungsgeschwindigkeit:** 2.5 Einheiten pro Sekunde.
3. **Angriff:**
   - Nahkampf: Kräftiger Faustschlag (1.5 Einheiten Reichweite, 25 HP Schaden).
   - Fernkampf: Energiepfeil (3 Einheiten pro Sekunde, 7 Einheiten Reichweite, 30 HP Schaden).
4. **Verhalten:** Aggressiv, weicht gelegentlich aus, wechselt zwischen Nah- und Fernkampf.
5. **Spezialfähigkeit:** Schildmodus (blockiert 50% des Schadens für 3 Sekunden).
6. **Animationen:** Laufen, Faustschlag, Energiepfeil, Schildaktivierung, Tod (explodiert in Energiewellen).

## Gegner-Typ: "Meister-Assassine" (Level 4)

- **Beschreibung:** Ein schneller Gegner, der Nah- und Fernkampfangriffe kombiniert.
1. **Lebenspunkte (HP):** 150 HP (15 Treffer, 10 Schaden pro Treffer).
2. **Bewegungsgeschwindigkeit:** 3 Einheiten pro Sekunde.
3. **Angriff:**
   - Nahkampf: Dolchhieb (2 Einheiten Reichweite, 30 HP Schaden).
   - Fernkampf: Wurfmesser (4 Einheiten pro Sekunde, 35 HP Schaden).
4. **Verhalten:** Schnelle, verwirrende Bewegungen, teleportiert sich, um Angriffe zu vermeiden.
5. **Spezialfähigkeit:** Teleportation alle 5 Sekunden.
6. **Animationen:** Schnelles Laufen, Dolchhieb, Wurfmesser, Teleportation, lautloser Tod.

## Gegner-Typ: "Endboss: Dunkler Fürst" (Level 5)

- **Beschreibung:** Der Endgegner des Spiels, eine mächtige Kombination aus Nah- und Fernkampf.
1. **Lebenspunkte (HP):** 300 HP (30 Treffer, 10 Schaden pro Treffer).
2. **Bewegungsgeschwindigkeit:** 2 Einheiten pro Sekunde.
3. **Angriff:**
   - Nahkampf: Gigantische Keule (3 Einheiten Reichweite, 50 HP Schaden).
   - Fernkampf: Energieblitze (4 Einheiten pro Sekunde, 40 HP Schaden).
4. **Verhalten:** Wechselt zwischen Nah- und Fernkampf, bei 50% HP erhöht sich seine Angriffsgeschwindigkeit.
5. **Spezialfähigkeit:** Energiewelle, die alle 10 Sekunden 20 HP abzieht.

# Fallen

## Falle: "Stachelboden" (Level 1)

- **Beschreibung:** Eine statische Falle, die bei Berührung Schaden zufügt.
1. **Schaden:** 15 HP pro Berührung.
2. **Verhalten:** Statisch.
3. **Platzierung:** In Bereichen, wo präzise Sprünge nötig sind.

## Falle: "Fallende Plattformen" (Level 2)

- **Beschreibung:** Plattformen, die nach 1 Sekunde zusammenbrechen.
1. **Verhalten:** Bricht nach einer Sekunde ein.
2. **Schaden:** Tod durch Absturz.
3. **Platzierung:** Über Abgründen oder Todeszonen.

## Falle: "Feuerballwerfer" (Level 3)

- **Beschreibung:** Schießt periodisch Feuerbälle.
1. **Schaden:** 25 HP pro Feuerball.
2. **Verhalten:** Schießt alle 3 Sekunden einen Feuerball.
3. **Platzierung:** Strategisch, um den Spieler beim Springen zu behindern.

## Falle: "Schwingende Äxte" (Level 4)

- **Beschreibung:** Große Äxte, die rhythmisch hin und her schwingen.
1. **Schaden:** 35 HP pro Treffer.
2. **Verhalten:** Schwingen in festgelegten Intervallen.
3. **Platzierung:** In engen Korridoren oder über Plattformen.

## Falle: "Energiebarriere" (Level 5)

- **Beschreibung:** Eine Energiewand, die periodisch aktiviert wird.
1. **Schaden:** 50 HP pro Berührung.
2. **Verhalten:** Aktiviert sich alle 5 Sekunden für 2 Sekunden.
3. **Platzierung:** Vor wichtigen Durchgängen oder in engen Gängen.

# Power-Ups

## Power-Up: "Gesundheitsherz" (Level 1)

- **Beschreibung:** Stellt 25 HP wieder her.
1. **Heilung:** 25 HP.
2. **Verfügbarkeit:** Häufiger in Level 1, 3 pro Level.
3. **Platzierung:** Auf leicht erreichbaren Plattformen.

## Power-Up: "Doppelter Schaden" (Level 2)

- **Beschreibung:** Verdoppelt den Schaden für 10 Sekunden.
1. **Effekt:** 2x Schaden.
2. **Dauer:** 10 Sekunden.
3. **Verfügbarkeit:** Einmal pro Level.
4. **Platzierung:** In gefährlichen Bereichen.

## Power-Up: "Unbesiegbarkeit" (Level 3)

- **Beschreibung:** Macht den Spieler für eine begrenzte Zeit unverwundbar.
1. **Effekt:** Unverwundbarkeit
   - Der Spieler kann für die Dauer des Power-Ups nicht von Gegnern oder Fallen verletzt werden.
2. **Dauer:** 5 Sekunden
   - Die Unbesiegbarkeit hält 5 Sekunden lang an.
3. **Verfügbarkeit:** 
   - In Level 3 taucht dieses Power-Up nur einmal auf, und zwar in einem schwer erreichbaren Bereich.
4. **Platzierung:** 
   - Auf einer schwer zugänglichen Plattform, die eine gefährliche Sprungsequenz erfordert.

## Power-Up: "Extra Leben" (Level 4)

- **Beschreibung:** Gewährt dem Spieler ein zusätzliches Leben.
1. **Effekt:** +1 Leben
   - Der Spieler erhält ein zusätzliches Leben, wenn er das Power-Up einsammelt.
2. **Verfügbarkeit:** 
   - Dieses Power-Up ist extrem selten und taucht nur einmal im gesamten Level 4 auf.
3. **Platzierung:** 
   - Versteckt in einem schwer zugänglichen Bereich oder hinter einer optionalen, schwierigen Herausforderung.

## Power-Up: "Energieexplosion" (Level 5)

- **Beschreibung:** Verursacht eine Welle von Energie, die alle Gegner auf dem Bildschirm beschädigt.
1. **Effekt:** 50 HP Schaden an allen Gegnern
   - Alle Gegner auf dem Bildschirm erleiden 50 HP Schaden, sobald das Power-Up aktiviert wird.
2. **Verfügbarkeit:** 
   - Dieses Power-Up erscheint nur einmal im Level 5 und ist äußerst wertvoll, um den Spieler bei der Überwindung schwieriger Gegnerwellen zu unterstützen.
3. **Platzierung:** 
   - In einer extrem gut versteckten, optionalen Zone, die nur durch Erkundung oder besondere Geschicklichkeit erreicht werden kann.

# Rätsel
### 1. Rätsel: 2 Platformen an einem Seilzug
Verhalten: Schießt man auf die eine Plattform sinkt sie nach unten und die andere steigt auf. Wenn kein Pfeil mehr in der Plattform ist oder auf die zweite Plattform geschossen wird gehen die Plattformen wieder in die Ursprungslage zurück. Dies soll für eine beliebige Anzahl von Pfeilen funktionieren (beide Plattformen gleich viele Pfeile = Ausgangslage, eine Plattform mehr Pfeile = Plattform sinkt, andere Plattform steigt)
Steht eine Holzkiste auf einer Plattform sinkt diese nach unten und kann durch Pfeile nichtmehr bewegt werden bis die Holzkiste weg ist.
Platzierung: im Level nahe genug beieinander 

### 2. Rätsel: Holzkiste: 
Verhalten: Eine Holzkiste kann von der Seite geschoben werden. Eine Holzkiste ist solide: Man kann nicht durch sie hindurch gehen und man kann auf der Kiste stehen. Wird eine Kiste über den Rand einer Plattform geschoben fällt sie nach unten. Eine Holzkiste kann verwendet werden um eine Druckplatte auszulösen.

### 3. Rätsel: Druckplatte
Verhalten: Steht ein Spieler auf einer Druckplatte oder schiebt eine Kiste auf die Druckplatte wird dadurch ein Event ausgelöst. Beispiele für Events sind: aufgehende Türen, erscheinende oder verschwindende Plattformen, Items etc.

## Totems für Spezialpfeile:
### Totem der Teleportation:
**Verhalten:** Steht der Spieler innerhalb eines Tiles um das Totem wird man beim nächsten Schuss an den Zielort des Pfeils teleportiert. Zum leichteren Zielen soll eine halb transparentes Spielsprite am Zielort erscheinen.

### Totem des Feuers
**Verhalten:** Solange der Spieler innerhalb eines Tiles um das Totem steht brennen die Pfeile. Diese verursachen Damage over Time (DoT) bei getroffenen Gegnern und können Kisten in Brand stecken.

### Totem des Eises
**Verhalten:**  Solange der Spieler innerhalb eines Tiles um das Totem steht frieren Pfeile Gegner, Wasserflächen und Plattformen ein. Eingefrorene Gegner können sich nicht bewegen, angreifen oder Spezialfähigkeiten einsetzten.
Plattformen die eingefroren sind bewegen sich nicht und lassen Spieler und NPCs über díe vereiste Fläche rutschen. Eingefrorene Wasserflächen können betreten werden und sind wie normale vereiste Plattformen rutschig.