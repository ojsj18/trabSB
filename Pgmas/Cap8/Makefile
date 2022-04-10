CC = gcc
CFLAGS = -fPIC -g
FONTES_C = a.c b.c

all: main-static main


main-static: libStatic.a
	gcc -static main.c -o main-static -lStatic -L.

libStatic.a: a-static.o b-static.o
	ar -src libStatic.a a-static.o b-static.o

a-static.o : a.c
	$(CC) -c a.c -o a-static.o

b-static.o : b.c
	$(CC) -c b.c -o b-static.o



main: libMySharedLib.so main.c 
	$(CC) main.c -lMySharedLib -L.    -o $@


libMySharedLib.so: a.o b.o
	gcc -fPIC -shared a.o b.o -o libMySharedLib.so

a.o : a.c
	$(CC) $(CFLAGS) -c a.c -o a.o

b.o : b.c
	$(CC) $(CFLAGS) -c b.c -o b.o

clean:
	rm -f main main-static *.o libMySharedLib.so libStatic.a
