📌 Disconnected Staff Clockin

A lightweight FiveM staff clock-in system built with ox_lib menus, developed by Disconnected.

✨ Features

🕒 Simple staff duty clock-in / clock-out system

📋 Clean ox_lib menu interface

🔒 Permission-based access for staff members

⚡ Optimized for performance (low ms usage)

🎨 Easily configurable for your server’s needs

Hard dependencies (must have)

ox_lib → because you’re using lib.inputDialog for the clock-in menu. (https://github.com/overextended/ox_lib/releases/tag/v3.30.6)
okokNotify → because you’re using okokNotify:Alert for notifications. (can change)

📥 Installation

Download the latest release or clone this repository.

You may change the Notify to a diffrent one ( right now its okoknotify )

Place the resource into your resources folder.

Add the following line to your server.cfg:

"ensure disconnected-clockin"

🎮 Usage

Open the Staff Clockin Menu with the defined keybind or command.

Select Clock In to go on duty, or Clock Out to leave duty.

https://discord.gg/5MGKBwU9jG - dev server for custom scripts

# Ace Perms
must use discord badger ace permissions to work this.
example
add_ace group.staff dd_staff-duty allow - able to clockon as staff

add_ace group.dhs dd_staff-duty allow - able to clockon as dhs while staff.

📜 License

This project is licensed under the MIT License — you’re free to use, modify, and distribute it with attribution.

Developed and maintained by DisconnectedDev (dd).
