from manim import *

import numpy as np
from sklearn.mixture import GaussianMixture

class GMMAnimation(ThreeDScene):
    def construct(self):
        axes = ThreeDAxes(
            x_range=[-7, 7],
            y_range=[-7, 7],
            z_range=[-7, 7],
        )
        self.set_camera_orientation(phi=75 * DEGREES, theta=30 * DEGREES, zoom=0.8)
        self.begin_ambient_camera_rotation(rate=0.1)

        self.add(axes)

        np.random.seed(42)
        data = np.concatenate([
            np.random.normal(loc=[-2, -2], scale=0.5, size=(50, 2)),
            np.random.normal(loc=[2, 2], scale=0.5, size=(50, 2)),
            np.random.normal(loc=[-3, 3], scale=0.8, size=(50, 2)),
        ])

        gmm = GaussianMixture(n_components=3, covariance_type='full', random_state=42)
        gmm.fit(data)

        # adding points with spheres from data
        data_points = self.create_data_points(data)
        self.play(Create(data_points))

        # gaussian_surfaces = [
        #     GaussianSurface(mean, covariance, weight).create_surface()
        #     for mean, covariance, weight in zip(gmm.means_, gmm.covariances_, gmm.weights_)
        # ]
        # initializing randomly in the beginning
        random_means = np.random.normal(loc=0, scale=5, size=(3, 2))
        random_covariances = np.array([np.eye(2) for _ in range(3)])
        random_weights = np.array([1/3 for _ in range(3)])
        gaussian_surfaces = [
            GaussianSurface(mean, covariance, weight).create_surface()
            for mean, covariance, weight in zip(random_means, random_covariances, random_weights)
        ]

        self.play(*[Create(surface) for surface in gaussian_surfaces])

        self.wait(3)

        num_iter = 4

        for i in range(num_iter):
            gmm.fit(data)

            transforms = []
            for surface, mean, covariance, weight in zip(gaussian_surfaces, gmm.means_, gmm.covariances_, gmm.weights_):
                # also adding rotation like we did for the axes below
                new_surface = GaussianSurface(mean + np.random.normal(loc=0, scale=0.6, size=2), covariance, weight).create_surface()#.copy().rotate(PI/4, axis=axes.c2p(0, 1, 0))
                transforms.append(Transform(surface, new_surface, run_time = 1))

            # transforms = [[
            #     Transform(surface, )
            #     for surface, mean, covariance, weight in zip(gaussian_surfaces, gmm.means_, gmm.covariances_, gmm.weights_)
            # ]]

            # rotated_axes = axes.copy().apply_matrix([[np.cos(PI/4), -np.sin(PI/4), 0], [np.sin(PI/4), np.cos(PI/4), 0], [0, 0, 1]])
            # transforms.append(Transform(axes, rotated_axes))
            self.play(*transforms)

        self.wait(3)


    def create_data_points(self, data):
        points = []
        for point in data:
            points.append(np.append(point, 0))

        data_points = VGroup(*[Dot(point, radius=0.05) for point in points])
        return data_points


class GaussianSurface(ThreeDVMobject):
    def __init__(self, mean, covariance, weight, **kwargs):
        super().__init__(**kwargs)
        self.resolution = (40, 40)
        self.mean = mean
        self.covariance = covariance
        self.weight = weight

    def create_surface(self):
        u_range = (-6, 6)
        v_range = (-6, 6)

        return Surface(
            lambda u, v: np.array([u, v, self.function(u, v)]),
            resolution=self.resolution,
            u_range=u_range,
            v_range=v_range,
            color=interpolate_color(WHITE, BLUE, 0.7),
            shade_in_3d=True,
        )

    def function(self, u, v):
        delta = np.array([u - self.mean[0], v - self.mean[1]])
        exponent = -0.5 * delta.T @ np.linalg.inv(self.covariance) @ delta
        normalization = 10
        return self.weight * normalization * np.exp(exponent)

    def update(self, new_mean, covariance):
        self.mean = new_mean[0]
        self.covariance = covariance
        self.become(self.create_surface())

# Run the animation
GMMAnimation().render()
