# dotfiles

My skript for automating the installation and configuration of a linux system after a fresh install.

## Installation

```shell
sh -c "`wget -O - --no-check-certificate https://raw.githubusercontent.com/ndz-v/dotfiles/master/remote-setup.sh`"

```

### Explanation

The script above downloads the master branch of this repo and starts setup.sh execution.

### Create bootable usb

```bash
sudo dd bs=4M if=path/to/input.iso of=/dev/sd<?> conv=fdatasync  status=progress
```

### Connect Wifi with nmcli

```bash
nmcli device wifi connect <AP name> password <password>
```

### Connect Wifi with nmcli

```bash
sudo nmcli device connect wlp9s0
```

## Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
