#!/bin/sh
# /etc/runit/core-services/00-voidbr-plymouth-msg.sh
#
# Os core-services são carregados com '.' no mesmo shell do /etc/runit/1,
# então redefinir msg() aqui vale para todos os scripts seguintes do stage 1.
# Cada mensagem continua indo pro console e também vai pra linha de status do splash.

command -v plymouth >/dev/null 2>&1 || return 0
plymouth --ping 2>/dev/null || return 0

_voidbr_plymouth_text() {
	case "$1" in
	"Mounting pseudo-filesystems"*) echo "Montando pseudo-sistemas de arquivos..." ;;
	"Loading kernel modules"*) echo "Carregando módulos do kernel..." ;;
	"Starting udev"*) echo "Detectando dispositivos..." ;;
	"Setting up TTYs font"*) echo "Configurando fonte do console..." ;;
	"Setting up keymap"*) echo "Configurando teclado..." ;;
	"Setting up RTC"*) echo "Ajustando relógio..." ;;
	"Activating encrypted devices"*) echo "Ativando discos criptografados..." ;;
	"Activating LVM"*) echo "Ativando volumes LVM..." ;;
	"Activating btrfs"*) echo "Ativando dispositivos btrfs..." ;;
	"Activating software RAID"*|"Activating dmraid"*) echo "Ativando RAID..." ;;
	"Checking filesystems"*) echo "Verificando sistemas de arquivos..." ;;
	"Mounting rootfs read-write"*) echo "Montando a raiz para leitura e escrita..." ;;
	"Mounting all non-network"*) echo "Montando sistemas de arquivos..." ;;
	*ZFS*) echo "Preparando ZFS..." ;;
	"Initializing swap"*) echo "Ativando swap..." ;;
	"Seeding random"*) echo "Inicializando gerador aleatório..." ;;
	"Setting up loopback"*) echo "Configurando rede local..." ;;
	"Setting up hostname"*) echo "Definindo nome da máquina..." ;;
	"Setting up timezone"*) echo "Definindo fuso horário..." ;;
	"Loading sysctl"*) echo "Aplicando configurações do kernel..." ;;
	*) echo "$1" ;;
	esac
}

# mesmo formato do msg() original do /etc/runit/functions
msg() {
	printf "\033[1m=> $@\033[m\n"
	plymouth display-message --text="$(_voidbr_plymouth_text "$*")" 2>/dev/null
}
