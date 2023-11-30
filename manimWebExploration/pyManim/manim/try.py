from manim import *

class ContinuousRotationExample(ThreeDScene):
    def construct(self):
        axes = ThreeDAxes()

        self.set_camera_orientation(phi=60 * DEGREES, theta=-45 * DEGREES)

        self.play(Create(axes))

        # Define an update function to continuously rotate the scene
        def update_rotation(mob, dt):
            mob.rotate(0.1 * dt, about_point=ORIGIN)

        # Apply the update function continuously
        self.always_apply(update_rotation)

        self.wait(5)
