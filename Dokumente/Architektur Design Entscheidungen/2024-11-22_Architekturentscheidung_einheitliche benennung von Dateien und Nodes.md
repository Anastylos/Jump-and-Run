# Benennungsrichtlinie für Dateien, Scenes und Nodes

## Kontext und Problemstellung

Michi und Christoph haben eine halbe Stunde damit verbracht den Fehler in einem Timer zu finden, nur um festzustellen dass auf den falschen Timer zugegriffen wurde. Wenn hier sowieso schon Namenskonventionen notiert werden benennen wir hier auch noch einmal die Konvention für Dokumente.


## Betrachtete Varianten

* die unten genannte Entscheidung wurde ohne Betrachtung von Alternativen gewählt, Namenskonventionen sind ihrer Natur nach willkührlich

## Entscheidung

* Dokumente werden mit vorangestelltem ISO Format und einem Unterstrich (_) gespeichertNodes z.B. 2024-11-22-Architekturentscheidungen.md
* Scenes werden im Camelcase benannt (Binnenmajuskel) z.B. fireTotem
* Nodes bekommen den Namen seiner Scene bzw. seiner Parent Node vor den Standard Node Namen vorrangestellt gefolgt von einem Unterstrich (_) z.B. fireTotem_Node2D
* Mehrere gleiche Nodes sollen durch aufteilen in verschiedene Parent Nodes eindeutig zuzuordnen sein, wenn dies nicht möglich ist sollen alle Nodes dieses Typs hinter dem Node/Parent Namen eine weitere Beschreibung mit einem Unterstrich (_) erhalten z.B. fireTotem_burn_Timer und fireTotem_freeze_Timer. ein zusätzlicher fireTotem_Timer ohne eine zusätzlichen Deskriptor vor dem Standard Node Namen wäre nicht zulässig. 

## Status
vorgeschlagen, vorläufig gültig

## Konsequenzen

* Gut, weil {positive Konsequenz, z.B. Verbesserung einer oder mehrerer gewünschter Eigenschaften, …}
* Schlecht, weil {negative Konsequenz, z.B. Einschränkung einer oder mehrerer gewünschter Eigenschaften, …}
* … <!-- Anzahl der Konsequenzen kann variieren -->

* + Dokumente werden mit vorangestelltem ISO Format und einem Unterstrich (_) gespeichert, dadurch sind die Dateien sowohl auf dem PC als auch im GitHub sortiert und können dem entsprechenden Blog oder Scrum Zyklus zugeordnet werden.
* + Jede Node ist eindeutig benannt und kann daher nicht verwechselt werden. Dies macht den Code auch übersichtlicher wenn mehrere Programmierer an einer Scene arbeiten

