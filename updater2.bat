:: AUTORSTWO: MZP OSTROŁĘKA, PIRAXU. MARZEC 2026 ROK

@echo off 
chcp 65001 >nul
title AKTUALIZATOR MZP APP
color 17 

:menu
cls 
echo ╔═══════════════════════════════════════════╗
echo ║       SILNIK AKTUALIZACJI MZP APP         ║
echo ╠═══════════════════════════════════════════╣
echo ║                                           ║
echo ║   A - Sprawdź dostępność aktualizacji     ║
echo ║   B - Przywróć kopię zapasową             ║
echo ║   C - Informacje o silniku                ║
echo ║   D - Zamknij silnik                      ║ 
echo ║                                           ║
echo ╚═══════════════════════════════════════════╝
choice /c ABCD /m "Wybierz opcję:"
if errorlevel 4 exit 
if errorlevel 3 goto :engineinfo
if errorlevel 2 goto :rollback
if errorlevel 1 goto :varcreate

:varcreate
cls 
rem == Zmienne ==
set "Upatch=%CD%"
set "Bpatch=%Upatch%\backups"
set "Unzip=%Upatch%\7z\7z.exe"
cd..
set "AppPatch=%CD%"
cd %AppPatch%\MZP_ROZKLADY\resources
set /p CurrentVer=<app.ver
cd %Upatch%
goto :versioncheck 

:versioncheck
echo [Inf. dla użytkownika] -- Sprawdzanie dostępnej wersji aplikacji.
curl -k -O -s -L -f --connect-timeout 20 --max-time 180 https://piraxu.github.io/Mzp.App/version.txt


if not exist version.txt (
rem == JEŚLI PLIK VERSION.TXT NIE ISTNIEJE ZWRÓĆ BŁĄD ==
cls 
timeout 1 >nul
color 4F
powershell -c "[console]::beep(1000,700);"
echo [Błąd] -- Plik version.txt nie istnieje ! 
echo [KOD BLĘDU] -- 01
echo ABY ZATRZYMAĆ DZIAŁANIE SKRYPTU NACIŚNIJ DOWOLNY KLAWISZ.
pause >nul 
exit
) 
rem == W PRZECIWNYM WYPADKU PORÓWNAJ OBECNĄ WERSJĘ Z POSIADANĄ == 	

set /p AvailVer=<version.txt
timeout 1 >nul
del version.txt 

if "%CurrentVer%"=="%AvailVer%" (
    timeout 1 >nul
    echo [Inf. dla użytkownika] -- Posiadasz już najnowszą wersję aplikacji. 
    echo [Inf. dla użytkownika] -- To zostanie zamknięte automatycznie za kilka sekund.
    timeout 4 >nul
    exit
) else (
    timeout 1 >nul 
    echo [Inf. dla użytkownika] -- Dostępna jest nowsza wersja aplikacji !
    echo [Objaśnienie] -- T, oznacza TAK
    echo [Objaśnienie] -- N, oznacza NIE
    choice /c TN /m "Czy chcesz ją pobrać:"
    if errorlevel 2 goto :disagreeinfo 
    if errorlevel 1 goto :backup
)



