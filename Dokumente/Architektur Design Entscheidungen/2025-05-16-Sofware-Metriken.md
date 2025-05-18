

# Metrik 1: Kopplung
## Jedes Scene und sein Script sollen maximal mit 3 anderen Scenes/Scripten gekoppelt sein

Alle Elemente sollen möglicht unabhängig von einander funktionieren, daher sollen Scripte und Scenes nicht auf andere Scripte und Scripte angewießen sein. Dies erhöht die Wartbarkeit sowie die Modularität. So können einzelne Gegner oder Gegenstände unabhängig von anderen in Leveln verwendet werde, oder auch nicht.


# Metrik 2: Kohäsion
## Der LCOM1 Wert jedes Scriptes soll unter 0,5 sein

Scenes die Scripte besitzen sollen ein möglichst hohe Kohäsion besitzen. Diese deutet darauf hin, dass Beispielsweise Variablen innerhalb der Scene von vielen Bestandteilen verwendet werden, sodass der Code nur an einer Stelle geändert werden muss.

Zur Berechnung von LCOM1 Wertes wird eine Matrix mit den Methoden auf der einen Achse und den verwendeten Variablen auf der anderen Achse erstellt und für jedes Feld eingetragen ob eine Verbindung existiert. Am Ende gechnet man Felder mit verbindungen / alle Felder.


# Metrik 3: Spielerzufriedenheit
## Die Spielerzufriedenheit soll insgesammt bei mindestend 4/5 liegen sowie in keinem Teilbereich unter 2,5/5

Die Spielerzufriedenheit ist ein elementarer Wert eines Spiels, wenn es keinen Spaß macht hat es seinen Daseinszweck verfehlt. Die Spielerzufriedenheit wird mit einer Umfrage gemessen.

# Metrik 4: Umfrageteilnehmer
## Mindestens fünf Personen sollen an der Umfrage teilnehmen

Eine zugeringe Teilnahme an der Umfrage macht diese unbrauchbar, da die Aussagekraft gering ist.


# Metrik 5: Zyklomatische Komplexität
## Die zyklomatische Komplexität jedes einzelnen Scripts soll maximal bei 10 liegen

Die zyklomatische Komplexität ist ein Maß für die Anzahl der unabhängig voneinander ausführbaren Pfade in einem Programm. Sie gibt Aufschluss darüber, wie komplex ein Script in Bezug auf seine Verzweigungen und Kontrollstrukturen ist. Ein hoher Wert erschwert das Testen und Verstehen des Codes und erhöht die Fehleranfälligkeit.

Ein Wert von maximal 10 stellt sicher, dass Scripte noch gut wartbar, testbar und verständlich bleiben.
