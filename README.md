# README

Rails app to remotely view items in AE2 system.  

It uses CC:Tweaked mod to read data from AE2 and then do a POST to send the data to this API host. Also renders a very simple web frontend to view that data.  

### Mods Needed

CC: Tweaked <a href="https://modrinth.com/mod/cc-tweaked"><img src="https://cdn.modrinth.com/data/gu7yAYhd/icon.png" width="50" height="50"></a>  
Advanced Peripherals <a href="https://modrinth.com/mod/advancedperipherals"><img src="https://cdn.modrinth.com/data/SOw6jD6x/bc21f475feb7bb47c6c969948ec7a0310e554d8f_96.webp" width="50" height="50"></a>  

### LUA
In the Lua folder are two scripts. Drop them both into `saves/<YourWorld>/computer/<ID>`

The startup.lua script must stay named as startup because it tells CC to run it at bootup of the computer terminal. That script then runs the ae2_storage script every 60 seconds. Make sure to change the URL in ae2_storage.lua to whatever your host URL is.

If running the Rails server on the same host, i.e. localhost, you'll need to modify the `saves/<YourWorld>/serverconfig/computercraft-server.toml` file and remove the `[[http.rules]]` section: https://tweaked.cc/guide/local_ips.html