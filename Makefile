CC = gcc

all:
	$(CC) -fPIC -shared hidden.c -o hidden.so

clean:
	rm *.so
