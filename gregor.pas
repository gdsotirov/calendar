unit gregor;
{ +-----------------------------------------------------+
  | Mодул, с функции за работа с Грегорианския календар |
  +-----------------------------------------------------+
  | Файл   : gregor.pas   | Автор : Георги Д. Сотиров   |
  | Версия : 1.2          |         sotirov@bitex.com   |
  +-----------------------+-----------------------------+
  | Използване : Модулът може да бъде използван за раз- |
  |              работване на DOS програми на езика     |
  |              Pascal, като за правилната им работа   |
  |              е необходим кириличен драйвер.         |
  +-----------------------------------------------------+}

interface
const
  dowa : array [0..6] of string[20] = ('Понеделник','Вторник','Сряда','Четвъртък','Петък','Събота','Неделя');

type
  dayT   = 1..31;
  monthT = 1..12;
  yearT  = 1582..4903;

function leapyear(year: yearT): boolean;
function day_of_week1(d, m, y : word): byte;
function day_of_week2(d, m, y : word): byte;
function days_in_month(month : byte; year : yearT): byte;
function day_of_year(d, m, y : word): word;
function easterday(y : yearT):string;
function inttostr(i : longint): string;


implementation

{ Transforms an integer to a string.				}
{  Input  : a longint value					}
{  Output : a string representig the inputed value		}
function inttostr(i : longint): string;
var
	s : string[11];
begin
	str(i, s);
	inttostr := s;
end;

{ Finds if the given year is a leap year			}
{  Input  : the year in range 1583 - 4903			}
{  Output : true - if the given year is leap, else false	}
function leapyear(year : yearT): boolean;
begin
	leapyear := ((year mod 4) = 0) and
		((year mod 100) > 0) or
		((year mod 400) = 0)
end;

function day_of_week1(d, m, y : word): byte;
{ Функция, която намира деня от седмицата по подадена дата : ден, месец,}
{ година. Предполага се подаване на правилни данни !                    }
{  вход  : ден, месец, година                                           }
{  изход : число в интервала 0 - 6                                      }
var
  ta, tb, tc : longint;
begin
  if m > 2 then
    m := m - 3
  else
    begin
      m := m + 9;
      y := y - 1;
    end;
  ta := 146097 * (y div 100) div 4;
  tb := 1461 * (y MOD 100) div 4;
  tc := (153 * m + 2) div 5 + d + 1721119;
  day_of_week1 := (ta + tb + tc) mod 7;
end;

function day_of_week2(d, m, y : word): byte;
{ Същата като предходната, но с различен алгоритъм                      }
begin
  if m < 3 then
    begin
      dec(y);
      inc(m,12);
    end;
  d := y + y div 4 - y div 100 + y div 400 + 3*m - (2*m+1) div 5 + d;
  day_of_week2 := d mod 7;
end;

{ Gives the days in the month for a given year			}
{  Input  : the month and the year				}
{  Output : number of days for the month			}
function days_in_month(month : byte; year : yearT): byte;
begin
	case month of
		1,3,5,7,8,10,12 : days_in_month := 31;
		4,6,9,11        : days_in_month := 30;
		2               : if leapyear(year) then days_in_month := 29
				else days_in_month := 28;
	end;
end;

function day_of_year(d, m, y : word): word;
{ Функция, която намира номера на деня в годината по зададена дата      }
{  вход  : ден, месец, година                                           }
{  изход : цяло число даващо номера на зададения календарен ден         }
{          в годината                                                   }
var
  den : real;
begin
  den := 3055*(m+2)/100 - (m+10)/13*2 - 91 + (1-(y-y/4*4+3)/4 +
         (y-y/100*100+99)/100 - (y-y/400*400+344)/400) + (m+10)/13 + d;
  day_of_year := round(den);
end;

function easterday(y: yearT):string;
{ Функция, която намира дата на Великден за дадена година. Функцията    }
{ реализира алгоритъма на Гаус.                                         }
{  вход  : годината, която се проверява                                 }
{  изход : низ, представящ датата на Великден за проверяваната година   }
var
  n1, n2, n3, n4, n5, na, nb, nc, vel : integer;
begin
  n1 := y mod 19;
  n2 := y mod 4;
  n3 := y mod 7;
  na := 19 * n1 + 16;
  n4 := na mod 30;
  nb := 2 * n2 + 4 * n3 + 6 * n4;
  n5 := nb mod 7;
  nc := n4 + n5; { число в интервала 1 .. 35 }
  { определяне на дата между 4 април и 8 май }
  vel := nc + 3;
  if vel <= 30 then
    easterday := inttostr(vel) + ' април'
  else
    begin
      vel := vel - 30;
      easterday := inttostr(vel) + ' май'
    end;
end;

end.

