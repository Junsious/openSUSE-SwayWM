1. Alacritty (терминал с полупрозрачностью)
Создайте файл ```~/.config/alacritty/alacritty.yml``` и добавьте туда следующие настройки:

```
# alacritty.yml
window:
  opacity: 0.9   # Полупрозрачность

colors:
  primary:
    background: '#1d1f21'
    foreground: '#c5c8c6'

font:
  size: 12.0
```
Запустите neofetch в alacritty для вывода системной информации в терминале.

2. Conky (системные виджеты)
Создайте файл конфигурации ```~/.config/conky/conky.conf``` с параметрами для виджетов на правой панели:

```
conky.config = {
    alignment = 'top_right',
    background = true,
    double_buffer = true,
    update_interval = 1,
    font = 'sans:size=10',
    use_xft = true,
    own_window = true,
    own_window_type = 'dock',
    own_window_transparent = true,
    own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
    default_color = 'white',
}

conky.text = [[
${font sans:size=12}System Status${font}
CPU: ${cpu}%  ${cpubar 4}
RAM: ${mem} / ${memmax}  ${membar 4}
Disk: ${fs_used /} / ${fs_size /}  ${fs_bar 4 /}

${font sans:size=12}Network${font}
Download: ${downspeed wlp2s0} KiB/s
Upload: ${upspeed wlp2s0} KiB/s
]]
```
Замените wlp2s0 на название вашего сетевого интерфейса (можно узнать с помощью команды ip a).

3. Waybar (панель задач сверху)
Создайте папку и файл ```~/.config/waybar/config``` и добавьте туда следующее:

```
{
  "layer": "top",
  "modules-left": ["sway/workspaces", "sway/mode"],
  "modules-center": ["clock"],
  "modules-right": ["cpu", "memory", "network", "battery", "tray"],
  "clock": {
    "format": "{:%a, %b %d, %H:%M}"
  },
  "battery": {
    "format": "{percentage}% {icon}"
  },
  "network": {
    "format": "{ifname} {ipaddr}/{cidr}"
  }
}
Создайте файл стилей ~/.config/waybar/style.css:

css
Копировать код
* {
  font-family: "sans-serif";
  font-size: 12px;
  background-color: rgba(29, 31, 33, 0.9);
  color: #c5c8c6;
}

#clock, #battery, #network {
  padding: 0 10px;
}

#tray > * {
  margin: 0 4px;
}
```
4. Rofi (меню запуска)
Создайте конфигурацию для rofi, чтобы создать меню запуска. Файл ~/.config/rofi/config.rasi:

```
configuration {
    modi: "drun,run";
    show-icons: true;
    theme: "gruvbox-dark";
}

* {
    background: #1d1f21;
    foreground: #c5c8c6;
    selected-background: #c5c8c6;
    selected-foreground: #1d1f21;
    font: "sans 12";
}
```
Для запуска rofi, установите комбинацию клавиш в конфиге Sway (~/.config/sway/config):

```
bindsym $mod+d exec rofi -show drun
```
5. Список сочетаний клавиш (второй экземпляр conky)
Вы можете создать ещё один conky.conf для отображения списка сочетаний клавиш, например, слева. Создайте ~/.config/conky/conky_keybindings.conf:

```
conky.config = {
    alignment = 'top_left',
    background = true,
    double_buffer = true,
    update_interval = 1,
    font = 'sans:size=10',
    use_xft = true,
    own_window = true,
    own_window_type = 'dock',
    own_window_transparent = true,
    own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
    default_color = 'lightblue',
}

conky.text = [[
${font sans:size=12}Keybindings${font}
Applications:
  Terminal       [Super + Return]
  Browser        [Super + w]
  File Manager   [Super + e]

System Tools:
  Volume Up      [Super + Up]
  Volume Down    [Super + Down]
]]
```
Запустите оба экземпляра conky:

```
conky -c ~/.config/conky/conky.conf &
conky -c ~/.config/conky/conky_keybindings.conf &
```
Автозапуск всех компонентов — добавьте все команды автозапуска (conky, waybar, swaybg и т.д.) в конфиг Sway, чтобы они запускались автоматически при старте.
```
exec_always --no-startup-id swaybg -i /path/to/your/wallpaper.jpg -m fill
exec_always --no-startup-id conky -c ~/.config/conky/conky.conf
exec_always --no-startup-id conky -c ~/.config/conky/conky_keybindings.conf
exec_always --no-startup-id waybar
```
