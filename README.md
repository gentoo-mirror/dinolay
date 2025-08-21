# dinolay

## Deprecated ebuilds overlay

<https://git.ari.lt/ari/deaddino>

## Installation

### Manual

```bash
$ sudo mkdir -p /etc/portage/repos.conf
$ sudo curl -fl 'https://git.ari.lt/ari/dinolay/raw/branch/main/dinolay.conf' -o /etc/portage/repos.conf/dinolay.conf
$ sudo emerge --sync dinolay
```

### Eselect repository

```bash
$ sudo eselect repository add 'dinolay' 'git' 'https://git.ari.lt/ari/dinolay.git'
$ sudo eselect repository enable dinolay
$ sudo emerge --sync dinolay
```

### Layman

```bash
$ sudo layman -a dinolay
$ sudo layman -s dinolay
```
