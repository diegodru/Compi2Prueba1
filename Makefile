CC := g++
FILE_EXT := cpp
PROG := prueba
BISON_HEADER := tokens.h
CFLAGS:= 

all: $(PROG)

$(PROG): $(PROG).tab.o lex.yy.o
	$(CC) -lm -o $@ $^

lex.yy.o: lex.yy.$(FILE_EXT)
	$(CC) -include $(BISON_HEADER) -c -o $@ $^

$(PROG).tab.o: $(PROG).tab.$(FILE_EXT)
	$(CC) -c -o $@ $^

main.o: main.c
	$(CC) -include $(BISON_HEADER) -c -o $@ $^

lex.yy.$(FILE_EXT): $(PROG).l
	flex -o $@ $^

$(PROG).tab.$(FILE_EXT): $(PROG).y
	bison --defines=$(BISON_HEADER) -o $@ $^

clean: 
	rm *.o $(PROG).tab.$(FILE_EXT) lex.yy.$(FILE_EXT) $(BISON_HEADER)