:backup
timeout 2 >nul 
echo [Inf. dla użytkownika] -- Rozpoczynam proces kopii zapasowej.
echo [Inf. dla użytkownika] -- Tworzenie kopii zapasowej. 
if not exist "%Bpatch%" (
rem == Jeśli FOLDER Backups nie istnieje zwróć błąd ==
cls 
timeout 1 >nul
color 4F
powershell -c "[console]::beep(500,1500);"
echo [Błąd] -- Folder "[updater]\backups" nie istnieje !
echo [Kod BŁĘDU] -- 02 
echo ABY ZATRZYMAĆ DZIAŁANIE SKRYPTU NACIŚNIJ DOWOLNY KLAWISZ.
pause >nul 
exit
) else (
rem == W przeciwnym wypadku stwórz folder pod nazwą posiadanej wersji w folderze backups == 
cd %Bpatch%
md %CurrentVer%


if not exist "%CurrentVer%" (
    rem == Jeśli folder pod nazwą posiadanej aktualnie wersji jakimś cudem nie powstał zwróć błąd ==
    cls 
    timeout 1 >nul 
    color 4F
    powershell -c "[console]::beep(500,700);" 
    echo [Błąd] -- Folder "[updater]\backups\%CurrentVer%" nie istnieje !
    echo [KOD BŁĘDU] -- 03
    echo ABY ZATRZYMAĆ DZIAŁANIE SKRYPTU NACIŚNIJ DOWOLNY KLAWISZ. 
    pause >nul 
    exit
)

xcopy "%AppPatch%\MZP_ROZKLADY" "%CurrentVer%\MZP_ROZKLADY" /E /I /Y >nul 2>&1

if not exist "%CurrentVer%\MZP_ROZKLADY" (
cls 
timeout 1 >nul 
color 4F
powershell -c "[console]::beep(1000,700);" 
echo [Błąd] -- Nie udało się stworzyć kopii zapasowej.
echo [KOD BŁĘDU] -- 04
echo ABY ZATRZYMAĆ DZIAŁANIE SKRYPTU NACIŚNIJ DOWOLNY KLAWISZ. 
pause >nul 
exit

) else (
    echo [Inf. dla użytkownika] -- Pomyślnie stworzono kopię zapasową.
    echo [Inf. dla użytkownika] -- Pobieranie paczki aktualizacji. 
    goto :dwnld
)


)


:dwnld
cd %Upatch%
taskkill /f /im mshta.exe >nul 2>&1
curl -s -k -O -L -f --connect-timeout 20 --max-time 180 https://piraxu.github.io/Mzp.App/update.zip >nul 
if not exist update.zip (

cls 
timeout 1 >nul 
color 4F
powershell -c "[console]::beep(1000,700);" 
echo [Błąd] -- Plik "update.zip" nie istnieje !
echo [KOD BŁĘDU] -- 05
echo ABY ZATRZYMAĆ DZIAŁANIE SKRYPTU NACIŚNIJ DOWOLNY KLAWISZ.
pause >nul
exit
) else (
    echo [Inf. dla użytkownika] -- Paczka aktualizacji została pobrana. 
    echo [Inf. dla użytkownika] -- Wyodrębiam paczkę aktualizacji.
    cd %AppPatch%
    rmdir /S /Q MZP_ROZKLADY
    cd %Upatch%
    "%Unzip%" x "%Upatch%\update.zip" -o"%AppPatch%" >nul 
    del update.zip 
    
    if not exist "%AppPatch%\MZP_ROZKLADY" (
        cls 
        timeout 1 >nul 
        color 4F
        powershell -c "[console]::beep(1000,700);" 
        echo [Błąd] -- Folder "%AppPatch%\MZP_ROZKLADY" nie istnieje !, zaleca się przywrócenie kopii zapasowej aplikacji.  
        echo [KOD BŁĘDU] -- 06
        echo ABY ZATRZYMAĆ DZIAŁANIE SKRYPTU NACIŚNIJ DOWOLNY KLAWISZ.
        pause >nul 
        exit
    ) else (
        echo [Inf. dla użytkownika] -- Paczka aktualizacji wyodrębiona pomyślnie.
        echo [Inf. dla użytkownika] -- Aktualizacja została zakończona sukcesem. 
        echo [Objaśnienie] -- T, oznacza TAK
        echo [Objaśnienie] -- N, oznacza NIE
        choice /c TN /m "Czy chcesz uruchomić nową wersję aplikacji:"
        if errorlevel 2 (
            echo [Inf. dla użytkownika] -- To okienko zostanie zamknięte automatycznie za kilka sekund.
            timeout 4 >nul 
            exit 
        )
        if errorlevel 1 (
            cd "%AppPatch%\MZP_ROZKLADY"
            start main.hta
            exit
        )
    )
)



:disagreeinfo 
timeout 2 >nul
echo [inf. dla użytkownika] -- To okienko zostanie zamknięte automatycznie za kilka sekund.
timeout 4 >nul 
exit


:rollback 
cls
set "UpdPatch=%CD%"
set "Backups=%UpdPatch%\backups"
cd.. 
set "MainPatch=%CD%"
cd %Backups%

