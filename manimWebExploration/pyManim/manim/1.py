from manim import *
import numpy as np

class GaussianSumEvolution(ThreeDScene):
    def construct(self):
        axes = ThreeDAxes()
        self.set_camera_orientation(phi=75 * DEGREES, theta=30 * DEGREES)
        self.add(axes)

        initial_gaussians = [
            Gaussian(mean=[-2, -2], variance=0.5),
            Gaussian(mean=[2, 2], variance=0.5),
            Gaussian(mean=[-3, 3], variance=0.8),
        ]

        gaussian_surfaces = [gaussian.create_surface() for gaussian in initial_gaussians]
        self.play(*[Create(surface) for surface in gaussian_surfaces])

        for _ in range(3):
            for gaussian in initial_gaussians:
                gaussian.update()

            updated_surfaces = [gaussian.create_surface() for gaussian in initial_gaussians]

            self.play(*[Transform(surface, updated_surface) for surface, updated_surface in zip(gaussian_surfaces, updated_surfaces)])
            gaussian_surfaces = updated_surfaces

            self.wait(1)

class Gaussian:
    def __init__(self, mean, variance):
        self.mean = mean
        self.variance = variance

    def update(self):
        self.mean[0] += 1
        self.mean[1] += 1
        self.variance += 0.1

    def create_surface(self):
        resolution = (42, 42)
        u_range = (-10, 10)
        v_range = (-10, 10)

        return Surface(
            lambda u, v: np.array([u, v, self.function(u, v)]),
            resolution=resolution,
            u_range=u_range,
            v_range=v_range,
            checkerboard_colors=[BLUE_D, BLUE_E],
        )

    def function(self, u, v):
        return np.exp(-(((u - self.mean[0]) ** 2) + ((v - self.mean[1]) ** 2)) / (2 * self.variance**2))
