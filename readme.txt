REPOZYTORIUM ZASOBÓW "APLIKACJI" MZP APP 
=================================================
Spis treści:
    1.)Cel readme
    2.)Co znajduje się w repozytorium ?
    3.)Działanie procesu aktualizacji 
=================================================


1.) Cel readme 

    • Celem tego radme jest przedstawienie dla bardziej ciekawskich użytkowników sposób w jaki 
      "aplikacja" MZP APP używa tego repozytorium do swojego działania w zakresie aktualizacji. 

2.) Co znajduje się w repozytorium ?

    • W repozytorium znajdują się następujące pliki:

        • update.zip (paczka której aplikacja używa w celach aktualizacji)
        • version.txt (prosty plik tekstowy który zawiera datę wydania aktualizacji)
        • Popup_alert.json (plik json zawierający zawartość wyświetlaną w "dynamicznych" komunikatach)

3.) Działanie procesu aktualizacji

    • Rolę aktualizatora przyjmuje skrypt batch "updater.bat", zawarty w katalogu "[updater]". 
      Po jego wywołaniu przez skrypt "updscript.cmd" z poziomu aplikacji, przy użyciu narzędzia "curl" 
      następuje pobieranie wyżej wspomnianego pliku version.txt który porównywany jest z innym plikiem
      zawartym w "aplikacji", z założenia jeżeli są one od siebie różne skrypt uważa że ma doczynienia 
      z nową aktualizacją i przenosi użytkownika do kolejnej sekcji skryptu, w przeciwnym wypadku gdy
      pliki są takie same skrypt przenosi do innej sekcji która informuje użytkownika o tym że posiada
      najnowszą wersję, po czym następuje komenda exit. Ale co się właściwie dzieje kiedy skrypt 
      wykryje aktualizacje ?... Pyta użytkownika czy ten życzy ją sobie pobrać. Jeśli tak tworzy
      duplikat folderu głównego aplikacji który następnie umieszcza w "[Updater]\backups\" w stworzonym
      folderze nazwanym tak samo jak data wykonywania aktualizacji (czyli np. 01.01.2026).
      Po wykonaniu kopii, przechodzi do sekcji właściwej, czyli pobierania paczki .zip z aktualizacją
      za pomocą programu curl. Po pobraniu, za pomocą programu "7-zip" następuje wypakowanie paczki
      w folderze w którym znajduje się katalog główny aplikacji. Kiedy to ten proces się zakończy 
      użytkownik dostanie ostatnie pytanie, a mianowicie czy chce otworzyc zaaktualizowaną aplikację. 
      Jeśli odpowie że nie, to zwyczajnie skrypt się zamknie a użytkownik będzie mógł włączyć aplikacje
      ponownie kiedy będzie miał ochotę. Jeśli jednak odpowie że tak, skrypt się zamknie poprzedzając
      to uruchomieniem aplikacji. 

      