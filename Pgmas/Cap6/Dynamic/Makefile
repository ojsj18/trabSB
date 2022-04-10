CC = gcc
CFLAGS = -Wall -fPIC
LD = ld
LDFLAGS = -shared

FONTES_C = a.c b.c 
OBJS_C  = $(FONTES_C:%.c=%.o)

mainDynamic: libMyDynamicLib.so  main.c
	$(CC) main.c -L. -o $@ -ldl

libMyDynamicLib.so: $(OBJS_C)
	$(LD) $(LDFLAGS) -o $@ $(OBJS_C)
	cp  $@ $(HOME)/usr/lib/.

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

all: mainDynamic

clean:
	rm -f mainDynamic  libMyDynamicLib.so $(OBJS_C)
