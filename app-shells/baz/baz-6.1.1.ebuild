# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1

DESCRIPTION="A lightweight plugin manager for GNU bash"
HOMEPAGE="https://ari-web.xyz/gh/baz"
SRC_URI="https://ari-web.xyz/gh/baz/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
sys-apps/coreutils
dev-vcs/git
app-shells/bash
readline? ( app-misc/rlwrap )
bash-completion? ( app-shells/bash-completion )
"

RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="readline +bash-completion doc logging ok"

DOCS=(README.md PLUGINS.md doc/BAZ_ENV.md doc/PLUGIN_FOLDER_STRUCTURE.md doc/SANITIZATION.md doc/CONFIGURATION_FILES.md doc/LOADER.md)

src_compile() {
    logging_export='# USE="-logging"'
    ok_export='# USE="-ok"'

    use logging && logging_export='export BAZ_LOGGING_ENABLED=true'
    use ok && ok_export='export BAZ_ENSURE_OK=true'

    tee baz-setup <<EOF
#!/usr/bin/env sh

set -e

log() { echo "[GENTOO] \$1"; }

main() {
    log 'Setting up baz'
    $logging_export
    $ok_export

    log 'Entering /tmp'
    cd /tmp

    log 'Getting loader template'
    cp /usr/share/baz/loader.sht .

    log 'Installing/setting up baz'
    baz setup

    log 'Removing template'
    rm -f -- loader.sht
    log 'Done!'
}

main
EOF
}

src_install() {
    insinto /usr/share/baz
    doins loader.sht

    dobin baz-setup
    dobin baz

    use bash-completion && newbashcomp completions/baz.bash ${PN}
    use doc && einstalldocs
}

pkg_postinst() {
    ewarn 'After installation do this to set up baz completely:'
    ewarn '    $ baz-setup'
}

pkg_postrm() {
    ewarn 'To fully uninstall baz run:'
    ewarn '    $ rm -rf ~/.local/share/baz'
}