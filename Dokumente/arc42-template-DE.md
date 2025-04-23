#Architektur des Projektes Jump and Run
# KAPITEL 1: Einführung und Ziele

Ziel des Projektes ist es ein Jump and Run Spiel zu entwickeln. Im Spiel soll man verschiedene Gegner bekämpfen und Rätsel lösen.
Die aktuellen Mindestfeatures sind im Kanban Board hinterlegt, für die Umsetzung weiterer Features soll auf das Designdokument zugegriffen werden:  
https://github.com/Anastylos/Jump-and-Run/blob/main/Dokumente/SRS_Gamedesign.md
Das Erstellen von Leveln soll Priorität haben vor der Implementierung optionaler Features.

Die verwendete Engine ist Godot 4.4

## Qualitätsziele

Fokus der Entwicklung soll der Spielspaß sein, insbesondere Bugs die den Spielspaß stören müssen beseitigt werden.
Es werden explizit keine Anforderungen an die Spielzeit gestellt, Qualität ist wichtiger als Quantität.

weitere Ziele siehe: https://github.com/Anastylos/Jump-and-Run/discussions/35

## Stakeholder

Die Rollen im Team sind folgende:

Techlead:       JustMischka      
Organisator:    Anastylos        
Leveldesign:    DonKir15         
Leveldesign:    ktoffel999      



# KAPITEL 2: Randbedingungen

Dieses Projekt entseht im Rahmen des dualen Studiums an der DHBW und unterliegt daher folgenden Einschränkungen:

- zeitliche Einschränkungen: Software Engineering ist nur eines von sechs Fächern wodurch der zeitliche Umfang begrenzt ist.
- Deadline Semesterende: Mit dem Ende des Semesters muss ein fertiges Spiel präsentiert werden können.
- Keine externe Hilfe: Im Gegensatz zu einem Unternehmen ist es nicht möglich Hilfe aus anderen Abteilungen uoder von         freelancern etc. zu erhalten
  
# KAPITEL 3: Kontextabgrenzung 

**Inhalt**

externe Schnittstellen 
Verantwortlichkeit (scope)
Ihres Systems: Welche Verantwortung trägt das System und welche
Verantwortung übernehmen die Nachbarsysteme?

Da es sich bei dem Spiel um ein reines Singleplayer Spiel handelt, mit Godot als einziger verwendeter Engine ist die Abgrenzung der Kontexte sehr simpel.

## Fachlicher Kontext

### Spieler
- Kommunikationsbeziehung: Spielt das Spiel
- Eingabe: Schießt auf Gegner, interagiert mit Rätseln, speichert zwischenstände, wechselt Level
- Ausgabe: Speicherstände, optional Leaderboard

## Technischer Kontext 

Sämtliche technischen Anforderungen sind mit Hilfe der Godot Engine umzusetzen.

# KAPITEL 4: Lösungsstrategie 

Organisatorische Grundsätze:
- Das Spiel wird mit der Godot Engine entwickelt, für dieses Projekt wird die Version 4.4. verwendet, ein upgrade auf neue versionen ist möglich, aber nicht notwendig
- Bei der Einbindung von Assets (Bilder, Musik, Logik etc.) muss die Lizenzbedingung im jeweiligen Ordner mit hinterlegt sein um bei einer eventuellen komerziellen Veröffentlichung die Assets entweder zu tauschen oder den Rechteinhalber bezahlen zu können
- weitere Architekturentscheidungen finden sich unter: https://github.com/Anastylos/Jump-and-Run/tree/main/Dokumente/Architektur%20Design%20Entscheidungen

Gamedesign Entscheidungen:
- das Spiel soll aus modularen, kurzen Leveln bestehen die zu mindestens einem großen Level kombiniert werden


# KAPITEL 5: Bausteinsicht


Die Bausteinsicht ist eine hierarchische Sammlung von Blackboxen und
Whiteboxen (siehe Abbildung unten) und deren Beschreibungen.

**Ebene 1** ist die Whitebox-Beschreibung des Gesamtsystems, zusammen
mit Blackbox-Beschreibungen der darin enthaltenen Bausteine.

**Ebene 2** zoomt in einige Bausteine der Ebene 1 hinein. Sie enthält
somit die Whitebox-Beschreibungen ausgewählter Bausteine der Ebene 1,
jeweils zusammen mit Blackbox-Beschreibungen darin enthaltener
Bausteine.

