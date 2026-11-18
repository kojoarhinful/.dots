## tmux

Prefix: `Ctrl-b`.

### Sessions

```bash
mann          # random free city name (alias for regcap)
mann bragg     # create/attach a session named "bragg"

tmux ls
tmux attach -t <session>
tmux kill-session -t <session>
tmux kill-server
```

### Windows

| Key | Action |
|-----|--------|
| `Ctrl-b c` | new window |
| `Ctrl-b w` | list windows |
| `Ctrl-b ,` | rename window |
| `Ctrl-b &` | close window |
| `Ctrl-b d` | detach |
| `Ctrl-h` / `Ctrl-l` | previous / next window |

### Reload

```bash
tmux source-file ~/.tmux.conf
```
