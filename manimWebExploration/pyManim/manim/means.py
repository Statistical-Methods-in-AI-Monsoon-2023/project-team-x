from manim import *

class UpdateMeans(Scene):
    def construct(self):
        # Initial Gaussian parameters
        mean_x = 0
        mean_y = 0
        std_dev = 0.5

        # Create Gaussian
        gaussian = self.get_gaussian(mean_x, mean_y, std_dev)
        self.play(ShowCreation(gaussian))

        # Update means along x and y
        self.update_gaussian(gaussian, mean_x + 1, mean_y)
        self.wait(1)
        self.update_gaussian(gaussian, mean_x + 1, mean_y + 1)
        self.wait(1)

    def get_gaussian(self, mean_x, mean_y, std_dev):
        gaussian = VGroup()
        gaussian.add(
            ParametricFunction(
                lambda x: np.exp(-0.5 * ((x - mean_x) / std_dev) ** 2) / (std_dev * np.sqrt(2 * np.pi)),
                color=WHITE,
                t_range=[-4, 4],
            )
        )
        gaussian.add(
            ParametricFunction(
                lambda y: np.exp(-0.5 * ((y - mean_y) / std_dev) ** 2) / (std_dev * np.sqrt(2 * np.pi)),
                color=WHITE,
                t_range=[-4, 4],
            ).rotate(PI / 2)
        )
        return gaussian

    def update_gaussian(self, gaussian, new_mean_x, new_mean_y):
        new_gaussian = self.get_gaussian(new_mean_x, new_mean_y, 0.5)
        self.play(Transform(gaussian, new_gaussian))
        
UpdateMeans().render()
