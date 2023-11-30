from manim import *

class ScatterPlot3DExample(ThreeDScene):
    def construct(self):
        # Create 3D axes
        axes = ThreeDAxes(
            x_range=[-5, 5],
            y_range=[-5, 5],
            z_range=[-5, 5],
        )

        # Show axes
        self.play(Create(axes))

        # List of 3D points
        points = [(1, 2, 3), (-3, 4, -2), (0, -1, 5), (2, 0, -1)]

        # Create scatter plot with dots
        scatter_plot = VGroup(*[Dot(axes.c2p(x, y, z), color=RED) for x, y, z in points])

        # Display scatter plot on the graph
        self.play(Create(scatter_plot))

        self.wait(2)
