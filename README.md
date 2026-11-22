# CDE Gentoo overlay

This repository contains ebuilds for the [Common Desktop Environment
(CDE)](https://github.com/cdesktopenv/cde).

## Adding the overlay

Install Git if necessary:

```sh
emerge --ask dev-vcs/git
```

Create `/etc/portage/repos.conf/cde-overlay.conf` with:

```ini
[cde-overlay]
location = /var/db/repos/cde-overlay
sync-type = git
sync-uri = https://github.com/mcclung/cde-overlay.git
auto-sync = yes
priority = 50
```

The repository is public, so no GitHub credentials are required.

Sync the repository:

```sh
emaint sync -r cde-overlay
```

The ebuild is currently keyworded unstable for amd64, so accept it explicitly:

```sh
mkdir -p /etc/portage/package.accept_keywords
printf '%s\n' 'x11-wm/cde ~amd64' \
	> /etc/portage/package.accept_keywords/cde-overlay
```

Install CDE:

```sh
emerge --ask x11-wm/cde
```

The `docs` USE flag is enabled by default. To omit the CDE help and
`dtinfo` documentation, add this to `/etc/portage/package.use/cde-overlay`:

```text
x11-wm/cde -docs
```

The package installs programs and libraries below `/usr`, CDE data below
`/usr/share/cde`, configuration below `/etc/dt`, and runtime state below
`/var/dt`; it does not use the historical `/usr/dt` prefix.
