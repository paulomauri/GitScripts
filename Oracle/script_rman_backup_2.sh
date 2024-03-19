#!/bin/bash
#
# Este script foi utilizado para ser chmado pelo crontab
# o crontab em sua execução do script, leva o minimo de variaveis de ambiente para execução.
# por isso adicionado as variaveis abaixo.
#
rman target / <<EOF
delete noprompt obsolete;
backup database;
EOF
exit 0

