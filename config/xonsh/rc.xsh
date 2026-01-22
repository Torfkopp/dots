def _y(args):
    tmp = $(mktemp -t "yazi-cwd.XXXXXX")
    args.append(f"--cwd-file={tmp}")
    $[yazi @(args)]
    with open(tmp) as f:
        cwd = f.read()
    if cwd != $PWD:
        cd @(cwd)
    rm -f -- @(tmp)

aliases["y"] = _y

xontrib load vox autovox
xontrib load fish_completer
xontrib load sh
xontrib load pipeliner
xontrib load gitinfo
xontrib load jedi

$XONTRIB_PROMPT_STARSHIP_RIGHT_CONFIG = '~/.config/starship/nerd-font-symbols.toml'
xontrib load prompt_starship

$MICRO_TRUECOLOR = 1


import os

try:
    if os.get_terminal_size().lines >= 50:
        fastfetch
except OSError:
    pass
