{+-----------------------------------------------------------------------+
 |               ~  C   A   L   E   N   D   A  R    1.0  ~               |
 |               Author (c) 2000  George Dimitrov Sotirov                |
 +-----------------------------------------------------------------------+
 | Програмата реализира календар за всяка година в интервала 1582 - 4903 |
 | (Грегориански календар). Има възможности за извеждане на всеки месец  |
 | поотделно, проверка за високосна година, дата на Великден и др.       |
 +-----------------------------------------------------------------------+
 | Реализация : 27. май. 2000 г., събота                                 |
 +-----------------------------------------------------------------------+}

program Kalendar;

uses
  crt, dos, gregor;

const
  mesi : array [1..12] of string[20] = ('Януари','Февруари','Март','Април',
                                        'Май','Юни','Юли','Август','Септември',
                                        'Октомври','Ноември','Декември');

type
  masiv = array [0..37] of string[2];

var
  den, mes, godina : word;
  izb, min, max : integer;
  mas : masiv;
  vr_niz : string;
  i : integer;

procedure logo;
{ извежда начален екран }
begin
  clrscr;
  gotoxy(20,6);  writeln('╔══════════════════════════════════════╗');
  gotoxy(20,7);  writeln('║            ГРЕГОРИАНСКИ              ║');
  gotoxy(20,8);  writeln('║     К  А  Л  Е  Н  Д  А  Р   1.0     ║');
  gotoxy(20,9);  writeln('╠══════════════════════════════════════╣');
  gotoxy(20,10); writeln('║     <*    1583 ÷ 4903 год.    *>     ║');
  gotoxy(20,11); writeln('╠══════════════════════════════════════╣');
  gotoxy(20,12); writeln('║  Автор 2000 Георги Димитров Сотиров  ║');
  gotoxy(20,13); writeln('╚══════════════════════════════════════╝');
  delay(3000);
  normvideo;
  gotoxy(80,25); writeln('');
end; { logo }

function menu: integer;
{ показва менюто на програмата    }
{ вход  : няма                    }
{ изход : изборът на потребителя  }
begin
  clrscr;
  gotoxy(20, 6); writeln('┌──────────────────────────────────────────┐');
  gotoxy(20, 7); writeln('│          К  А  Л  Е  Н  Д  А  Р          │');
  gotoxy(20, 8); writeln('├──────────────────────────────────────────┤');
  gotoxy(20, 9); writeln('│  1  - година ... (текуща : ',godina,')         │');
  gotoxy(20,10); writeln('│  2  - последователно извеждане по месеци │');
  gotoxy(20,11); writeln('│  3  - от ... до ... месец                │');
  gotoxy(20,12); writeln('│  4  - проверка за високосна година       │');
  gotoxy(20,13); writeln('│  5  - проверка за ден от седмицата       │');
  gotoxy(20,14); writeln('│  6  - дата на Великден през ',godina,' г.      │');
  gotoxy(20,15); writeln('│  7  - информация за автора               │');
  gotoxy(20,16); writeln('│ Esc - изход от прогрaмата                │');
  gotoxy(20,17); writeln('└──────────────────────────────────────────┘');
  menu := ord(readkey);
end; { menu }

procedure ceti_god;
{ прочита годината въведена от потребителя  }
begin
  clrscr;
  repeat
    gotoxy(25,13);
    write('Година [1583 .. 4903] : '); clreol;
    readln(godina);
  until (godina >= 1583) and (godina <= 4903);
end; { ceti_god }

function dob(niz : string): string;
{ добавя символи към низ  }
begin
  if length(niz) < 2 then niz := ' ' + niz;
  dob := niz;
end; { dob }

procedure izw_dni(mas : masiv; mes : word);
{ извежда масив от целочислени стойности в подходящ вид }
begin
  normvideo;
  gotoxy(33, 5); write(mesi[mes],', ',godina);
  gotoxy(16, 7); writeln('┌──────┬──────┬──────┬──────┬──────┬──────┬──────┐');
  gotoxy(16, 8); writeln('│  пон │  вт  │  ср  │  чет │  пет │  съб │  нед │');
  gotoxy(16, 9); writeln('├──────┴──────┴──────┴──────┴──────┴──────┴──────┤');
  gotoxy(16,10);   write('│  ',mas[ 0],'     ',mas[ 1],'     ',mas[ 2],'     ',mas[ 3],'     ',mas[ 4],'   ');
  gotoxy(52,10);   textcolor(red);
                 write('    ',mas[ 5],'     ',mas[ 6],'  '); normvideo; write('│');
  gotoxy(16,11);   write('│  ',mas[ 7],'     ',mas[ 8],'     ',mas[ 9],'     ',mas[10],'     ',mas[11],'   ');
  gotoxy(52,11);   textcolor(red);
                 write('    ',mas[12],'     ',mas[13],'  '); normvideo; write('│');
  gotoxy(16,12);   write('│  ',mas[14],'     ',mas[15],'     ',mas[16],'     ',mas[17],'     ',mas[18],'   ');
  gotoxy(52,12);   textcolor(red);
                 write('    ',mas[19],'     ',mas[20],'  '); normvideo; write('│');
  gotoxy(16,13);   write('│  ',mas[21],'     ',mas[22],'     ',mas[23],'     ',mas[24],'     ',mas[25],'   ');
  gotoxy(52,13);   textcolor(red);
                 write('    ',mas[26],'     ',mas[27],'  '); normvideo; write('│');
  gotoxy(16,14);   write('│  ',mas[28],'     ',mas[29],'     ',mas[30],'     ',mas[31],'     ',mas[32],'   ');
  gotoxy(52,14);   textcolor(red);
                 write('    ',mas[33],'     ',mas[34],'  '); normvideo; write('│');
  gotoxy(16,15); writeln('│  ',mas[35],'     ',mas[36],'                                     │');
  gotoxy(16,16); writeln('└────────────────────────────────────────────────┘');
  textcolor(blue);
  gotoxy(5,23);  writeln('┌────────────────────────────┬───────────────────────┬──────────────────┐');
  gotoxy(5,24);  writeln('│ Backspace - предишен месец │ Enter - следващ месец │ Esc - прекъсване │');
  gotoxy(5,25);  writeln('└────────────────────────────┴───────────────────────┴──────────────────┘');
  normvideo;
