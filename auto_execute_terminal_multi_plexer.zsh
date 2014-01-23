# http://d.hatena.ne.jp/tyru/20100828/run_tmux_or_screen_at_shell_startup
is_screen_or_tmux_running() {
    # is screen(tscreen) or tmux runnning
    [ ! -z "$WINDOW" ] || [ ! -z "$TMUX" ]
}
shell_has_started_interactively() {
    [ ! -z "$PS1" ]
}
resolve_alias() {
    cmd="$1"
    while \
        whence "$cmd" >/dev/null 2>/dev/null \
        && [ "$(whence "$cmd")" != "$cmd" ]
    do
        cmd=$(whence "$cmd")
    done
    echo "$cmd"
}


if ! is_screen_or_tmux_running && shell_has_started_interactively
then
    for cmd in tmux tscreen screen
    do
        if whence $cmd >/dev/null 2>/dev/null
        then
            $(resolve_alias "$cmd")
            break
        fi
    done
fi
