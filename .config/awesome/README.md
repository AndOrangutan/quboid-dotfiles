# Quboid Awesome

## Testing

```bash
aawmtt --config "~/dev/quboid-dotfiles/.config/awesome/rc.lua" --watch "~/dev/quboid-dotfiles/.config/awesome/rc.lua"
```
## Thanks Awesome AwesomeWm RC

- [suconakh/awesome-awesome-rc](https://github.com/suconakh/awesome-awesome-rc)

### Structure

> The main `rc.lua` file only load the modules it was split into.
> Each module can have its own submodules, and they are all loaded from `init.lua`.
> 
> module | description
> -------- | -----------
> `bindings` | mouse and key bindings
> `config` | various variables for apps/tags etc...
> `modules` | third-party libraries (e.g. [bling](https://github.com/BlingCorp/bling), [lain](https://github.com/lcpz/lain))
> `rules` | client rules
> `signals` | all signals are connected here
> `widgets` | all widgets are defined here
> 
> The `widgets` module is now better organized in the 
> [`widgets`](https://github.com/suconakh/awesome-awesome-rc/tree/widgets) branch.
> The reason for moving it to a different branch is that it is now 
> a bit different from the default `rc.lua` logic, so I decided to 
> move it to a different branch so as not to create confusion.

We have the widget branch

## Redesign Planning

### UI

#### Bar

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

#### Notifications

- Music [Bling](https://blingcorp.github.io/bling/#/signals/pctl?id=usage)

#### Keybindings


- `<Window>`
    - `<Tab>` - [Bling Window Switcher](https://blingcorp.github.io/bling/#/widgets/window_switcher)

## Resources

- [raven2cz's setup](https://www.reddit.com/r/unixporn/comments/s74wdg/awesomewm_multicolor_theme_15_best_color_schemes/)
- [glorious setup](https://github.com/manilarome/the-glorious-dotfiles)
- [Blink](https://blingcorp.github.io/bling/)
- [Rubato Animation](https://github.com/andOrlando/rubato)
- [Tutorial](https://epsi-rns.github.io/desktop/2019/06/15/awesome-overview.html)

