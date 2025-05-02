set fish_greeting # Disable greeting

# abbreviatons
abbr -a ls eza
abbr -a cat bat
abbr -a lg lazygit
abbr -a e exit
abbr -a o open

# enable starship
starship init fish | source
enable_transience

# enable direnv
direnv hook fish | source

# zoxide config
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