echo ╔══════════════════════════════════════════════════════════════╗
echo ║            PRZYWRCANIE KOPII ZAPASOWEJ "MZP APP"             ║
echo ╠══════════════════════════════════════════════════════════════╣
echo ║ Witamy w kreatorze przywracania kopii zapasowej.             ║
echo ║ W celu przywrócenia kopii zapasowej, z listy poniżej         ║
echo ║ wybierz wersję którą planujesz przywrócić. Następnie wpisz   ║ 
echo ║ jej numer w linijke pod tym komunikatem.                     ║
echo ╚══════════════════════════════════════════════════════════════╝
echo ════════════════════════════════════════════════════════════════
echo LISTA UTWORZONYCH KOPII ZAPASOWYCH:
dir /a:d /b                                                  
echo ════════════════════════════════════════════════════════════════
set /p "RollbackVer=Wybierz wersję do przywrócenia:"

if not exist "%RollbackVer%" (
    cls 
    timeout 1 >nul 
    color 4F
    powershell -c "[console]::beep(1000,700);" 
    echo [Błąd] -- Wpisana przez użytkownika wersja "%RollbackVer%" nie istnieje !
    echo [KOD BŁĘDU] -- 07 
    echo ABY ZATRZYMAĆ DZIAŁANIE SKRYPTU NACIŚNIJ DOWOLNY KLAWISZ.
    pause >nul 
    exit
) else (

if not exist "%MainPatch%\MZP_ROZKLADY" (
echo [Inf. dla użytkownika] -- Przywracam kopię zapasową. 
taskkill /f /im mshta.exe >nul 2>&1
timeout 2 >nul
xcopy "%Backups%\%RollbackVer%\MZP_ROZKLADY" "%MainPatch%\MZP_ROZKLADY" /E /I /Y >nul 
timeout 1 >nul 
rmdir "%RollbackVer%" /S /Q
echo [Inf. dla użytkownika] -- Kopia zapasowa została przywrócona.
timeout 4 >nul
) else (
echo [Inf. dla użytkownika] -- Przywracam kopię zapasową. 
taskkill /f /im mshta.exe >nul 2>&1
rmdir "%MainPatch%\MZP_ROZKLADY" /S /Q
xcopy "%Backups%\%RollbackVer%\MZP_ROZKLADY" "%MainPatch%\MZP_ROZKLADY" /E /I /Y >nul 
timeout 1 >nul 
rmdir "%RollbackVer%" /S /Q
echo [Inf. dla użytkownika] -- Kopia zapasowa została przywrócona.
timeout 4 >nul 
)

if not exist "%MainPatch%\MZP_ROZKLADY" (
 cls 
 timeout 1 >nul 
 color 4F
 powershell -c "[console]::beep(1000,700);" 
 echo [Błąd] -- Po dokonaniu przywrócenia kopii zapasowej folder "MZP_ROZKLADY" w katalogu głównym aplikacji nie istnieje !
 echo [KOD BŁĘDU] -- 08 
echo ABY ZATRZYMAĆ DZIAŁANIE SKRYPTU NACIŚNIJ DOWOLNY KLAWISZ.
pause >nul 
exit
 ) else (
    goto :AfRestoreQuestion
 )

)

:AfRestoreQuestion
choice /c TN /m "Otworzyć przywróconą wersję aplikacji?"
if errorlevel 2 (
    echo [Inf. dla użytkownika] -- To okienko zostanie zamknięte automatycznie za kilka sekund. 
    timeout 4 >nul 
    exit
)
if errorlevel 1 (
    cd "%MainPatch%\MZP_ROZKLADY"
    start "" "main.hta"
    exit
)



:engineinfo 
cls 
timeout 1 >nul 
echo ╔════════════════════════════════════════════╗
echo ║           Informacje o silniku             ║
echo ╠════════════════════════════════════════════╣
echo ║ Autor: Piraxu, Marzec 2026                 ║
echo ║ Wersja: 2.0                                ║
echo ║ Przeznaczenie silnika: "Aplikacja" MZP APP ║                                          
echo ╚════════════════════════════════════════════╝
echo ABY WRÓCIĆ DO POPRZEDNIEGO MENU WCIŚNIJ DOWOLNY KLAWISZ
pause >nul 
goto :menu 