end; { izw_dni }

function kal(mes, god : word):integer;
{ функция, която връща броя дни на месеца               }
{ вход  : месец [1..12]                                 }
{ изход : цяло число даващо броя дни на месеца [28..31] }
begin
  case mes of
    1 : kal := 31;
    2 : if leapyear(god) then kal := 29 else kal := 28;
    3 : kal := 31;
    4 : kal := 30;
    5 : kal := 31;
    6 : kal := 30;
    7 : kal := 31;
    8 : kal := 31;
    9 : kal := 30;
    10 : kal := 31;
    11 : kal := 30;
    12 : kal := 31;
  end; { case }
end; { kal }

procedure izw_mesec(min,max : integer);
{ извежда месеците в интервала min .. max }
var
  m,i,p,q,t : integer;
begin
  m := min;
  repeat
    clrscr;
    for i := 0 to 36 do mas[i] := '  ';
    p := kal(m,godina);
    q := day_of_week1(1,m,godina);
    t := 0;
    for i := q to p + q - 1 do
    begin
      inc(t);
      mas[i] := dob(inttostr(t));
    end;
    izw_dni(mas,m);
    case ord(readkey) of
      8 : if m > min then dec(m);
      13 : if m <= max then inc(m);
      27 : break;
    end; { case }
  until m > max;
end; { izw_mesec }

begin
  godina := 2000;
  logo;
  repeat
    izb := menu;
    case izb of
      49 : begin
            ceti_god;
           end; { case #49 }
      50 : begin
            if not (godina > 0) then
            ceti_god;
            izw_mesec(1,12);
           end; { case #50 }
      51 : begin
            if not (godina > 0) then ceti_god;
            repeat
              clrscr;
              gotoxy(25,12); write('От месец : ');
              readln(min);
              gotoxy(25,13); write('До месец : ');
              readln(max);
            until ((min >= 1) and (min <= 12)) and ((max >= min) and (max <= 12));
            izw_mesec(min,max);
           end; { case #51 }
      52 : begin
            if not (godina > 0) then ceti_god;
            clrscr;
            if leapyear(godina) then
              vr_niz := 'Годината ' + inttostr(godina) + ' е високосна'
            else
              vr_niz := 'Годината ' + inttostr(godina) + ' не е високосна';
            gotoxy((trunc(80 - length(vr_niz)) div 2),13); write(vr_niz);
            readln;
            vr_niz := '';
           end; { case #52 }
      53 : begin
            clrscr;
            gotoxy(19,9); writeln('Моля, въведете необходимата информация ...');
            repeat
              gotoxy(26,11); write('Година [1583 .. 4903] : ');
              clreol;
              readln(godina);
            until (godina >= 1583) and (godina <= 4903);
            repeat
              gotoxy(26,12); write('Месец  [   1 ..   12] : ');
              clreol;
              readln(mes);
            until (mes >= 1) and (mes <= 12);
            repeat
              gotoxy(26,13); write('Ден    [   1 ..   ',kal(mes,godina),'] : ');
              clreol;
              readln(den);
            until (den >= 1) and (den <= kal(mes,godina));
            vr_niz := inttostr(den) + '/' + mesi[mes] + '/' + inttostr(godina) + ' - ' +
            dowa[day_of_week2(den,mes,godina)];
            clrscr;
            gotoxy((trunc(80 - length(vr_niz)) div 2),13); write(vr_niz);
            readln;
           end;
      54 : begin
            clrscr;
            gotoxy(20,12);
            write('───────────────────────────────────────────');
            gotoxy(20,13);
            write('  Великден през ',godina,' година е на ',easterday(godina));
            gotoxy(20,14);
            write('───────────────────────────────────────────');
            gotoxy(21,20);
            textcolor(red);
            write('Произвлен клавиш за връщане в гл. меню ... ');
            while not keypressed do ;
            normvideo;
           end;
      55 : begin
            clrscr;
            gotoxy(15,10); writeln('┌──────────────────────────────────────────────┐');
            gotoxy(15,11); writeln('│            Георги Димитров Сотиров           │');
            gotoxy(15,12); writeln('│----------------------------------------------│');
            gotoxy(15,13); writeln('│ Тел.   : +359 88 371 817                     │');
            gotoxy(15,14); writeln('│ Е-поща : sotirov@bitex.com                   │');
            gotoxy(15,15); writeln('│ WWW    : http://web.orbitel.bg/sotirov       │');
            gotoxy(15,16); writeln('│ FTP    : ftp://free.techno-link.com/astronom │');
            gotoxy(15,17); writeln('└──────────────────────────────────────────────┘');
            gotoxy(21,20); textcolor(red);
            write('Произвлен клавиш за връщане в гл. меню ... ');
            while not keypressed do ;
            normvideo;
           end;
    else
      if izb <> 27 then
      begin
        beep(888,50);
      end;
    end; { case }
  until izb = 27;
  clrscr;
end. { kalendar }

