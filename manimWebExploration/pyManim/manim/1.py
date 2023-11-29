from manim import *
import numpy as np

class ThreeDAnimation(ThreeDScene):
    def construct(self):
        # Create 3D axes
        axes = ThreeDAxes()
        self.set_camera_orientation(phi=75 * DEGREES, theta=30 * DEGREES)
        self.add(axes)

        # Create two 3D Gaussian surfaces
        gaussian1 = GaussianSurface(color=RED)
        gaussian2 = GaussianSurface(color=BLUE)

        self.play(Create(gaussian1.surface), Create(gaussian2.surface))

        # Animate the movement of Gaussians
        self.play(
            MoveAlongPath(gaussian2.surface, self.get_path(gaussian2), rate_func=linear),
            run_time=3
        )

        self.wait(1)

    def get_path(self, gaussian):
        # Define the path for the movement (change this based on your requirement)
        if gaussian.color == RED:
            return ParametricFunction(lambda t: np.array([0, 0, gaussian.function(0, 0)]), t_range=[-6, 6], color=WHITE)
        else:
            return ParametricFunction(lambda t: np.array([t, t, gaussian.function(t, t - 3)]), t_range=[-6, 6], color=WHITE)

class GaussianSurface(ThreeDVMobject):
    def __init__(self, color, **kwargs):
        super().__init__(**kwargs)
        self.resolution = (42, 42)
        self.color = color
        self.create_gaussian_surface()

    def create_gaussian_surface(self):
        self.surface = self.get_surface()
        self.add(self.surface)

    def get_surface(self):
        return Surface(
            lambda u, v: np.array([u, v, self.function(u, v)]),
            resolution=self.resolution,
            u_range=(-2, 2),
            v_range=(-2, 2),
            checkerboard_colors=[self.color, self.color],
        )

    def function(self, u, v):
        # Define the function for the Gaussian (customize as needed)
        if self.color == RED:
            return np.exp(-(((u - 0) ** 2) + ((v - 0) ** 2)) / 1)
        else:
            self.color = RED
            return np.exp(-(((u - 1) ** 2) + ((v - 1) ** 2)) / 1)
