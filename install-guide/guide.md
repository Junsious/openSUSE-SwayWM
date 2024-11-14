Шаг 1: Установка Sway и необходимых приложений
Обновите систему и установите Sway:

```
sudo zypper refresh
sudo zypper install sway
```
Установите основные утилиты, которые вам понадобятся:

```
sudo zypper install waybar rofi alacritty nm-applet brightnessctl pactl swaybg conky
```
waybar — панель задач для Sway.
rofi — лаунчер приложений.
alacritty — терминал (можете заменить на другой, например, foot или konsole).
nm-applet — апплет для управления сетями (NetworkManager).
brightnessctl — утилита для управления яркостью экрана.
pactl — утилита для управления звуком через PulseAudio.
swaybg — утилита для установки фонового изображения.
conky — системный монитор, который можно настроить для отображения системных виджетов.
Шаг 2: Настройка Sway
Создайте директорию для конфигурации Sway (если она не создана):

```
mkdir -p ~/.config/sway
```
Создайте или отредактируйте файл ~/.config/sway/config, используя конфиг, который мы подготовили ранее:

```
nano ~/.config/sway/config
Скопируйте и вставьте следующий конфиг:
```
```
# Указываем, что модификатор (Mod) — это клавиша Super (обычно Win)
set $mod Mod4

# Основные привязки клавиш
bindsym $mod+Return exec alacritty       # Запуск терминала (Alacritty)
bindsym $mod+d exec rofi -show drun      # Запуск меню приложений Rofi
bindsym $mod+Shift+c reload              # Перезагрузка Sway
bindsym $mod+Shift+e exit                # Завершение работы Sway
bindsym $mod+w exec firefox              # Запуск браузера Firefox

# Автозапуск приложений
exec --no-startup-id nm-applet           # Сетевой аплет для управления Wi-Fi (NetworkManager)
exec_always --no-startup-id waybar       # Запуск панели Waybar
exec_always --no-startup-id swaybg -i /path/to/your/wallpaper.jpg -m fill  # Установка фонового изображения

# Фоновый цвет окна (используется на случай, если обои не загрузились)
output * bg #222222 solid_color

# Настройки тачпада (если используется)
input "type:touchpad" {
    tap enabled
    natural_scroll enabled
}

# Навигация между окнами
bindsym $mod+h focus left                # Переключение фокуса на окно слева
bindsym $mod+j focus down                # Переключение фокуса на окно снизу
bindsym $mod+k focus up                  # Переключение фокуса на окно сверху
bindsym $mod+l focus right               # Переключение фокуса на окно справа

# Перемещение окон
bindsym $mod+Shift+h move left           # Перемещение окна влево
bindsym $mod+Shift+j move down           # Перемещение окна вниз
bindsym $mod+Shift+k move up             # Перемещение окна вверх
bindsym $mod+Shift+l move right          # Перемещение окна вправо

# Рабочие области
workspace 1 output eDP-1                 # Рабочая область 1 на встроенном экране (eDP-1)
workspace 2 output HDMI-A-1              # Рабочая область 2 на внешнем мониторе (HDMI-A-1)

# Управление звуком (добавлено для удобства)
bindsym $mod+Up exec pactl set-sink-volume @DEFAULT_SINK@ +5%       # Увеличение громкости
bindsym $mod+Down exec pactl set-sink-volume @DEFAULT_SINK@ -5%     # Уменьшение громкости
bindsym $mod+Shift+m exec pactl set-sink-mute @DEFAULT_SINK@ toggle # Включение/выключение звука

# Управление яркостью (если поддерживается)
bindsym $mod+Shift+Up exec brightnessctl set +10%                   # Увеличение яркости
bindsym $mod+Shift+Down exec brightnessctl set 10%-                 # Уменьшение яркости

# Настройки раскладки клавиатуры
input * {
    xkb_layout "us,ru"                    # Английская и Русская раскладки
    xkb_options "grp:alt_shift_toggle"    # Переключение раскладки по Alt+Shift
}
```

# Отображение системных виджетов через Conky (если используется)
```
exec_always --no-startup-id conky -c ~/.config/conky/conky.conf
exec_always --no-startup-id conky -c ~/.config/conky/conky_keybindings.conf
```
Шаг 3: Настройка Waybar
Создайте директорию для конфигурации Waybar:

```
mkdir -p ~/.config/waybar
Создайте или отредактируйте файл ~/.config/waybar/config и ~/.config/waybar/style.css для настройки панели.
```
Пример минимальной конфигурации config:

```
{
    "layer": "top",
    "position": "top",
    "modules-left": ["network", "pulseaudio", "backlight"],
    "modules-center": ["clock"],
    "modules-right": ["cpu", "memory", "battery", "tray"],
    "clock": {
        "format": "%a %d-%m-%Y %H:%M:%S"
    }
}
```
Пример style.css:

css
```
* {
    font-family: "Noto Sans", sans-serif;
    font-size: 14px;
    color: #ffffff;
}

#clock, #cpu, #memory, #network, #pulseaudio, #backlight, #battery {
    padding: 0 10px;
}

#tray > * {
    margin: 0 5px;
}
```
Шаг 4: Настройка Conky
Создайте директорию для конфигурации Conky и создайте базовый конфиг, например ~/.config/conky/conky.conf.

Пример базового конфига для отображения системной информации:

```
conky.config = {
    alignment = 'top_right',
    gap_x = 10,
    gap_y = 60,
    background = false,
    update_interval = 1.0,
    total_run_times = 0,
    own_window = true,
    own_window_type = 'dock',
    own_window_transparent = true,
    double_buffer = true,
    use_xft = true,
    font = 'Noto Sans:size=10',
    default_color = '#ffffff',
}

conky.text = [[
${time %a, %d %b %Y %H:%M:%S}
CPU: ${cpu cpu0}% ${cpubar cpu0}
RAM: ${mem} / ${memmax} ${membar}
Disk: ${fs_used /} / ${fs_size /}
Battery: ${battery_percent BAT0}%
Network: ${downspeed wlp2s0} / ${upspeed wlp2s0}
]]
```
Шаг 5: Запуск Sway
Теперь вы можете запустить Sway:

```
sway
```
