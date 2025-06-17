#include <SDL2/SDL.h>
#include <vector>
#include <cstdlib>
#include <ctime>

struct Bird {
    float x, y, velocity;
    const int size = 20;
    Bird(int startX, int startY) : x(startX), y(startY), velocity(0) {}
    void update(float dt) {
        velocity += 600 * dt; // gravity
        y += velocity * dt;
    }
    void flap() {
        velocity = -250;
    }
    SDL_Rect rect() const { return SDL_Rect{(int)x, (int)y, size, size}; }
};

struct Pipe {
    float x;
    int gapY;
    const int width = 50;
    const int gap = 150;
    Pipe(int startX, int gapYPos) : x(startX), gapY(gapYPos) {}
    void update(float dt) { x -= 200 * dt; }
    SDL_Rect topRect() const { return SDL_Rect{(int)x, 0, width, gapY}; }
    SDL_Rect bottomRect(int screenH) const { return SDL_Rect{(int)x, gapY + gap, width, screenH - (gapY + gap)}; }
    bool offscreen() const { return x + width < 0; }
};

class Game {
public:
    Game() : window(nullptr), renderer(nullptr), running(false), score(0) {}
    bool init();
    void run();
    void clean();
private:
    SDL_Window* window;
    SDL_Renderer* renderer;
    Bird bird{100, 200};
    std::vector<Pipe> pipes;
    bool running;
    int score;
    void reset();
    void spawnPipe();
    bool checkCollision(const Pipe& p);
};

bool Game::init() {
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_TIMER) != 0) return false;
    window = SDL_CreateWindow("Flappy Bird", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 480, 640, 0);
    if (!window) return false;
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    if (!renderer) return false;
    srand((unsigned)time(nullptr));
    reset();
    running = true;
    return true;
}

void Game::spawnPipe() {
    int gapY = 100 + rand() % 300;
    pipes.emplace_back(480, gapY);
}

void Game::reset() {
    bird = Bird(100, 200);
    pipes.clear();
    spawnPipe();
    score = 0;
}

bool Game::checkCollision(const Pipe& p) {
    SDL_Rect b = bird.rect();
    SDL_Rect top = p.topRect();
    SDL_Rect bottom = p.bottomRect(640);
    SDL_Rect result;
    return SDL_IntersectRect(&b, &top, &result) || SDL_IntersectRect(&b, &bottom, &result) || b.y < 0 || b.y + b.h > 640;
}

void Game::run() {
    Uint32 last = SDL_GetTicks();
    while (running) {
        SDL_Event e;
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT) running = false;
            if (e.type == SDL_KEYDOWN && e.key.keysym.sym == SDLK_SPACE)
                bird.flap();
            if (e.type == SDL_MOUSEBUTTONDOWN && e.button.button == SDL_BUTTON_LEFT)
                bird.flap();
            if (e.type == SDL_FINGERDOWN)
                bird.flap();
        }
        Uint32 now = SDL_GetTicks();
        float dt = (now - last) / 1000.f;
        last = now;
        bird.update(dt);
        if (!pipes.empty() && pipes.front().offscreen()) {
            pipes.erase(pipes.begin());
            score++;
        }
        if (pipes.empty() || pipes.back().x < 280) spawnPipe();
        for (auto& p : pipes) {
            p.update(dt);
            if (checkCollision(p)) reset();
        }
        SDL_SetRenderDrawColor(renderer, 135, 206, 235, 255);
        SDL_RenderClear(renderer);
        SDL_SetRenderDrawColor(renderer, 255, 255, 0, 255);
        SDL_Rect br = bird.rect();
        SDL_RenderFillRect(renderer, &br);
        SDL_SetRenderDrawColor(renderer, 34, 139, 34, 255);
        for (auto& p : pipes) {
            SDL_Rect top = p.topRect();
            SDL_Rect bottom = p.bottomRect(640);
            SDL_RenderFillRect(renderer, &top);
            SDL_RenderFillRect(renderer, &bottom);
        }
        SDL_RenderPresent(renderer);
        SDL_Delay(16);
    }
}

void Game::clean() {
    if (renderer) SDL_DestroyRenderer(renderer);
    if (window) SDL_DestroyWindow(window);
    SDL_Quit();
}

int main(int argc, char* argv[]) {
    Game game;
    if (!game.init()) return 1;
    game.run();
    game.clean();
    return 0;
}

