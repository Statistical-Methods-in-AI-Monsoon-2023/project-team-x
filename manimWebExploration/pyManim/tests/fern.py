from manim import *

import random

config.frame_height = 16
config.frame_width = 9
config.pixel_width = 1080
config.pixel_height = 1920
config.frame_rate = 60

class Fern(Scene):
    
    radius = 0.03
    xRange = (-2.7, 2.7)
    yRange = (0, 10)
    xLength = 8;
    yLength = 10
    
    def construct(self):
        axes = Axes(x_range=self.xRange, y_range=self.yRange, x_length=self.xLength, y_length=self.yLength)
        axes = axes.to_edge(DOWN)

        coords = [(0, 0)]
        dots = [Dot(axes.c2p(0, 0))]
        types = [None, 1, 1, 3, 1, 2, 1, 1, 3, 1]
        
        
        for n in range(100 - 9):
            r = random.random()
            if r < 0.01:
                c = 0
            elif r < 0.86:
                c = 1
            elif r < 0.93:
                c = 2
            else:
                c = 3
            types.append(c)
        
        for c in types[1:]:
            x, y = self.getPoint(*coords[-1], c)
            coords.append((x, y))
            dot = Dot(axes.c2p(x, y))
            dots.append(dot, radius=0.03, color=GREEN_C)


        self.wait(0.3)
        self.play(
            AnimationGroup(
                *[FadeIn(d) for d in dots],
                lag_ratio=1,
                run_time=7
            ),
        )
        self.wait(0.5)
        self.play(VGroup(*dots).animate.set_color(GREEN_E))
        self.wait(1)
        self.play(FadeOut(*self.mobjects))
        self.wait(0.5)
        
    def getPoint(self, x, y, c):
        if c == 0: return 0.00 * x + 0.00 * y,  0.00 * x + 0.16 * y + 0.00
        if c == 1: return 0.85 * x + 0.04 * y, -0.04 * x + 0.85 * y + 1.60
        if c == 2: return 0.20 * x - 0.26 * y,  0.23 * x + 0.22 * y + 1.60
        return -0.15 * x + 0.28 * y,  0.26 * x + 0.24 * y + 0.44