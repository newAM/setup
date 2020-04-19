#!/usr/bin/env python3.8

import subprocess
import urllib.request
import tempfile
import os
import functools
from typing import Optional


def run(*args: str, cwd: Optional[str] = None) -> subprocess.CompletedProcess:
    proc = subprocess.run(
        [*args], check=True, encoding="utf-8", errors="backslashreplace", cwd=cwd
    )
    return proc


def apt_install(*pkgs: str):
    run("sudo", "apt", "install", "-y", *pkgs)


def get_codename() -> str:
    return run("lsb_release", "--codename", "--short").stdout


def get_home() -> str:
    return os.path.expanduser("~")


join_home = functools.partial(os.path.join, get_home())


def install_cmake():
    try:
        run("cmake", "--version")
    except subprocess.CalledProcessError:
        pass
    else:
        return

    apt_install(
        "apt-transport-https",
        "ca-certificates",
        "gnupg",
        "software-properties-common",
        "wget",
    )
    key = urllib.request.urlopen(
        "https://apt.kitware.com/keys/kitware-archive-latest.asc"
    ).read()
    with tempfile.NamedTemporaryFile("wb") as f:
        f.write(key)
        run("sudo", "apt-key", "add", f.name)
    run(
        "sudo",
        "apt-add-repository",
        "-y",
        f"'deb https://apt.kitware.com/ubuntu/ {get_codename()} main'",
    )
    apt_install("cmake")


def install_vim():
    install_cmake()
    apt_install(
        "curl",
        "vim",
        "wget",
        "git",
        "python3-dev",
        "build-essential",
        "python3-venv",
        "python3-pip",
    )
    run(
        "python3",
        "-m",
        "pip",
        "install",
        "black",
        "flake8",
        "flake8-bugbear",
        "pep8-naming",
    )
    autoload_dir = join_home(".vim", "autoload")
    os.makedirs(autoload_dir, exist_ok=True)
    plug = urllib.request.urlopen(
        "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    ).read()
    with open(os.path.join(autoload_dir, "plug.vim"), "wb") as f:
        f.write(plug)
    vimrc = urllib.request.urlopen(
        "https://raw.githubusercontent.com/newAM/dotfiles/master/.vimrc"
    ).read()
    with open(join_home(".vimrc"), "wb") as f:
        f.write(vimrc)

    run("vim", "--not-a-term", "+PlugInstall", "+qall")
    run(
        "python3",
        "install.py",
        "--rust-completer",
        cwd=join_home(".vim", "plugged", "YouCompleteMe"),
    )


def install_powerline():
    with tempfile.TemporaryDirectory() as d:
        run("git", "clone", "--depth=1", "https://github.com/powerline/fonts.git", d)
        run("./install.sh", cwd=d)


def install_desktop_apt_packages():
    run("sudo", "add-apt-repository", "-y", "ppa:mmstick76/alacritty")
    apt_install("alacritty")


if __name__ == "__main__":
    import argparse

    installers = []
    installer_prefix = "install_"
    local_names = list(locals().keys())
    for local in local_names:
        if local.startswith(installer_prefix):
            installers.append(local[len(installer_prefix) :])

    parser = argparse.ArgumentParser(
        description="Autoinstaller for things I use frequently."
    )
    parser.add_argument(
        "installer", nargs="+", choices=installers, help="installer to run"
    )
    args = parser.parse_args()

    for installer in args.installer:
        func = locals()[f"install_{installer}"]
        func()
