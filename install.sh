#!/bin/bash

# Проверка прав root
if [[ $EUID -ne 0 ]]; then
   echo "Этот скрипт необходимо запускать с правами root."
   exit 1
fi

# Обновление системы
echo "Обновление системы..."
zypper refresh && zypper update -y

# Установка основных программ
echo "Установка необходимых программ..."
zypper install -y sway waybar alacritty mako wl-clipboard \
    grim slurp brightnessctl wofi network-manager-applet \
    xdg-desktop-portal-wlr xorg-x11-server-Xwayland

# Установка дополнительных утилит (по необходимости)
zypper install -y \
    pipewire pipewire-pulse pipewire-alsa \
    polkit polkit-gnome pavucontrol

# Создание конфигурационных директорий
echo "Настройка конфигураций..."
mkdir -p ~/.config/sway
mkdir -p ~/.config/waybar
mkdir -p ~/.config/mako
mkdir -p ~/.config/wofi

# Копирование конфигурационных файлов
echo "Копирование конфигурационных файлов..."
REPO_PATH="/path/to/your/repository"
cp -r "$REPO_PATH/config/sway" ~/.config/
cp -r "$REPO_PATH/config/waybar" ~/.config/
cp -r "$REPO_PATH/config/mako" ~/.config/
cp -r "$REPO_PATH/config/wofi" ~/.config/

# Установка автозапуска для Sway
echo "Добавление Sway в автозагрузку..."
echo "exec sway" > ~/.xinitrc

# Завершение
echo "Установка завершена! Перезагрузите систему и войдите в Sway."
