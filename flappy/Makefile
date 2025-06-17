CXX = g++
CXXFLAGS = -std=c++17 -ObjC++ -Wall
LIBS = `sdl2-config --libs`
INCLUDES = `sdl2-config --cflags`

all: flappy

flappy: src/main.mm
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ $^ $(LIBS)

clean:
	rm -f flappy
