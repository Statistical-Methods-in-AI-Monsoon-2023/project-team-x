from manim import *

class ScatterPoints3DExample(ThreeDScene):
    def construct(self):
        # Create 3D axes
        axes = ThreeDAxes(
            x_range=[-5, 5, 10],
            y_range=[-5, 5, 10],
            z_range=[-5, 5, 10],
        )

        # Display the axes
        self.play(Create(axes))

        # # List of 3D points
        # points = [(1, 2, 3), (-3, 4, -2), (0, -1, 5), (2, 0, -1)]

        # # Create and display points on the graph
        # for x, y, z in points:
        #     point = Dot(axes.c2p(x, y, z), color=RED)
        #     self.add(point)

        # self.wait(2)
