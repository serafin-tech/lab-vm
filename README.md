# lab-vm

Repozytorium zawiera definicje maszyny wirtualnej do budowy laboratorium Aplikacji Internetowych.

## Wymagania systemowe

Uruchomienie maszyny wirtualnej możliwe jest na systemach operacyjnych Windows/MacOS/Linux, jakkolwiek poniższa instrukcja zakłada użycie systemu Windows. Podczas instalacji (uruchomienie skryptu `start.cmd`) pobierany jest obraz maszyny wirtualnej o rozmiarze 500MB oraz pakiety o łącznym rozmiarze około 200MB.
Finalny rozmiar maszyny wirtualnej to około 2GB.

Do pracy wymagane jest posiadanie minimum 4GB pamięcia RAM.

Dla systemu Windows 7 może wystąpić konieczność instalacji Powershella w nowszej wersji. Instrukcja instalacji zawarta jest w artykule [docs.microsoft.com](https://docs.microsoft.com/pl-pl/powershell/scripting/windows-powershell/install/installing-windows-powershell?view=powershell-7).

Podczas instalacji zalecane jest wyłączenie oprogramowania antywirusowego.

## Instrukcja przygotowania i uruchomienia środowiska

Aby przygotować wirtualną maszyne należy wykonać następujące kroki:

1. pobieramy i instalujemy [VirtualBoxa](https://www.virtualbox.org/wiki/Downloads),
2. pobieramy i instalujemy [Vagranta](https://www.vagrantup.com/downloads.html),
3. pobieramy plik z zawartością repozytorium (lub klonujemy repozytorium przy pomocy GITa), pliki umieszczamy np w katalogu `C:\lab-vm` - link do pobrania repozytorium dostępny pod zielonym przyciskiem z napisem *Code*,
4. uruchamiamy wirtualną maszynę przy pomocy skryptu `start.cmd` - konfiguracja przebiegnie automatycznie,

Po zakończonej pracy maszynę zatrzymujemy poprzez skrypt `halt.cmd` i startujemy ją ponownie przy pomocy skryptu `start.cmd`. 
Gdy chcemy odzyskać miejsce na dysku to możemy użyć skryptu `destroy.cmd`, który skasuje maszynę. 
Ponowne użycie skryptu `start.cmd` odtworzy maszynę do stanu jak wg definicji.

## Jak uruchomic własną aplikację

Pliki aplikacji umieszczamy w katalogu `C:\lab-vm\www`. Aplikacja tam umieszczona dostępna jest pod adresem [http://localhost:8765/](http://localhost:8765/). Sprawdzenie działania PHP można dokonać pod adresem [http://localhost:8765/test.php](http://localhost:8765/test.php)

## Połączenie do bazy danych

Operacje na bazie danych możemy przeprowadzić przy pomocy aplikacji [phpMyAdmin](https://www.phpmyadmin.net/) dostępnej pod adresem [http://localhost:8765/phpmyadmin/](http://localhost:8765/phpmyadmin/). 
Hasło użytkownika `root` to `Som3Passw0rd`.

Przykładowy skrypt testujący połączenie z bazą danych dostępny jest w katalogu `www`, nazwa pliku `dbtest.php`. Skrypt zwraca wersję bazy danych i dostępny jest pod adresem [http://localhost:8765/dbtest.php](http://localhost:8765/dbtest.php).

## Połączenie przez SSH

Przez SSH do maszyny wirtualnej możemy połączyć się na dwa sposoby:
- używając skryptu `ssh.cmd` (czyli przy pomocy Vagranta),
- bezpośrednio przez PuTTy łącząc się na adres `127.0.0.1:2222`, logujemy się wtedy jako użytkownik `vagrant` z hasłem `vagrant`.

Po zalogowaniu będziemy *zwykłym* użytkownikiem, aby przełączyć się na użytkownika `root` należy wydać polecenie `sudo -i`. Do pracy z plikami strony nie potrzebujemy przełączać się na roota.

Wewnątrz maszyny wirtualnej pliki aplkacji dostępne są w podkatalogu `www` katalogu domowego użytkownika `vagrant` lub bezpośrednio w katalogu `/vagrant/www`.

Do poruszania się wewnątrz maszyny wirtualnej można używać Midnight Commandera - polecenie `mc`.

