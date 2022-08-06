# this is my Neovim setup

the idea here is to structure all the plugins in an easily maintainable way

to add a new plugin, simply create a folder in `nvim/lua/plugins/` directory
and add an `init.lua` file that houses your setup for said plugin and it will
be loaded automatically.

```
nvim
├── init.lua                            # this is the entry point
└── lua
    ├── core
    │   ├── autocmds
    │   │   └── init.lua                # place your autocommands here
    │   ├── globals
    │   │   └── init.lua                # place config global variables here
    │   ├── keymaps
    │   │   └── init.lua                # place your general keymappings here
    │   ├── settings
    │   │   └── init.lua                # place your settings here
    │   └── init.lua                    # this is where all core modules are loaded
    ├── plug
    │   └── init.lua                    # this is where all plugins are loaded
    └── plugins
        └── nvim_tree                   # define plugins like this
            └── init.lua                # place all plugins configs in an init.lua file
```
