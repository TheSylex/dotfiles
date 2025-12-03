set fish_greeting # Disable greeting

# --abbreviatons--
abbr -a l eza --icons=auto
abbr -a ls eza --icons=auto
abbr -a ll eza --grid -lhag --icons=auto --git --git-repos

abbr -a t btop 2> /dev/null
abbr -a cat bat
abbr -a lg lazygit
abbr -a e exit
abbr -a o open
# Expose SSH through pinggy (60 min timeout)
abbr -a ssh-share ssh -p 443 -R0:localhost:22 tcp@eu.a.pinggy.io
# Literally terminal streaming that works on browsers support for input/readonly
abbr -a tty-share tty-share --public --listen 127.0.0.1:42069 --readonly

# Makes "!" be substituted by last command
function last_history_item
    echo $history[1]
end
abbr -a ! --position anywhere --function last_history_item

# --aliases--
function screensaver
    # ternimal width=$COLUMNS height=(math $LINES x 2 - 2) length=1000 thickness=3,12,3,0,0 radius=18,36 gradient=0:#a6e3a1,0.5:#94e2d5,1:#74c7ec
    ternimal width=$COLUMNS height=(math $LINES x 2 - 2) length=300 gradient=0:#a6e3a1,0.5:#94e2d5,1:#74c7ec
end

# Source programs into fish
direnv hook fish | source
starship init fish | source && enable_transience
tv init fish | source # tv before atuin and zoxide in order to not override them
atuin init fish | source
zoxide init fish | source

# yazi config
function yazi_with_cd
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
function y
    if test -n "$argv[1]"
        if test -d "$argv[1]"
            yazi_with_cd "$argv[1]"
        else
            yazi_with_cd (zoxide query "$argv[1]")
        end
    else
        yazi_with_cd
    end
end

# hardcoded catppuccin frappe theme
set -gx fish_color_normal c6d0f5
set -gx fish_color_command 8caaee
set -gx fish_color_param eebebe
set -gx fish_color_keyword e78284
set -gx fish_color_quote a6d189
set -gx fish_color_redirection f4b8e4
set -gx fish_color_end ef9f76
set -gx fish_color_comment 838ba7
set -gx fish_color_error e78284
set -gx fish_color_gray 737994
set -gx fish_color_selection --background=414559
set -gx fish_color_search_match --background=414559
set -gx fish_color_option a6d189
set -gx fish_color_operator f4b8e4
set -gx fish_color_escape ea999c
set -gx fish_color_autosuggestion 737994
set -gx fish_color_cancel e78284
set -gx fish_color_cwd e5c890
set -gx fish_color_user 81c8be
set -gx fish_color_host 8caaee
set -gx fish_color_host_remote a6d189
set -gx fish_color_status e78284
set -gx fish_pager_color_progress 737994
set -gx fish_pager_color_prefix f4b8e4
set -gx fish_pager_color_completion c6d0f5
set -gx fish_pager_color_description 737994
