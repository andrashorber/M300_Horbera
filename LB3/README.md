# M300 - Plattformübergreifende Dienste in ein Netzwerk integrieren
29.06.2020
Version 1.0
András Horber
TBZ Technishce Berufsschule Zürich

## Dokumentation LB3
### Voraussetzungen
* aktuelle Installation von einem Typ2-Hypervisor (Hier [VMware Workstation](hhttps://my.vmware.com/de/web/vmware/downloads/info/slug/desktop_end_user_computing/vmware_workstation_pro/15_0))
* Eine Virtuelle Maschine mit Ubuntu (Hier [Ubuntu 20.04 Server](https://ubuntu.com/download/server/thank-you?version=20.04&architecture=amd64))
* Eine Virtuelle Maschine mit [OPNsense](https://opnsense.org/), um die Netze zu trennen und miteinander zu verbinden
  * NAT Portforwarding auf den Ubuntu Server ist eingerichtet auf Port 80
* Internetanschluss
* eine lokale Kopie vom [Repository](https://github.com/andrashorber/M300_Horbera.git)
* 

### Installation
* Starten der Ubuntu und OPNsense VM
* Shared Folder mit dem Namen "Docker" und dem Pfad "GITHUBREPO\LB3\Docker" erstellen
* Allenfalls auf Ubunntu den shared folder mounten: /mnt/Docker
* Überarbeiten Sie im Docker-compose.yml die wichtigsten Angaben so, dass es auf ihrer Umgebung kunktioniert
* Führen Sie in Ubuntu den Befehl _docker-compose up db01_ aus, damit die DB installiert und gestartet wird.
* Führen Sie in Ubuntu den Befehl _docker-compose up web01_ aus, damit Wordpress installiert und gestartet wird.


### Automatischer Vorgang ab docker-compose.yml

1. Mysql DB
   1. Installation von Mysql vom [mysql image](https://hub.docker.com/_/mysql)
   2. Konfiguration von Root-Password, DB und User
2. Wordpress
   1. Installation von Ubuntu20.04 vom [Ubuntu image](https://hub.docker.com/_/ubuntu)
   2. Definition von Argumenten und Variabeln
   3. Installation von Updates
   4. Erstellen eines Benutzers
   5. Installation von den benötigten paketen
   6. Installation und Konfiguration von WP-CLI
   7. Installation und Konfiguration von Wordpress
   8. Konfiguration von Wordpress Seite

### Testing
| Nr.  | Titel           | Soll-Situation                                                              | Ist-Situation                                                                                                                                      | Nachbearbeitung                                      |
| :--- | :-------------- | :-------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------- |
| 1    | All_Setup       | Die Container werden alle mit den richtigen Angaben aufgesetzt                 | Die Container werden alle mit den richtigen Angaben aufgesetzt                                                                                       | nein                                                 |
| 2    | Mysql_Port      | Der Msyql-Container exposed den Port 3306 und gibt den Port 3306 dem Host weiter   | Der Msyql-Container exposed den Port 3306 und gibt den Port 3306 dem Host weiter                                                                                                    | nein                                                 |
| 3    | Mysql_Volume    | Die Mysql-Daten werdenunter /Docker/mysql gespeichert | Die Mysql-Daten werdenunter /Docker/mysql gespeichert                                                                                             | nein                                                 |
| 4    | Mysql_User      | Der Mysql User, die DB und das Root-Passwort werden korrekt implementiert          | Der Mysql User, die DB und das Root-Passwort werden korrekt implementiert                                                                                           | nein                                                 |
| 5    | WEB_Port        | Der Webserver-Container exposed den Port 80 und gibt den Port 80 dem Host weiter       | Der Webserver-Container exposed den Port 80, gibt aber den Port 80 dem Host noch nicht weiter                                                                                      | Besprechung mit Herr Rohr bezüglich fehlerfindung.                                                 |
| 6    | Web_Volume      | Die Wordpress-Daten werden unter /Docker/web gespeichert                                  | Die Wordpress-Daten werden noch nicht unter /Docker/web gespeichert                                                                                             | Besprechung mit Herr Rohr bezüglich fehlerfindung.                                                  |
| 7    | Web_User       | Es wird ein User erstellt, ddamit wordpress nicht mit root-Rechten laufen muss        | Es wird ein User erstellt, ddamit wordpress nicht mit root-Rechten laufen muss                                                                               | nein                                                 |
| 8    | Web_Access      | Die Webseite ist über die IP des Routers und Port 80 aufrufbar        | Die Webseite ist über die IP des Routers und Port 80 aufrufbar                                                                               | nein                                                 |
| 9    | SSH_Access    | Die Verbindung mittels SSH ist nur vom Host-Netzwerk möglich                           | Die Verbindung mittels SSH ist nur vom Host-Netzwerk möglich                                                                                                  | nein                                                 |
| 10   | Run_Everywhere  | Das Docker-compose kann überall problemlos gestartet werden                               | Das Docker-compose kann nicht überall problemlos gestartet werden | Es sind viele Vorbereitungen und Umplanungen nötig, das Script muss teils der Umgebung angepasst werden. Jedoch wurde alles im Docker-compose.yml festgelegt, damit das dockerfile nicht angepasst werden muss. |

---
## Nachweise
### 1. Vorwissensstand
Mit Docker oder allgemein Containern habe ich noch nie gearbeitet. Wir arbeiten im Betrieb leider immer noch nur mit Virtuellen Maschinen, da Windows nicht so gut als Container funktionieren und wir allgemein immer mit grafischer Oberfläche arbeiten, was ich persönlich schade finde. Ich kenne Docker nur vom Namen und weiss etwa, wie es funktioniert und was es macht. Allgemein habe ich nur selten mit Containert zu tun, obwohl ich weiss, dass das die Zukunft sein wird. Auch ich will in meiner Umgebung zu Hause Docker einrichten, sodass ich Beispielsweise meine Webserver darauf lassenlaufen könnte. Denn so wird die Last viel besser aufgeteilt und ich muss nicht so viele VMs erstellen. Klar kann man mit Virtual-IPs arbeiten und mehrere Webserver auf einem Host laufen lassen, dies führt jedoch auch manchmal zu fehlern. Ist die Seite gut aufgebaut kann sie auch problemlos und ohne Unterbruch geupdatet werden, indem einfach ein neuer Container hochgezogen wird und der andere danach gekillt wird.

### 2. Lernschritte im Verlauf der LB
Anfangs hatte ich Mühe ins Thema zu kommen. Da ich Docker nur vom Namen gekannt habe und sonst noch nie was davon gehört habe, musste ich mich zuerst einlesen. Das ist aber in jedem Thema so, das ist klar. Danach habe ich mir wie üblich ein Ziel gesetzt, welches ich selber erreichen wollte. Ich wollte die Selbe Umgebung aufbauen wie bei der LB2, mit kleinen Änderungen: Ich wollte diesmal auf dem Proxy verzichten und stattdessen eine Router-VM einsetzen. Dies mit dem Gedanken, dass dies vielleicht dem heutigen Vorgehen ähneln könnte und das auch so mein Ziel wäre für meine eigene Umgebung zu Hause. Zudem kann auf einer OPNsense Router-VM auch HAProxy konfiguriert werden und die Netze sind besser untereinander geteilt. Zudem kann ich auch die Sicherheit damit erhöhen. Ich habe die Umgebung nun auf VMware umgestellt, da ich mich damit besser auskenne. So konnte ich die Netze komplett voneinander trennen und über die Firewall-VM den ssh-Zugriff besser steuern. Denn nun kommt man nur noch vom Host-Netzwerk per ssh in die Umgebung, nicht mehr von überall. Eine Weitere Änderung war, das ich von Anfang an nur auf eine Webserver-Container gesetzt habe und nicht auf 2. Die Daten lasse ich natürlich trotzdem raussschreiben, damit im Falle eines 2. Containers die Daten ausgetauscht werden können. Zudem war ein grosses Ziel von mir Kubernetes umzusetzen. Kubernetes ist eine Container-Verwaltungs-Lösung, die vor allem auf dem Master-Slave Prinzip arbeitet. Dass heisst der Master verteilt die Container, führt Commands aus und übernimmt das Netzwerk-Management. Die Slaves lassen nur die Container laufen und haben somit kaum was zu tun. Das macht vor allem Sinn, wenn mehrere slaves in verschiedenen Rechenzentren untergebracht sind, so ist ein Aufall für die aussenstehenden nicht zu bemerken.

### 3. Reflexion
Ich habe mich bei LB3 viel zu Lange mit Kubernetes beschäftigt. 8 Lektionen und noch einige weiteren Stunden in der Freiziet habe ich vergeblich versucht, Kubernetes zum Laufen zu bringen. Ettliche Quellen bin ich durchgerattert, da keine wirklich funktioniert hatte. Schlussendlich habe ich es doch noch hingekriegt, die Umgebung läuft und ich konnte sogar Kubernetes-Dashboard installieren, damit das ganze auf einer Grafischen Oberfläche überwacht werden kann und die Container dort erstellt werden könnten. Jetzt musste ich nur noch mein eigendliches Projekt umsetzen. Ich hate sehr viel Mühe mit dem Netzwerk-Management und den Volumes, das hat bei mir ich der Aufbau-Umgebung nicht so funktioniert. Den Fehler mit dem Volumes konnte ich beheben, inden ich einen anderen Pfad genommen hatte. Anscheinend kann Docker nicht mit VMwar Shared Folders arbeiten, zuminderst nicht reinschreiben. Das Netzwerkproblem war, dass mein Web-Container den DB-Container nicht erreichen konnte. Ich bin nicht ganz zu frieden mit dem Ergebniss, hätte gerne noch mehr umgesetzt. Ich habe mein Vorhaben wieder komplett überschätzt. Ich hoffe jedoch trotzdem auf eine gute Note und dass ich vielleicht mit Kubernete einige Zusatzpunkte herausholen kann.

---
## Nachweise Bewertungskriterien

### 1. K1 Umbebung auf eigenem Notebook eingerichtet und funktionsfähig
#### 1.1 VirtualBox
![IMG_Virtualbox](/images/K1_Virtualbox.jpg)
#### 1.2 Vagrant
![IMG_Vagrant](/images/K1_Vagrant.jpg)
#### 1.3 Visualstudio-Code
![IMG_VSCode](/images/K1_VSCode.jpg)
#### 1.4 Git-Client
![IMG_GitGui](/images/K1_GitGui.jpg)
#### 1.5 SSH-Key für Client erstellt
![IMG_GitGui](/images/K1_SshKey.jpg)

### 2. K2 Eigene Lernumgebung (PLE) ist eingerichtet
#### 1.1 GitHub oder Gitlab-Account ist erstellt
![IMG_GitHubAccount](/images/K2_GitHubAccount.jpg)
#### 2.2 Git-Client wurde verwendet
![IMG_GitGui](/images/K2_GitGui.jpg)
#### 2.3 Dokumentation ist als Mark Down vorhanden
![IMG_DocAsMarkdown](/images/K2_DokAsMarkdown.jpg)
#### 2.4 Mark down-Editor ausgewählt und eingerichtet
![IMG_DocAsMarkdown](/images/K2_Markdown_Extension.jpg)
#### 2.5 Mark down ist strukturiert
![IMG_DocAsMarkdown](/images/K2_DokAsMarkdown.jpg)
#### 2.6 Persönlicher Wissenstand im Bezug auf die wichtigsten Themen sind dokumentiert
[Vorwissensstand](#1-vorwissensstand)
#### 2.7 Wichtige Lernschritte sind dokumentiert
[Lernschritte](#2-lernschritte-im-verlauf-der-lb)

### 3. K3 
#### 3.1 Bestehenden Docker-Container kombinieren
![IMG_DocAsMarkdown](/images/LB3_K3_UsedContainerTemplate.jpg)
Hier wurde ein bestehender Container mysql:latest verwendet und mit einer Wordpress-Site verknüpft.
#### 3.2 Bestehende Container als Backend, Desktop-App als Frontend einsetzen
Ein Wordpress Container und ein Mysql Container werden als Backend verwendet, Google Chrome wird als Frontend verwendet, um die Webseite anzuzeigen.
#### 3.3 Volumes zur persistenten Datenablage eingerichtet
![IMG_DocAsMarkdown](/images/LB3_K3_Volumes1.jpg)
![IMG_DocAsMarkdown](/images/LB3_K3_Volumes2.jpg)
#### 3.4 Kennt die Docker spezifischen Befehle
- **docker build** Build an image from a Dockerfile
- **docker image** Manage images
- **docker pull** Pull an image or a repository from a registry
- **docker tag** Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
- **docker push** Push an image or a repository to a registry
- **docker container** Manage containers
  - **docker container run** Run a command in a new container
  - **docker container pause** Pause all processes within one or more containers
  - **docker container stop** Stop one or more running containers
  - **docker container start** Start one or more stopped containers
  - **docker container create** Create a new container
  - **docker container exec** Run a command in a running container
- **docker network ls** List the networks
- **docker ps** List containers
#### 3.5 Eingerichtete Umgebung ist dokumentiert
[Dokumentation](#dokumentation-lb3)<br>
![Networkplan](/images/LB3_K3_Networkplan.jpg)
#### 3.6 Funktionsweise getestet inkl. Dokumentation der Testfälle
[Testing](#testing)
#### 3.7 Projekt mit Git und Markdown dokumentiert
![IMG_DocAsMarkdown](/images/LB3_K3_DokAsMarkdown.jpg)
[Doku in Git](#3-k3)

### 4. K4 Sicherheitsaspekte sind implementiert
#### 4.1 Service-Überwachung ist eingerichtet
![IMG_DocAsMarkdown](/images/LB3_K4_monitoring.jpg)
CAdvisor wurde erfolgreich implementiert und ist über die Firewall mit dem Port 8080 erreichbar. Somit kann auch extern die Auslastung der Hardware und der Container überwacht werden.
#### 4.2 Aktive Benachrichtigung ist eingerichtet
Es wurde keine aktive Benachrichtigung eingerichtet, da es sich um ein Testsystem mit Mysql und Wordpress handelt. Ein Testsystem kann mehrmals neu gestartet werden und muss nicht 24/7 online sein.
#### 4.3 mind. 3 Aspekte der Container-Absicherung sind berücksichtigt
- Die Container laufen auf einer Virtuellen Maschine mit begrenzten HW-Ressourcen
- Die VM ist hinter einr OPNsense Firewall, welche die Netze voneinander trennt
- Die VM ist hinter einr OPNsense Firewall, welche ebenfalls als DDos-Schutz fungiert.
- Die Wordpress-Instans wird ab dem Ubuntu Image manuell aufgebaut. So wird die Manipulationsmöglichkeit und die Fehleranfälligkeit eingeschränkt
- SSH Zugriff ist nur vom Host-Netzwerk aus möglich.
- Beide Container werden mit dedizierten Usern installiert: Mysql mit dem user mysql, Webserver mit dem im docker-compose definierten User (hier Docker)
- Mysql und Wordpress haben einen Passwort-Schutz integriert, somit kann niemand ohne Passwort zugreifen.
- Die Daten werden ausserhalb des Containers gespeichert, falls doch etwas passieren würde.
#### 4.4 Sicherheitsmassnahmen sind dokumentiert
[Doku in Git](#41-service-überwachung-ist-eingerichtet)
[Doku in Git](#42-aktive-benachrichtigung-ist-eingerichtet)
[Doku in Git](#43-mind-3-aspekte-der-container-absicherung-sind-berücksichtigt)
Port-Matrix Firewall:
| Sourc\Destination | Hostsystem | WAN  | Firewall                 | Docker Web | Docker Mysql |
| :---------------- | :--------- | :--- | :----------------------- | :--------- | :----------- |
| Hostsystem        | x          | any  | 22/TCP, 80/TCP, 8080/TCP | -          | -
| WAN               | -          | x    | 22/TCP, 80/TCP, 8080/TCP | -          | -
| Firewall          | -          | any  | x                        | 80/TCP     | -
| Docker Web        | -          | any  | any                      | x          | 3306/tcp
| Docker Mysql      | -          | any  | aly                      | -          | x
#### 4.5 Projekt mit Git und Markdown dokumentiert
![IMG_DocAsMarkdown](/images/LB3_K4_DokAsMarkdown.jpg) <br>
[Doku in Git](#4-k4-sicherheitsaspekte-sind-implementiert)

### 5. K5 Zusätzliche Bewertungspunkte allgemein
#### 5.1 Allgemein
##### 5.1.1 Kreativität
Wordpress ist das bekannteste und am weitesten verbreitete CMS auf der ganzen Welt. Duzende Webserver werden täglich mit einer neuen Wordpress installation veröffentlicht. Daher bietet sich eine automatische Installation durch so ein Script natürlich sehr an. Mit einer fertigen Umgebung in form von einem Code (IaaC) kann Wordpress nur innert wenigen Minuten betriebsbereit gemacht werden. Zudem ist die Umgebung mittels Docker innert Sekunden aufgebuat und kann beliebig reproduziert werden.
##### 5.1.2 Komplexität
Wordpress wurde mittels wp-cli installiert. wp-cli ist das am weitesten verbreitete Tool, um eine Webseite über das CLI verwalten zu können. Dies ist besonders in Docker sehr wichtig, da die Container alle auf CLI beruhen und es keine grafische Oberfläche hat. Zudem kann so auch von weitem aus mittels ssh zugegriffen werden und wp-admin kann so beihnahe ausgeschaltet werden, was im Allgemienen eine Sicherheitslücke in Wordpress darstellt
##### 5.1.3 Umfang
Durch den Aufbau von Kuberntes mit einem Master und 4 Slaves sehe ich den Umfang als recht gross, auch wenn diese schlussendlich leider nicht zum Einsatz kommen konnten. Zudem wurde auf Kubernetes noch das Dashboard integriert, damit eine grafische Überwachung stattfinden kann. Zudem wurde eine Router-VM davor geschaltet, damit die Sicherheit noch höher angesetzt werden kann.
#### 5.2 Umsetung
##### 5.2.1 Übungsdokumentation als Vorlage für Modul-Unterlagen erstellt
Die Installation und das Script wurde so geschrieben, dass jeder dies Nachbauen kann.
Zudem sind noch einige Punkte für Troubleshooting integriert, wenn die Installation und das Aufstarten der VMs zu Problemen führt.
#### 5.3 Persönliche Lernentwicklung
##### 5.3.1 Vergleich Vorwissen - Wissenszuwachs
[Vorwissensstand](#1-vorwissensstand)
[Wissenszuwachs](#2-lernschritte-im-verlauf-der-lb)
##### 5.3.2 Reflexion
[Reflexion](#3-reflexion)


### 6. K6 Zusätzliche systemtechnische Bewertungspunkte
#### 6.1 Umfangreiche Vernetzung der Container-Infrastruktur
![Networkplan](/images/LB3_K3_Networkplan.jpg)
#### 6.2 Image-Bereitstellung
Damit das Image immer auf dem aktuellen Stand ist, wird der Webserver immer neu erstellt. bei der Image-Bereitstellung kann es gut vorkommen, dass es Image zu alt ist. Daher wird auf eine fertige Bereitstellung verzichtet.
Das Script und alle Unterlagen sind jedoch auf Github unter [LB3 --> Docker](/LB3/Docker) einsehbar.
#### 6.3 Continuous Integration
Continuous Intergration wurde nicht eingeführt, da die Umgebung mit Wordpress und der Datenbank nur Testsysteme sind, die schnell auzfusetzen sein müssen. Für Produktivsysteme und Hochverfügbarkeit wäre eine Continuous Intergration jedoch zu empfehlen.
#### 6.4 Cloud-Integration
Es wurde kein IaaS Verwendet
#### 6.5 Elemente aus Kubernetesübung sind umgesetzt und dokumentiert
Kubernetes wurde installiert auf einem Mastersystem und 4 Slaves. Zudem wurde noch Kubernetes GUI installiert, damit Kubernetes über die graphische Oberfläche gesteuert werden kann.
![IMG_KubernetesGUI](/images/LB3_K6_Kubernetes.jpg)