**Ebene 3** zoomt in einige Bausteine der Ebene 2 hinein, usw.

## Whitebox Gesamtsystem

Im Rahmen eines Spieles gibt es viele Elemente die mit einander Interagieren, die wichtigsten sind im folgenden Diagramm beschrieben:

![image](https://github.com/Anastylos/Jump-and-Run/blob/main/Dokumente/Bilder/2024-11-05_UML_Klassendiagramm.PNG)


## Ebene 2 


### Whitebox Totem 

Das Totem ist eine spezielle Mechanik die eine Besonderheit dieses Spiels ist. Die Philosophie hinter dem Totem ist es Variation in das Spiel zu bringen oder die Komplexität zu erhöhen. Die gleiche Schussaktion die im normalen Spielablauf verwendet wird bekommt hier weitere Interaktionsmöglichkeiten.

Solange der Spieler in der Nähe eines entsprechenden Totems ist zeigt das Totem durch visuelle Effekte an das es aktiv ist. Pfeile haben zusätzliche Effekte solange das Totem aktiv ist

![gif](https://github.com/Anastylos/Jump-and-Run/blob/main/Dokumente/Video%20Dateien/2024-11-19_Gegner_verbrennen.gif)


## Ebene 3

### Whitebox Auswirkungen der verschiedenen Totems

### Totem der Teleportation:
**Verhalten:** Steht der Spieler innerhalb eines Tiles um das Totem wird man beim nächsten Schuss an den Zielort des Pfeils teleportiert. Zum leichteren Zielen soll eine halb transparentes Spielsprite am Zielort erscheinen.

### Totem des Feuers
**Verhalten:** Solange der Spieler innerhalb eines Tiles um das Totem steht brennen die Pfeile. Diese verursachen Damage over Time (DoT) bei getroffenen Gegnern und können Kisten in Brand stecken.

### Totem des Eises
**Verhalten:**  Solange der Spieler innerhalb eines Tiles um das Totem steht frieren Pfeile Gegner, Fallen, Wasserflächen und Plattformen ein. Eingefrorene Gegner können sich nicht bewegen, angreifen oder Spezialfähigkeiten einsetzten.
Fallen lösen nicht aus.
Plattformen die eingefroren sind bewegen sich nicht und lassen Spieler und NPCs über díe vereiste Fläche rutschen. Eingefrorene Wasserflächen können betreten werden und sind wie normale vereiste Plattformen rutschig.


# KAPITEL 6: Laufzeitsicht

Da das komplette Spiel in Godot programmiert wird gibt es keine Interaktionen zwischen verschiedener Software oder Hardware.
Alle hier beschriebenen Abläufe beziehen sich auf die Spiellogik.

## Spieler/Gegner interaktion

Ein Ereignis das beim Spiel häufig auftritt ist das Angreifen von Gegnern, hier schematisch dargestellt

![image](https://github.com/Anastylos/Jump-and-Run/blob/main/Dokumente/Bilder/SequenceDiagrammPlayerEncountersEnemy.drawio.png)


Ein weiteres Ereignis das beim Spiel auftretten wird, ist das Beenden des Playgrounds und der Übergang zum Level, hier schematisch dargestellt.

![image](https://github.com/Anastylos/Jump-and-Run/blob/main/Dokumente/Bilder/SequenceDiagrammPlayerFinishsPlayground.drawio.png)

# KAPITEL 7: Verteilungssicht {#section-deployment-view}

![image](https://github.com/user-attachments/assets/179c60af-5489-4cf5-8b46-6816ea246d53)

## Schicht 1: Hardware
Die unterste Schicht in der Architektur deines Spiels ist die Hardware. Sie umfasst das physische Gerät, auf dem das Spiel ausgeführt wird – zum Beispiel ein PC, Laptop oder eine Konsole. Diese Schicht stellt sämtliche technischen Ressourcen bereit, die für das Spiel erforderlich sind: Prozessor, Arbeitsspeicher, Grafikchip, Festplatte und Ein- und Ausgabeschnittstellen. Die Hardware ist die Grundlage, auf der alle anderen Komponenten aufbauen, und ermöglicht die tatsächliche Ausführung des Spiels.

## Schicht 2: Laufzeitumgebung – Godot Engine
Über der Hardware liegt die Laufzeitumgebung, konkret die Godot Engine, die mit dem Spiel exportiert wurde. Diese Engine wird zur Laufzeit gestartet und übernimmt sämtliche systemnahen Aufgaben: sie rendert die Grafiken, berechnet Kollisionen und Physik, spielt Sounds ab, verwaltet die Szenen und nimmt Eingaben entgegen. Die Godot Engine stellt sozusagen die technische Plattform dar, auf der das Spielgeschehen umgesetzt wird. Ohne diese Umgebung könnten deine Skripte und Inhalte gar nicht interpretiert oder dargestellt werden.

## Schicht 3: Anwendung
In der Anwendungsschicht befindet sich das eigentliche Spiel, also die Inhalte und die Logik, die du als Entwickler erstellt hast. Dazu zählen sämtliche GDScript-Dateien, die Spielfunktionen wie Steuerung, Gegnerverhalten oder Punktesysteme umsetzen. Auch die grafischen und akustischen Ressourcen – wie Sprites, Tilesets, Sounds und Musik – gehören zu dieser Ebene. Falls dein Spiel Spielstände oder Einstellungen lokal speichert, geschieht das ebenfalls in dieser Schicht. Hier entsteht das, was der Spieler letztlich erlebt: die Spielwelt, die Regeln und das Gameplay.

## Schicht 4: Interaktion 
Die oberste Schicht beschreibt die Interaktion zwischen dem Spieler und dem Spiel. Eingabegeräte wie Tastatur, Maus, Gamepad oder Touchscreen gehören in diese Ebene. Der Spieler gibt über diese Geräte Befehle ein, etwa indem er eine Taste zum Springen drückt. Diese Eingaben werden von der Engine erkannt und an die Anwendungsschicht weitergeleitet, wo sie von der Spiellogik verarbeitet werden. Diese Interaktionsschicht ist essenziell dafür, dass der Spieler überhaupt Einfluss auf das Spiel nehmen kann.


# KAPITEL 8: Querschnittliche Konzepte {#section-concepts}

::: formalpara-title
**Inhalt**
:::

Dieser Abschnitt beschreibt übergreifende, prinzipielle Regelungen und
Lösungsansätze, die an mehreren Stellen (=*querschnittlich*) relevant
sind.

Solche Konzepte betreffen oft mehrere Bausteine. Dazu können vielerlei
Themen gehören, beispielsweise:

-   Modelle, insbesondere fachliche Modelle

-   Architektur- oder Entwurfsmuster

-   Regeln für den konkreten Einsatz von Technologien

-   prinzipielle --- meist technische --- Festlegungen übergreifender
    Art

-   Implementierungsregeln

::: formalpara-title
**Motivation**
:::

Konzepte bilden die Grundlage für *konzeptionelle Integrität*
(Konsistenz, Homogenität) der Architektur und damit eine wesentliche
Grundlage für die innere Qualität Ihrer Systeme.

Manche dieser Themen lassen sich nur schwer als Baustein in der
Architektur unterbringen (z.B. das Thema „Sicherheit").

::: formalpara-title
**Form**
:::

Kann vielfältig sein:

-   Konzeptpapiere mit beliebiger Gliederung,

-   übergreifende Modelle/Szenarien mit Notationen, die Sie auch in den
    Architektursichten nutzen,

-   beispielhafte Implementierung speziell für technische Konzepte,

-   Verweise auf „übliche" Nutzung von Standard-Frameworks
    (beispielsweise die Nutzung von Hibernate als Object/Relational
    Mapper).

::: formalpara-title
**Struktur**
:::

Eine mögliche (nicht aber notwendige!) Untergliederung dieses
Abschnittes könnte wie folgt aussehen (wobei die Zuordnung von Themen zu
den Gruppen nicht immer eindeutig ist):

-   Fachliche Konzepte

-   User Experience (UX)

-   Sicherheitskonzepte (Safety und Security)

-   Architektur- und Entwurfsmuster

-   Unter-der-Haube

-   Entwicklungskonzepte

-   Betriebskonzepte

![Possible topics for crosscutting
concepts](images/08-concepts-DE.drawio.png)

Siehe [Querschnittliche Konzepte](https://docs.arc42.org/section-8/) in
der online-Dokumentation (auf Englisch).

## *\<Konzept 1>* {#__emphasis_konzept_1_emphasis}

*\<Erklärung>*

## *\<Konzept 2>* {#__emphasis_konzept_2_emphasis}

*\<Erklärung>*

...

## *\<Konzept n>* {#__emphasis_konzept_n_emphasis}

*\<Erklärung>*

# KAPITEL 9: Architekturentscheidungen

Die bisEntscheidung desher beschriebenen Architekturentscheidungen wurden aus folgenden Gründen getroffen:
- Ein 2D Spiel wurde gewählt da es einfacher ist als ein 3D Spiel und Jump and Run ist ein bekanntes und vielfältiges Genre, das es ermöglicht kreativ zu werden, und gleichzeitig mit einem klassischen Spielkonzept einen ausgereiften Prototypen erstellen zu können.
- Eine Engine für das Spiel wurde gewählt um den Prozess zu vereinfachen und sich auf das erstellen des Spiels fokusieren zu können
- Godot wurde als engine gewählt, da es kostenlos und open source ist und gerade auch für 2D Spiele sehr gut geeignet ist.
- Die Entscheidung den Prototyp aus modularen Leveln zu bauen wurde getroffen, da dadurch alle parallel am Spiel arbeiten können ohne von einander abhängig zu sein.

# KAPITEL 10: Qualitätsanforderungen {#section-quality-scenarios}

## Qualitätsbaum

<img width="471" alt="image" src="https://github.com/user-attachments/assets/21d0eaf7-f660-4cd2-9284-897a8552a8b0" />


## Qualitätsszenarien 

Hohes Prioritätsszenario 1: A30 - Intuitives Design
Benutzerfreundlichkeit ist ein zentraler Faktor für den Erfolg eines Spiels. Ein ansprechendes und leicht zugängliches Design sorgt dafür, dass die Spieler sich schnell zurechtfinden und eine positive Spielerfahrung haben.

Hohes Prioritätsszenario 2: C10 - Distributionsplattform
Die Wahl einer geeigneten Plattform wie Steam oder Epic Games Store ist essenziell, um das Spiel einem breiten Publikum zugänglich zu machen. Da es sich um ein reines PC-Spiel handelt, sollte der Fokus auf Plattformen mit einer hohen Reichweite und gutem Community-Support liegen.

# KAPITEL 11: Risiken und technische Schulden {#section-technical-risks}

::: formalpara-title
**Inhalt**
:::

Eine nach Prioritäten geordnete Liste der erkannten Architekturrisiken
und/oder technischen Schulden.

> Risikomanagement ist Projektmanagement für Erwachsene.
>
> ---  Tim Lister Atlantic Systems Guild

Unter diesem Motto sollten Sie Architekturrisiken und/oder technische
Schulden gezielt ermitteln, bewerten und Ihren Management-Stakeholdern
(z.B. Projektleitung, Product-Owner) transparent machen.


Im Folgenden eine nach Priorität geordnete Liste der identifizierten Risiken im Projekt:

---

## R1 – Zeitmangel durch parallele Studieninhalte

**Beschreibung:**  
Die Teammitglieder sind durch das duale Studium stark eingebunden, wodurch sich Entwicklungszeiten stark verkürzen.

**Auswirkung:**  
Feature-Fertigstellung kann sich verzögern, Release-Termin am Semesterende ist gefährdet.

**Wahrscheinlichkeit:** Hoch

**Maßnahmen:**
- Fokus auf MVP (Minimal Viable Product)
- Frühzeitige Feature-Freeze-Termine
- Nutzung des Kanban-Boards zur Organisation
- Reduktion nicht kritischer Features

---

## R2 – Bugs durch komplexe Interaktionen (z. B. Totems, Rätsel, Gegnerverhalten)

**Beschreibung:**  
Durch die Vielzahl interaktiver Gameplay-Mechaniken (z. B. Feuerpfeile + Holzkisten + Gegner) können unerwartete Fehler auftreten.

**Auswirkung:**  
Instabilitäten, Softlocks oder Frustration beim Spieler.

**Wahrscheinlichkeit:** Hoch

**Maßnahmen:**
- Modularisierung der Systeme
- Testszenarien für jede Kombination
- Eigenes Testlevel für Totems und Rätsel
- Interne Playtests in jeder Sprintphase

---

## R3 – Unerfahrener Umgang mit Godot 4.4

**Beschreibung:**  
Einige Teammitglieder haben wenig Erfahrung mit der Engine, was die Entwicklung verlangsamen kann.

**Auswirkung:**  
Ineffizienter Code, fehlerhafte Implementierungen, Reibungsverluste.

**Wahrscheinlichkeit:** Mittel bis Hoch

**Maßnahmen:**
- Verteilung der Aufgaben nach Kenntnisstand
- Pair Programming und Code-Reviews
- Interne Mini-Schulungen und Wissensdokumentation
- Austausch zwischen den Teammitgliedern

---

## R4 – Unzureichendes Balancing von Gegnerstärke, Fallen und Power-Ups

**Beschreibung:**  
Ein unausgewogenes Spiel kann entweder zu leicht oder zu schwer sein.

**Auswirkung:**  
Spieler verlieren schnell das Interesse oder brechen ab.

**Wahrscheinlichkeit:** Mittel

**Maßnahmen:**
- Testspieler aus anderen Gruppen einladen
- Metriken für Schaden, Reichweite, Frequenz definieren
- Kontrollierte Progression bei Gegnerfähigkeiten
- Sichtbare Wirkung von Power-Ups und Schaden

---

## R5 – Unklare Aufgabenverteilung im Team

**Beschreibung:**  
Bei parallelem Arbeiten an Levels und Mechaniken besteht die Gefahr von Überschneidungen oder Lücken.

**Auswirkung:**  
Doppelte Arbeit oder nicht zueinander passende Spielbereiche.

**Wahrscheinlichkeit:** Mittel

**Maßnahmen:**
- Regelmäßige Stand-ups
- Nutzung von GitHub Issues und Projekt-Boards
- Verantwortlichkeiten klar benennen
- Gemeinsamer Kalender für Deadlines und Meilensteine

---

## R6 – Asset-Lizenzprobleme

**Beschreibung:**  
Assets ohne korrekte Lizenzangaben können eine spätere Veröffentlichung blockieren oder rechtliche Folgen haben.

**Auswirkung:**  
Assets müssen nachträglich ersetzt oder entfernt werden.

**Wahrscheinlichkeit:** Mittel

**Maßnahmen:**
- Lizenzprüfung bei jedem Asset-Import
- Verwendung nur von CC0, CC-BY oder käuflich erworbenen Assets
- Lizenzdateien im jeweiligen Asset-Ordner speichern

---

## R7 – Feature Creep (ungeplante Erweiterungen)

**Beschreibung:**  
Im Laufe der Entwicklung könnten immer neue Ideen hinzukommen, die das Projekt überfrachten.

**Auswirkung:**  
Zeitliche Überlastung, MVP wird vernachlässigt, Chaos in der Projektstruktur.

**Wahrscheinlichkeit:** Mittel

**Maßnahmen:**
- Feature-Freeze nach MVP
- Zusätzliche Ideen besprechen
- Nur Features umsetzen, die im Designdokument definiert sind
- Designentscheidungen dokumentieren und kommunizieren


# KAPITEL 12: Glossar {#section-glossary}

::: formalpara-title
**Inhalt**
:::

Die wesentlichen fachlichen und technischen Begriffe, die Stakeholder im
Zusammenhang mit dem System verwenden.

Nutzen Sie das Glossar ebenfalls als Übersetzungsreferenz, falls Sie in
mehrsprachigen Teams arbeiten.

::: formalpara-title
**Motivation**
:::

Sie sollten relevante Begriffe klar definieren, so dass alle Beteiligten

-   diese Begriffe identisch verstehen, und

-   vermeiden, mehrere Begriffe für die gleiche Sache zu haben.

Zweispaltige Tabelle mit \<Begriff> und \<Definition>.

Eventuell weitere Spalten mit Übersetzungen, falls notwendig.

Siehe [Glossar](https://docs.arc42.org/section-12/) in der
online-Dokumentation (auf Englisch!).

+-----------------------+-----------------------------------------------+
| Begriff               | Definition                                    |
+=======================+===============================================+
| *\<Begriff-1>*        | *\<Definition-1>*                             |
+-----------------------+-----------------------------------------------+
| *\<Begriff-2*         | *\<Definition-2>*                             |
+-----------------------+-----------------------------------------------+
