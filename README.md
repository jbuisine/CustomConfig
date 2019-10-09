# Custom config

## Vim Config

Custom personal .vimrc configuration

### Requirements

Need to install Nerd Fonts : https://github.com/ryanoasis/nerd-fonts

### Overview 

![overview](vim_config.png)

## Screens configuration

Bash script `screens_config/xrandr_automation.sh` which enables to configure non-HiDPI monitors.

Add this command to your `~/.profile` using your specific path access to script:

```
(sleep 1 && bash ~/config/screens_config/xrandr_automation.sh) &
```

## Licence

[MIT](LICENSE)


