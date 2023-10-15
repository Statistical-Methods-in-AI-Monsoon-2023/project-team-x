# Manim Web Project template

## Using the Manim Web CLI

You need to have the Manim Web CLI installed.
Follow the [Getting Started tutorial](https://manim-web.hugos29.dev/getting-started)
to install it.

Run:

```bash
manimweb init {folder}
```

By default, the CLI will use this repository.

Then, go to the folder and install the dependencies with:

```bash
cd {folder}
pub get
```

Finally, you can run the Dev Server with:

```bash
manimweb dev --file src/example.dart --html src/example.html
```

If you renamed some of the files or folders, change the command with the new
names.

Then, follow the link in the console.

## Updating

- Update the Manim Web Library with `pub add manim_web`
- Update the Manim Web CLI with `pub global activate manim_web`
