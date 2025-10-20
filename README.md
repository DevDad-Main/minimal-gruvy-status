<p align="center" style="color:grey">

![image](https://github.com/niksingh710/minimal-tmux-status/assets/60490474/f689e7c8-f081-421e-a7f4-3108f9a870eb)

<div align="center">

<table>
<tbody>
<td align="center">
<img width="2000" height="0"><br>

This is a theme/plugin for my Tmux Status bar.<br>
This is inspired from the zellij prefix indicator, that shows when the prefix key is pressed.<br>

[![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
![Bash](https://img.shields.io/badge/language-Bash-4EAA25.svg)
![Tmux](https://img.shields.io/badge/Tmux-3BBECC.svg)
![Stars](https://img.shields.io/github/stars/niksingh710/minimal-tmux-status.svg)
![Contributors](https://img.shields.io/github/contributors/niksingh710/minimal-tmux-status.svg)

<img width="2000" height="0">
</td>
</tbody>
</table>

> This theme was created with a focus on minimalism and essential elements, ensuring a clean and distraction-free Tmux status bar. Whether you're an experienced Tmux user or just getting started, this theme offers a seamless experience with support for the `prefix key press`.

Based on [minimal-tmux-status](https://github.com/niksingh710/minimal-tmux-status)
<img width="1904" height="1064" alt="tmux" src="https://github.com/user-attachments/assets/1c2ef17d-1f62-4942-a276-c966e94b66d2" />

</div>
</p>

### Installation

#### Via Tmux Plugin Manager (TPM)

I recommend using [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm) for easy installation:

1. Add the theme to your list of TPM plugins in your `~/.tmux.conf`:

   ```bash
   set -g @plugin 'niksingh710/minimal-tmux-status'
   ```

2. Press `prefix` + <kbd>I</kbd> (capital "i", as in Install) to fetch and install the plugin.

3. Reload your Tmux configuration:

   ```bash
   tmux source-file ~/.tmux.conf
   ```

That's it! Your Tmux Status Theme is now installed and ready to use.

### Tip

#### Toggle Status Bar

Add this line in your tmux config so that you can easily toggle tmux status bar with one keymap.

```
bind-key b set-option status
```

Now pressing `prefix+b` will toggle status bar

<details>

<summary style="font-weight: bold; font-size: 21px;"> Automatic tpm installation </summary>

One of the first things we do on a new machine is cloning our dotfiles. Not everything comes with them though, so for example `tpm` most likely won't be installed.

If you want to install `tpm` and plugins automatically when tmux is started, put the following snippet in `.tmux.conf` before the final `run '~/.tmux/plugins/tpm/tpm'`:

```
if "test ! -d ~/.tmux/plugins/tpm" \
   "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"
```

</details>
