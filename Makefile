FPC=/usr/bin/fpc

calendar: calendar.pas gregor.pas
	$(FPC) $<

all: calendar

clean:
	rm -f *.o *.ppu calendar

