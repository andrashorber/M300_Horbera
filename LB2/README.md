# M300 - Plattformübergreifende Dienste in ein Netzwerk integrieren

## Dokumentation LB2
### Voraussetzungen
* aktuelle Installation von [Virtualbox](https://www.virtualbox.org)
* aktuelle Installation von [Vagrant](https://www.vagrantup.com/)
* Internetanschluss
* eine lokale Kopie vom [Repository](https://github.com/andrashorber/M300_Horbera.git)
* [Git Bash](https://git-scm.com/downloads) oder ähnliches terminal, aus der Vagrant und das Vagrantfile gestartet werden können.
* 2GB freien RAM und 30GB Speicherplatz

### Installation
* Starten Sie Git Bash
* Wechseln Sie mittels cd in die lokale Kopie des Repository und danach in den Ordner LB2
* Führen Sie den Befehl _vagrant up_ aus, damit die VMs installiert und gestartet werden.
* Innert wenigen Minuten ist die Wordpress installation fertig

### Automatischer Vorgang
1. Proxy VM
   1. Installation von Ubuntu/bionic64
   2. Installation von Updates
   3. Installation der UFW Firewall
   4. Konfiguration der UFW Firewall Schritt 1
   5. Installation von HAProxy
   6. Konfiguration von HAProxy
   7. Konfiguration der UFW Firewall Schritt 2
2. DB VM
   1. Installation von Ubuntu/bionic64
   2. Installation von Updates
   3. Installation der UFW Firewall
   4. Konfiguration der UFW Firewall Schritt 1
   5. Installation von debconf-utils
   6. Konfiguration von debconf-utils
   7. Installation von Mysql-server
   8. Konfiguration von Mysql Server
   9. Erstellung und Konfiguration von Mysql Datenbank
   10. Konfiguration der UFW Firewall Schritt 2
3.  Web VM
    1.  Installation von Ubuntu/bionic64
    2.  Installation von Updates
    3.  Installation der UFW Firewall
    4.  Konfiguration der UFW Firewall Schritt 1
    5.  Installation von apache2, php, mysql-client und php-mysql
    6.  Installation und Konfiguration von WP-CLI
    7.  Installation und Konfiguration von Wordpress
    8.  Konfiguration von Wordpress Seite
    9.  Konfiguration der UFW Firewall Schritt 2

### Testing
| Nr.  | Titel           | Soll-Situation                                                              | Ist-Situation                                                                                                                                      | Nachbearbeitung                                      |
| :--- | :-------------- | :-------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------- |
| 1    | All_Setup       | Die VMs werden alle mit den richtigen HW-Angaben aufgesetzt                 | PDie VMs werden alle mit den richtigen HW-Angaben aufgesetzt                                                                                       | nein                                                 |
| 2    | All_Provision   | Die VMs laufen alle das [default.sh](LB2/Scripts/default.sh) script durch   | Die VMs laufen alle das default.sh script durch                                                                                                    | nein                                                 |
| 3    | Proxy_Provision | Die Proxy-VMs laufen alle das [proxy.sh](LB2/Scripts/proxy.sh) script durch | Die VMs laufen alle das default.sh script durch                                                                                                    | nein                                                 |
| 4    | DB_Provision    | Die DB-VMs laufen alle das [db.sh](LB2/Scripts/db.sh) script durch          | Die VMs laufen alle das default.sh script durch                                                                                                    | nein                                                 |
| 5    | WEB_Provision   | Die Web-VMs laufen alle das [web.sh](LB2/Scripts/web.sh) script durch       | Die VMs laufen alle das default.sh script durch                                                                                                    | nein                                                 |
| 6    | SSH_Access      | SSH Zugriff ist nur vom Hostsystem möglich                                  | SSH Zugriff ist nur vom Hostsystem möglich                                                                                                         | nein                                                 |
| 7    | DB_Access       | Die Webserver haben zugriff auf die Datenbank mit der DB "wordpress"        | Die Webserver haben zugriff auf die Datenbank mit der DB "wordpress"                                                                               | nein                                                 |
| 8    | Web_Access      | Die Webseite ist über die IP des Proxy-Servers und Port 80 aufrufbar        | Die Webseite ist über die IP des Proxy-Servers und Port 80 aufrufbar                                                                               | nein                                                 |
| 9    | Web_WP_Admin    | Die Admin-Oberfläche von Wordpress ist erreichbar                           | Die Admin-Oberfläche von Wordpress ist erreichbar                                                                                                  | nein                                                 |
| 10   | Run_Everywhere  | Das Vagrantfile kann überall gestartet werden                               | Das Vagrantfile kann nicht überall ausgeführt werden. Grund sind statische IP-Adressierungen sowohl im VM internen Netz als auch Proxy WAN adresse | Umstellung auf DHCP oder externes IP-Management-File |

---
## Nachweise
### 1. Vorwissensstand
Ich kenne mich in Linux nur ein wenig aus, da wir im Betrieb mit Windows Arbeiten. Ich kenne lediglich das, was ich bisher in der Schule bereits behandelt habe oder was ich schon einmal recherchiert habe. Im Betrieb laufen ca. 90% aller Server virtuell, somit habe ich dort schon ein wenig Erfahrung. Jedoch arbeiten wir dort mit VMware, was einen kleinen Unterschied zu VirtualBox ausmacht. Vagrant habe ich in diesem Modul zum ersten Mal gehört. Generell bauen wir auf fertigen Images auf und konfigurieren danach alles von Hand. Markdown finde ich ein spannendes Tool, wenn Duzende gleiche Maschinen erstellt werden müssen. für einzelne Server, die vor allem GUI-Basiert sind, ist Vagrant nicht geeignet. Versionierung kenn ich nur durch Dokumentationen. Dort wird immer hingeschrieben, wer zuletzt was und wann geändert hat. Somit kenn ich das Prinzip gut. Ich habe zuvor leider weder mit Git noch mit Markdown gearbeitet. Ich finde es gut, dass es eine zentrale Ablage gibt für Scripts, Dokumentationen, Programme etc. und dass diese mittels Markdown immer gleich dokumentiert sind. Wenn man einmal drin ist klappt das gut. Ich achte immer auf Sicherheit, habe mich aber bei der Virtualisierung und vor allem mit Vagrant noch nicht so viel damit beschäftigt. Dazu kommt nochmals der Punkt, dass ich im Bereich Linux nicht viel erfahrung habe, vor Allem mit der Sicherheit. Dies wieder mit dem Grund, dass wir Windows verwenden und dort die Sicheheitsaspekte anders laufen.

### 2. Lernschritte im Verlauf der LB
Anfangs hatte ich Mühe ins Thema zu kommen. Mir war nicht klar, für was Vagrant gebraucht werden soll, da ich die verwendung mehrerer gleicher oder ähnlicher VMs nicht kannte. Zudem war mir sowohl VirtualBox, als auch Vagrant, VSCode, Git und Markdown neu. Ich musste die ersten 2 Wochen nur recherchieren, bis ich den Aufbau von allem Verstanden habe und gemerkt habe, wie was miteinander verknüpft ist und was welche Aufgabe übernimmt. Danach hatte ich schnell eine Idee, wie die LB2 aussehen soll. Natürlich, wie bei mir üblich, habe ich mein Ziel wieder komplett zu hoch angesetzt. Ursprünglich wollte ich zwei Firewalls basierend auf einer OPNSense VM aufbauen, dahinter ein Load-Balancer, 2 synchrone SQL Server im Active-Passive Modus und 2 Web Server im Load-Balancing modus mit dem Selben Inhalt, der auf den SQL-Servern abgelegt ist. Auf der Webservern soll Apache2 und Wordpress installiert sein. Das Ziel, dass die Daten der Webseite im Vagrant file schon mitgegeben werden, so dass bei einem `Vagrant up` und einer kurzen Wartezeit 2 redundante vollfunktionsfähige Webseiten erscheinen. So könnte die Webseite irgendwo weiterentwickelt oder aktualisiert werden, auf das Github geladen werden und alle Webserver würden beim nächsten Reboot die Daten neu übernehmen. Ich musste jedoch recht schnell mein Vorhaben minimieren, da ich mit dem Syntax und allen Commands viel zu überfordert war. Ich habe die Firewall weggelassen und die DB nur einmal hinterlegt. Zudem habe ich es aus zeitlichen Gründen nicht geschfft, die Webseiten mittels https zu verschlüsseln. Ich bin jedoch stolz, dass ich mit hilfe von wp-cli eine funktionierende Wordpress installation hingekriegt habe. wp-cli ist ein Tool, welches die Verwaltung von Wordpress über das GUI zulässt. So könnte beispielsweise Wordpress via SSH konfiguriert werden, eine Seite neu erstellt werden oder ein Blog geschrieben werden. Das finde ich ziemlich praktisch. Abschliessend kann ich sagen, dass ich trotz einer VM-reduktion diese LB als gelungen ansehe. Zwischenzeitlich habe ich sogar daran gezweifelt, Wordpress zum laufen zu bringen. Ich hoffe, dass die Bewertung durch mögliche fehlende Sicherheitsaspekte nicht leiden muss.

### 3. Reflexion
Das Erstellen der LB2 hat mir viele Probleme bereitet, dadurch dass ich mich zu schnell an mein eigenes Projekt gewendet habe, bevor ich den Syntax überhaupt verstanden habe. Nur durch viel Hilfe von anderen Quellen habe ich mich da wieder reingefunden. Ohne die Beispielvagrants vom Modul hätte ich das nicht so einfach hingekriegt. Ich bin froh, dass ich die LB2 doch noch so gut hinbekommen habe und hoffe natürlich auch auf eine gute Note. Ich finde Vagrant eine gute Lösung, jedoch bin ich froh, wenn ich Vagrant nicht mehr brauchen muss, denn mir erschliesst sich der Sinn hinter dem nicht ganz. Vagrant kann gut verwendet werden, wenn ein Hostsystem vorhanden ist und darauf Virtualisiert wird. Jedoch wird heutzutage mit dem Virtualisierungstyp 1, auch als Bare Metall Virtualisierung gearbeitet, damit die Umgebung nicht mehr Hostbetriebssystemabhängeg ist. Zudem macht das für mich nur Sinn, wenn mehrere VMs dieselbe Funktion ausüben sollen, damit nicht auf allen VMs manuell etwas gemacht werden muss.
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

### 3. K3 Vagrant
#### 3.1 Bestehende vm aus Vagrant-Cloud einrichten
Verwendet wurde nur 4x ubuntu/bionic64, was Ubuntu 18.04 LTS entspricht.
#### 3.2 Kennt die Vagrant-Befehle
- **Vagrant up:** Liest das Vagrantfile und startet die darin enthaltenen VMs
- **Vagrant snapshot push:** Erstellt ein Snapshot aller VMs (oder wenn definiert nur bestimmte VM)
- **Vagrant snapshot pull:** Spielt den erstellten Snapshot wieder ein.
- **Vagrant Provision** führt das Privisioning der VMs durch (nur nötig, wenn 
  `vagrant up` mit parameter `--no-privision` gemacht wird oder in den Scripts etwas geändert wurde)
- **Vagrant halt** stoppt die VMs
- **Vagrant Reload** lädt die Einstellungen aus dem Vagrantfile neu und aktualisiert die VM Hardware
- **Vagrant ssh** macht eine SSH Verbindung zur angegebenen VM-Maschine
- **Vagrant Destroy** zerstört die VMs und löscht deren Daten.
- Weitere Commands sind auf der Webseite von Vagrant zu finden: [Commands](https://www.vagrantup.com/docs/cli)
#### 3.3 Eingerichtete Umgebung ist dokumentiert
[Dokumentation](#dokumentation-lb2)<br>
![Networkplan](/images/K3_Networkplan.jpg)
#### 3.4 Funktionsweise getestet inkl. Dokumentation der Testfälle
[Testing](#testing)
#### 3.5 andere, vorgefertigte vm auf eigenem Notebook aufgesetzt
Zum Testen und verstehen der Vagrant-Funktionen wurden die VMs des [Modul-Repositorys/fwrp](https://github.com/mc-b/M300/tree/master/vagrant/fwrp) verwendet
#### 3.6 Projekt mit Git und Mark Down dokumentiert
![IMG_DocAsMarkdown](/images/K3_DokAsMarkdown.jpg)<br>
[Doku in Git](#3-k3-vagrant)

### 4. K4 Sicherheitsaspekte sind implementiert
#### 4.1 Firewall eingerichtet inkl. Rules
| Sourc\Destination | Hostsystem | WAN  | Proxy          | DB01     | Web01  | Web02  |
| :---------------- | :--------- | :--- | :------------- | :------- | :----- | :----- |
| Hostsystem        | x          | any  | 22/TCP, 80/TCP | 22/TCP   | 22/TCP | 22/TCP |
| WAN               | -          | x    | 80/TCP         | -        | -      | -      |
| Proxy             | -          | any  | x              | -        | 80/TCP | 80/TCP |
| DB01              | -          | any  | -              | x        | -      | -      |
| Web01             | -          | any  | -              | 3306/TCP | x      | -      |
| Web02             | -          | any  | -              | 3306/TCP | -      | x      |
#### 4.2 Reverse-Proxy eingerichtet
Ja, Siehe [Proxy.sh](Scripts/proxy.sh)
Der Proxy ist so konfiguriert, dass die Anfragen mittels Round Robin verfahren zu den Webservern weitergeleitet werden.
#### 4.3 Benutzer- und Rechtevergabe ist eingerichtet
Die Mysql Datenbank hat einen extra Benutzer `wpuser`, der nur auf die wordpress Datenbank zugreifen kann.
Dieser User kann nur von den Webservern aus mit einem Passwort verwendet werden.
Zudem wurde auf den Webservern der Zugriff auf die Website-Dateien beschränkt.
Dateien hochladen kann nur der Owner des Ordners, sprich Vagrant und die Gruppe Root. Der Rest hat nur Leserechte.
Die Webseite an sich soll öffentlich zugänglich sein, daher gibt es hier kein Benutzerkonzept.
#### 4.4 Zugang mit SSH-Tunnel abgesichert
Nein, da SSH nur vom Hostsystem auf die VMs erlaubt ist.
Firewall Rules werden im [Default.sh](Scripts/default.sh) so festgelegt.
#### 4.5 Sicherheitsmassnahmen sind dokumentiert
- UFW Firewall auf allen Maschinen aktiviert
- UFW Standardmässig auf Deny gestellt
- Strikter Firewall-Regelsatz, nur das nötigste wird konfiguriert
#### 4.6 Projekt mit Git und Mark Down dokumentiert
![IMG_DocAsMarkdown](/images/K4_DokAsMarkdown.jpg) <br>
[Doku in Git](#4-k4-sicherheitsaspekte-sind-implementiert)

### 5. K5 Zusätzliche Bewertungspunkte
#### 5.1 Allgemein
##### 5.1.1 Kreativität
Wordpress ist das bekannteste und am weitesten verbreitete CMS auf der ganzen Welt. Duzende Webserver werden täglich mit einer neuen Wordpress installation veröffentlicht. Daher bietet sich eine automatische Installation durch so ein Script natürlich sehr an. Mit einer fertigen Umgebung in form von einem Code (IaaC) kann Wordpress nur innert wenigen Minuten betriebsbereit gemacht werden. Der einzige Weg, das noch schneller zu machen und gleichzeitig Ressourcen zu sparen wäre eine Umgebung auf Docker basierend, dies wird aber vermutlich erst in LB3 zum Zug kommen.
##### 5.1.2 Komplexität
Das Vagrantfile und die Scripts sind sehr mager aufgebaut. Nur die nötigsten Installationen werden getätigt, nur die wichtigsten Konfigurationsschritte werden durchgeführt. Das Vagrantfile ist so aufgebaut, dass beliebig viele Virtuelle Maschinen als Webserver durch Copy und Paste hinzugefügt werden können. Es sind nur leichte Änderungen wie IP-Adresse und Name nötig, danach sind die Maschinen innert wenigen Minuten bereits mit Wordpress installiert und erreichbar.
##### 5.1.3 Umfang
Trotz relativ wenig Scriptzeilen wird wärend der Installation viel gemacht. Die Scripts sind so komplex zusammengeschrieben und aufeinander aufgebaut, dass es nach wenig aussieht, jedoch eine ganze Wordpress installation über das CLI durchgeführt wird. Es wurde darauf geachtet, dass Commands, welche auf mehreren VMs ausgeführt werden müssen, in einem Script platz finden, um Platz zu sparen. Wer selber schon einmal Wordpress installiert hat, sei es Grafisch oder ebenfalls via cli, der weiss wie lange so ein Prozess dauert.
#### 5.2 Umsetung
##### 5.2.1 Cloud-Integration
Es wurde kein IaaS Verwendet
##### 5.2.2 Authentifizierung und Autorisierung via LDAP
Es wurde kein LDAP eingerichtet
##### 5.2.3 Übungsdokumentation als Vorlage für Modul-Unterlagen erstellt
Es wurde keine Übungsdokumentation erstellt
#### 5.3 Persönliche Lernentwicklung
##### 5.3.1 Vergleich Vorwissen - Wissenszuwachs
[Vorwissensstand](#1-vorwissensstand)
[Wissenszuwachs](#2-lernschritte-im-verlauf-der-lb)
##### 5.3.2 Reflexion
[Reflexion](#3-reflexion)
