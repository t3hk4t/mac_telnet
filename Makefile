# Simple mac-telnet program that was used to practice socket programming
# Author: Leonards Elksnis

# Some basic variable setup

CC = g++
OPTIMIZE = yes
MAKE_CXX_VERSION = gnu++17
TARGET = mac_telnet
DIRS=build build/bin

# Flags and includes

CXXFLAGS = -Wall -std=$(MAKE_CXX_VERSION) -DLOCALEDIR='"/usr/local/share/locale"'

ifeq ($(OPTIMIZE),no)
	CXXFLAGS += -g -fpermissive
else 
	CXXFLAGS += -Ofast
endif

CXXFLAGS += \
	-I./include

LIBS = \
	-lssl \
	-lcrypto 

# Target processing

all: preprocess $(TARGET) postprocess

preprocess:
	mkdir -p $(DIRS)

$(TARGET): autologin.o console.o interfaces.o mactelnet.o protocol.o mndp.o mtwei.o
	$(CC) $(CXXFLAGS) -o $(TARGET) autologin.o console.o interfaces.o mactelnet.o protocol.o mndp.o mtwei.o -L/usr/lib $(LIBS)

autologin.o: include/autologin.hpp
	$(CC) $(CXXFLAGS) -c src/autologin.cpp

console.o: include/console.hpp
	$(CC) $(CXXFLAGS) -c src/console.cpp

interfaces.o: include/interfaces.hpp
	$(CC) $(CXXFLAGS) -c src/interfaces.cpp

macping.o: 
	$(CC) $(CXXFLAGS) -c src/macping.cpp

mactelnet.o: include/mactelnet.hpp 
	$(CC) $(CXXFLAGS) -c src/mactelnet.cpp

protocol.o: include/protocol.hpp
	$(CC) $(CXXFLAGS) -c src/protocol.cpp

mndp.o: include/mndp.hpp
	$(CC) $(CXXFLAGS) -c src/mndp.cpp

mtwei.o: include/mtwei.hpp
	$(CC) $(CXXFLAGS) -c src/mtwei.cpp

users.o: include/users.hpp
	$(CC) $(CXXFLAGS) -c src/users.cpp

clean: 
	$(RM) -r $(TARGET) build

postprocess: 
	mv autologin.o console.o interfaces.o mactelnet.o protocol.o mndp.o mtwei.o ./build
	mv mac_telnet ./build/bin