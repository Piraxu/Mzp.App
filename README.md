==============================
OFICJALNE REPOZYTORIUM MZP APP
==============================
Witaj w oficjalnym repozytorium MZP APP stworzonym w celu poprawy komfortu członków v-firmy MZP Ostrołęka w grze Nid's buses and Trams na robloxie !

Spis Treści:
  1 - Co mogę tutaj znaleźć ?
  2 - Jak działa proces aktualizacji ?


1 - Co mogę tutaj znaleźć ?
  W oficjalnym repozytorium naszej "aplikacji" można znaleźć rzeczy takie jak:
    - Kod źródłowy "aplikacji" w pełni do wglądu razem z updaterem. 
    - Pliki używane przez udpater "aplikacji" takie jak plik "version.txt" który updater porównuje z plikiem lokalnym, Plik "update.zip" który updater rozpakowuje tym samym dokonując aktualizacji 
    - Plik "Popup_alert.json" który aplikacja zaciąga w celu sprawdzenia czy dostępne są dynamiczne komunikaty.

2 - Jak działa proces aktualizacji ?
  Po uruchomieniu skryptu aktualizacji "updater.bat" :
    - Za pomocą programu curl pobierany jest plik "version.txt" i zbierana jest z niego zawartość, po czym pobierana jest wartość z pliku app.ver zawartego w plikach lokalnych aplikacji. 
    - Jeżeli oba pliki mają taką samą zawartość, skrypt zakłada że wersja jest aktualna, o czym informuje i zamyka się po kilku sekundach, jeżeli jednak zawartości się różnią pokazuje komunikat o dostępności nowej aktualizacji i pyta użytkownika czy ma zamiar ją pobrać
    - Jeżeli użytkownik wyrazi zgodę skrypt przechodzi do sekcji w której powstaje kopia zapasowa poprzedniej wersji. W folderze [updater]/backups/ powstaje folder o nazwie takiej jak aktualna data. I kopiuje do niego cały folder MZP_ROZKLADY
    - Po wykonaniu kopii zapasowej, skrypt przechodzi do sekcji właściwej, w której przez program curl pobiera paczkę aktualizacji "update.zip" , a za pomocą programu 7-zip rozpakowuje ją w odpowiednie miejsce tym samym podmieniając stare pliki na nowe i aktualne 

Dziękuje za przeczytanie readme. Bardziej dokładna wersja znajduje się w głównym katalogu "aplikacji"
    
                                               
                                               
