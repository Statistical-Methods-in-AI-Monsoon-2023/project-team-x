from manim import *
import numpy as np

class GaussianSumEvolution(ThreeDScene):
    def construct(self):
        # Create 3D axes
        axes = ThreeDAxes()
        self.set_camera_orientation(phi=75 * DEGREES, theta=30 * DEGREES)
        self.add(axes)

        # Initial Gaussians
        initial_gaussians = [
            Gaussian(mean=[-2, -2], variance=0.5),
            Gaussian(mean=[2, 2], variance=0.5),
            Gaussian(mean=[-3, 3], variance=0.8),
        ]

        # Create Gaussian surfaces for the initial state
        gaussian_surfaces = [gaussian.create_surface() for gaussian in initial_gaussians]
        self.play(*[Create(surface) for surface in gaussian_surfaces])

        # Evolution over time
        for _ in range(3):
            # Update Gaussians for the next time step
            for gaussian in initial_gaussians:
                gaussian.update()

            # Smoothly transition between surfaces
            self.play(*[Transform(surface, gaussian.create_surface()) for surface, gaussian in zip(gaussian_surfaces, initial_gaussians)])
            self.wait(1)

class Gaussian:
    def __init__(self, mean, variance):
        self.mean = mean
        self.variance = variance

    def update(self):
        # Update the Gaussian for the next time step (for example, change mean or variance)
        self.mean[0] += 0.5
        self.mean[1] += 0.5
        self.variance += 0.1

    def create_surface(self):
        resolution = (42, 42)
        u_range = (-6, 6)
        v_range = (-6, 6)

        return Surface(
            lambda u, v: np.array([u, v, self.function(u, v)]),
            resolution=resolution,
            u_range=u_range,
            v_range=v_range,
            checkerboard_colors=[BLUE_D, BLUE_E],
        )

    def function(self, u, v):
        # Gaussian function
        return np.exp(-(((u - self.mean[0]) ** 2) + ((v - self.mean[1]) ** 2)) / (2 * self.variance**2))
