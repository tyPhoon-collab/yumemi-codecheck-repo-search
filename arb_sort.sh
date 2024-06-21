# !/bin/sh

print_green() {
    tput setaf 2
    echo "$1"
    tput sgr0
}

dart pub global activate arb_utils

arb_utils sort lib/l10n/intl_en.arb -n
arb_utils sort lib/l10n/intl_ja.arb -n

print_green "Sort done"

dart pub global run intl_utils:generate

print_green "Regenerate done"