@echo off
title MZP APP Updater
color 17
cd 7z 
set zpatch=%CD%\7z.exe
cd..
goto :check 

:check 
echo [inf. dla uzytkownika] sprawdzanie aktualnej wersji aplikacji
timeout 3 >nul
set updcatalog=%CD%
cd..
cd MZP_ROZKLADY
cd resources 
set /p cversion=<app.ver
cd "%updcatalog%"
curl -O -s -L https://piraxu.github.io/Mzp.App/version.txt
set /p acversion=<version.txt
del version.txt
if not %cversion%==%acversion% goto :info
if %cversion%==%acversion% goto :endif2

:endif2 
echo [inf. dla uzytkownika] Posiadasz juz aktualna wersje aplikacji.
timeout 5 >nul 
echo [inf. dla uzytkownika] to okno zaraz zostanie zamkniete 
timeout 3 >nul  
exit 


:info
echo [inf. dla uzytkownika] dostepna jest nowa wersja aplikacji !!
timeout 2 >nul
echo [pyt. dla uzytkownika] czy chcesz ja pobrac?
set /p qstion=[pole edycyjne] T = tak / N = nie:
if %qstion%==t goto :backup
if %qstion%==T goto :backup
if %qstion%==n goto :endinf
if %qstion%==N goto :endinf 





:backup 
echo [inf. dla uzytkownika] rozpoczynam proces aktualizacji
echo [inf. dla uzytkownika] tworzenie kopii zapasowej poprzedniej wersji aplikacji
timeout 5 >nul
cd backups 
md %DATE%
cd %DATE%
set todaycp=%CD%
cd..
cd..
cd..
xcopy "MZP_ROZKLADY" "%todaycp%\MZP_ROZKLADY" /E /I 
cd [updater]
timeout 1 >nul 
echo [inf. dla uzytkownika] kopia wykonana poprawnie
timeout 2 >nul
goto :dwnld



:endinf 
echo [inf. dla uzytkownika] to okno zaraz zostanie zamkniete, a aktualizacja nie zostanie pobrana
timeout 5 >nul 
exit




:dwnld
curl -O -L https://piraxu.github.io/Mzp.App/update.zip
cd..
set mainapppatch=%CD%
taskkill /f /im mshta.exe
rmdir /S /Q MZP_ROZKLADY
"%zpatch%" x "%updcatalog%\update.zip" -o"%mainapppatch%"
del "%updcatalog%\update.zip"
timeout 1 >nul 
echo [inf. dla uzytkownika] Aktualizacja zostala zakonczona
timeout 4 >nul 
echo [pyt. dla uzytkownika] czy chcesz otworzyc zaaktualizowana aplikacje ?
set /p openques=[pole edycyjne] T = tak / N = nie:
if %openques%==t goto :openY
if %openques%==T goto :openY
if %openques%==n goto :openN
if %openques%==N goto :openN

:openY
cd "%updcatalog%"
cd ..
cd MZP_ROZKLADY
start main.hta
echo [inf. dla uzytkownika] To okno zaraz zostanie zamkniete.
timeout 4 >nul 
exit

:OpenN 
echo [inf. dla uzytkownika] To okno zaraz zostanie zamkniete.
timeout 4 >nul 
exit