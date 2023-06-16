# Quboid Desktop

## Bareback

Quboid Bareback is a bare repo I use to backup my dotfiles. Seems simpler than something like GNU Stow.

```bash
git clone --bare https://github.com/AndOrangutan/quboid-dotfiles $HOME/.quboid-bareback
```

## Core Tools

### Awesome Window Manager

#### Redesign Planning

##### UI

###### Bar

```
[ ( (Layout) (taglist) (tasklist) ) ( Clock / Calendar ) ( (<SysTray) (Updates) (sysperf) (?Battery) (Sound) (Hamberger) )]

```

- Layout
    - left-click - Launcher
    - right-click - awful.widget.layoutlist
    - middle-click - Cycle layout
- awful.widget.taglist
- Hamberger
    - Notificaiton List
    - Power Sign out restart buttons
    - Setting Menu
        - Defaults menu defined thorugh API.

###### Notifications

- Music [Bling](https://blingcorp.github.io/bling/#/signals/pctl?id=usage)

###### Keybindings


- `<Window>`
    - `<Tab>` - [Bling Window Switcher](https://blingcorp.github.io/bling/#/widgets/window_switcher)
    
#### Resources

- [raven2cz's setup](https://www.reddit.com/r/unixporn/comments/s74wdg/awesomewm_multicolor_theme_15_best_color_schemes/)
- [glorious setup](https://github.com/manilarome/the-glorious-dotfiles)
- [Blink](https://blingcorp.github.io/bling/)
- [Rubato Animation](https://github.com/andOrlando/rubato)
- [Tutorial](https://epsi-rns.github.io/desktop/2019/06/15/awesome-overview.html)
