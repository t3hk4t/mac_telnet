# Simple mac-telnet program that was used to practice socket programming
# Author: Leonards Elksnis

# Some basic variable setup

CC = g++
OPTIMIZE = no
MAKE_CXX_VERSION = c++17
TARGET = mac_telnet
.PHONY: $(TARGET)

# Flags and includes

CXXFLAGS = -Wall -std=$(MAKE_CXX_VERSION)

ifeq ($(OPTIMIZE),no)
	CXXFLAGS += -g
else 
	CXXFLAGS += -Ofast
endif

CXXFLAGS += \
	-I./include

# Target processing

all: $(TARGET)

$(TARGET): src/main.cpp
	$(CC) $(CXXFLAGS) -o $(TARGET) src/main.cpp

clean: 
	$(RM) $(TARGET)