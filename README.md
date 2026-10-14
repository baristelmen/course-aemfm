<!-- PROJECT LOGO -->
<br />
<div align="center">

  <h3 align="center">Advanced Experimental Methods in Fluid Mechanics – Acquisition and Signal Processing</h3>

  <p align="center">
    Statistical analysis of experimental and synthetic signals with Python, run in JupyterLab.
 <br />
    <br />
    <a href="https://github.com/baristelmen/M2-IPP-AEMFM/issues">Report Bug</a>
    ·
    <a href="https://github.com/baristelmen/M2-IPP-AEMFM/pulls">Request Feature</a>
  </p>
</div>

<div align="center"> <table> <tr> <th align="left">Level</th> <td>Master 2 (M2)</td> </tr> <tr> <th align="left">Institution</th> <td>ENSTA Paris – Institut Polytechnique de Paris</td> </tr> <tr> <th align="left">Lecturer</th> <td>Romain Monchaux (<a href="mailto:monchaux@ensta.fr">monchaux@ensta.fr</a>)</td> </tr> <tr> <th align="left">Repository maintainer</th> <td><a href="https://github.com/baristelmen">Baris Telmen</a></td> </tr> </table> </div>

## Table of Contents

- [About this repository](#about-this-repository)
- [Getting started](#getting-started)
  - [Requirements](#requirements)
  - [About the data in this repository](#about-the-data-in-this-repository)
  - [Get the repository](#get-the-repository)
  - [Option A: Docker Compose (recommended)](#option-a-docker-compose-recommended)
  - [Option B: Standalone container](#option-b-standalone-container)
  - [Using MATLAB](#using-matlab)
- [Getting help](#getting-help)
- [Contributing](#contributing)
- [License](#license)

## About this repository

This repository contains the material and a ready-to-use environment for the **Acquisition – Signal processing** tutorials of the *Advanced Experimental Methods in Fluid Mechanics* course (M2, Institut Polytechnique de Paris). The tutorials cover:

1. **Gaussian white noise:** mean, standard deviation, probability density function (PDF), power spectral density with `scipy.signal.welch`, and auto-correlation.
2. **Three synthetic signals:** identifying their nature from their moments, spectra, PDFs and auto-correlations.
3. **Real signals:** hot-wire velocity in a turbulent jet and in a cylinder wake, and the pressure response of a gong forced by a coil-magnet system.

The repository provides:

- **`python/`** – Python scripts to complete during the tutorials, usable directly or inside a Jupyter notebook.
- **`matlab/`** – the equivalent MATLAB material (see [Using MATLAB](#using-matlab)).
- **`data/`** – the signals analysed in the tutorials.
- **`docker-compose.yaml`** – a Docker Compose setup that pulls the `baristelmen/course-aemfm` image, a JupyterLab environment with the scientific Python stack (NumPy, SciPy, Matplotlib) pre-installed.

No local installation of Python packages is needed: everything runs inside the container, and your work is saved in the repository folder on your computer.

## Getting started

### Requirements

- [Docker](https://docs.docker.com/get-docker/) (Docker Desktop on Windows/macOS, Docker Engine on Linux) with the Compose plugin, which ships with standard installations.
- Hardware virtualization enabled in BIOS/UEFI (Windows/macOS).
- At least 4 GB of RAM and a network connection for the first download.

### About the data in this repository

> [!IMPORTANT]
> **Always work with the signals provided for the current session.** The `data` folder contains the signal files used in the tutorials (`signaljet`, `signal_cylindre.txt`, `gong_force.wav`, …), but the course data is the reference.
>
> If a file is missing or has been updated:
>
> 1. **Download the files** the page provided during the course.
> 2. **Put them in the `data` folder**, using either method:
>    - **On your computer:** copy the files into the `data` folder with your file explorer (Finder, Windows Explorer, etc.).
>    - **In JupyterLab:** once the environment is running (see below), open `work/data` and drag the files into the file browser, or use the **Upload** button.
>
> Both methods write to the same folder, so the files appear on your computer and in JupyterLab.

### Get the repository

```shell
git clone https://github.com/baristelmen/M2-IPP-AEMFM.git
cd M2-IPP-AEMFM
```

Or [download the ZIP](https://github.com/baristelmen/M2-IPP-AEMFM/archive/refs/heads/main.zip), unzip it, and open a terminal in the unzipped folder.

Both options use the image `baristelmen/course-aemfm:2026-lab-4.6.3`, which is built on the official Jupyter Docker Stacks `minimal-notebook`. The login password is set with the `JUPYTER_TOKEN` environment variable. The default password is **`AEMFM`**.

The whole repository is shared with the container: in JupyterLab, it appears as the `work` folder, with `python/`, `data/` and `matlab/` inside.

### Option A: Docker Compose (recommended)

**Set the password.** Edit `docker-compose.yaml` at the root of the repository and change the value of `JUPYTER_TOKEN`:

```yaml
    environment:
      - JUPYTER_TOKEN=AEMFM      # change to your own password
```

To use a different port on your computer, change the left side of `"8888:8888"` (for example `"9999:8888"`).

**Start the environment:**

```shell
docker compose up -d
```

The first run downloads the image, which can take a while. Then:

1. Open **http://localhost:8888/lab** in your browser.
2. Enter the password set in `docker-compose.yaml`.
3. Open the scripts in `work/python`. Everything you save in `work` stays in the repository folder on your computer after the container stops.

To change the password later, edit `docker-compose.yaml` and run `docker compose up -d` again. Compose recreates the container with the new value, and your files are kept.

To stop the environment:

```shell
docker compose down
```

### Option B: Standalone container

**Set the password** with `-e JUPYTER_TOKEN=...` when starting the container. Run this command from the root of the repository:

```shell
docker run -d --name aemfm \
  -p 8888:8888 \
  -e JUPYTER_TOKEN=AEMFM \
  -v "$(pwd):/home/jovyan/work" \
  baristelmen/course-aemfm:2026-lab-4.6.3
```

On Windows PowerShell, replace `$(pwd)` with `${PWD}` and the `\` line breaks with a backtick (`` ` ``). Then open **http://localhost:8888/lab** and enter the password you chose.

To change the password, remove the container and start it again with a new value. Your files are kept:

```shell
docker stop aemfm && docker rm aemfm
```

> [!CAUTION]
> **Forgot to set `JUPYTER_TOKEN`?** Jupyter generates a random token, and you cannot log in with `AEMFM`.
> Find the generated token in the startup logs:
> ```shell
> docker logs aemfm
> ```

### Using MATLAB

The `matlab/` folder contains the MATLAB version of the tutorial material, for students who prefer MATLAB to Python.

> [!WARNING]
> **MATLAB is not included in the Docker image.** The container is a Python-only environment. To use the `matlab/` folder, open it with your own MATLAB installation (for example, the licence provided by your institution). The files in `data/` work with both versions.

## Getting help

- **Problems with this repository or the environment:** open an issue on the [Issues page](https://github.com/baristelmen/M2-IPP-AEMFM/issues). Include the steps to reproduce, the error message, and your OS and Docker version (`docker --version`).
- **Course content:** see the [course page](https://perso.ensta.fr/~monchaux/index.html) or contact the lecturer, Romain Monchaux (ENSTA Paris).
- **Signal processing in Python:** see the [`scipy.signal`](https://docs.scipy.org/doc/scipy/reference/signal.html) and [`scipy.io.wavfile`](https://docs.scipy.org/doc/scipy/reference/io.html) documentation.
- **Docker:** see the [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose) documentation.

## Contributing

Contributions are welcome! If you find an issue or have an improvement to suggest, feel free to open an issue or submit a pull request.

## License

The content of this repository (course material, configuration files, and documentation) is open source under the [GNU General Public License v3.0](LICENSE). Anyone is free to use, modify, and share it; modified versions must be shared under the same license.

The container image bundles third-party software that remains under its own license:

| Software | License |
| --- | --- |
| [Docker](https://www.docker.com/) | Apache-2.0 (Docker Engine); Docker Desktop has its own [subscription terms](https://www.docker.com/legal/docker-subscription-service-agreement/) |

MATLAB is proprietary software from MathWorks. It is not distributed with this repository or the Docker image.

Using this environment means accepting the licenses of these components.