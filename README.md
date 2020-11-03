# lab-vm

Repozytorium zawiera definicje maszyny wirtualnej do budowy laboratorium Aplikacji Internetowych.

## Wymagania systemowe

Uruchomienie maszyny wirtualnej możliwe jest na systemach operacyjnych Windows/MacOS/Linux, jakkolwiek poniższa instrukcja zakłada uzycie systemu Windows. Podczas instalacji (uruchomienie skryptu `start.cmd`) pobierany jest obraz maszyny wirtualnej o rozmiarze 500MB oraz pakiety o łącznym rozmiarze około 100MB.
Finalny rozmiar maszyny wirtualnej to 2GB.

Do pracy wymagane jest posiadanie minimum 4GB pamięcia RAM.

## Instrukcja przygotowania i uruchomienia środowiska

1. pobieramy i instalujemy [VirtualBoxa](https://www.virtualbox.org/wiki/Downloads)
2. pobieramy i instalujemy [Vagranta](https://www.vagrantup.com/downloads.html)
3. pobieramy plik z zawartością repozytorium (lub klonujemy repozytorium przy pomocy GITa), pliki umieszczamy np w katalogu `C:\lab-vm`
4. uruchamiamy wirtualną maszynę przy pomocy skryptu `start.cmd`

## Jak uruchomic aplikację

Pliki aplikacji umieszczamy w katalogu `C:\lab-vm\www`. Aplikacja tam umieszczona dostępna jest pod adresem [http://localhost:8080/](http://localhost:8080/). Sprawdzenie działania PHP można dokonać pod adresem [http://localhost:8080/test.php](http://localhost:8080/test.php)

