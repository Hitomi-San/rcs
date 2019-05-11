# Created by newuser for 5.7.1

export PATH="/usr/local/sbin:$PATH"

###########################################################
## https://qiita.com/eumesy/items/3bb39fc783c8d4863c5f
# in ~/.zshenv, executed `unsetopt GLOBAL_RCS` and ignored /etc/zshrc
[ -r /etc/zshrc ] && . /etc/zshrc

###########################################################
## https://qiita.com/b4b4r07/items/8db0257d2e6f6b19ecb9
## https://github.com/b4b4r07/zle-vimode/blob/master/zle-vimode.zsh
# vim キーバインド
bindkey -v

# Make more vim-like behaviors
bindkey -M vicmd 'gg' beginning-of-line
bindkey -M vicmd 'G'  end-of-line

# User-defined widgets
peco-select-history()
{
	# Check if peco is installed
	if type "peco" >/dev/null 2>&1; then
		# BUFFER is editing buffer contents string
		BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
		# CURSOR is your key cursor position integer
		CURSOR=${#BUFFER}

		# just run
		zle accept-line
		# clear displat
		zle clear-screen
	else
		if is-at-least 4.3.9; then
			# Check if history-incremental-pattern-search-forward is available
			has_widgets "history-incremental-pattern-search-backward" && bindkey "^r" history-incremental-pattern-search-backward
		else
			history-incremental-search-backward
		fi
	fi
}
# Regist shell function as widget
zle -N peco-select-history
# Assign keybind
bindkey '^r' peco-select-history

############################################################
## http://www.sirochro.com/note/terminal-zsh-prompt-customize/
# VCSの情報を取得するzsh関数
autoload -Uz vcs_info
autoload -Uz colors 
colors

# 曜日判定
whichday () {
	daynum=$(date +%u);
	case $daynum in
		0) day='Sun';;
		1) day='Mon';;
		2) day='Tue';;
		3) day='Wed';;
		4) day='Thr';;
		5) day='Fri';;
		6) day='Sat';;
	esac
	echo $day
}

# PROMPT変数内で変数参照
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true      #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}🅒"    #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{red}🅐"  #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f"    #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]'         #rebase 途中,merge コンフリクト等 formats 外の表示

# %b ブランチ情報
# %a アクション名(mergeなど)
# %c changes
# %u uncommit

# プロンプト表示直前に vcs_info 呼び出し
precmd () { vcs_info }

# プロンプト
function zle-keymap-select zle-line-init zle-line-finish
{
	case $KEYMAP in
		main|viins)
			PRE_PROMPT="$fg[blue]🅸$reset_color";;
		vicmd)
			PRE_PROMPT="$fg[white]🅽$reset_color";;
		vivis|vivli)
			PRE_PROMPT="$fg[red]🆅$reset_color";;
	esac
	
	PROMPT_A=$PRE_PROMPT'%{$fg[cyan]%}20%D $(whichday) %*%{$reset_color%} '
	PROMPT_B=$PROMPT_A'%{$fg[blue]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:%~'
	PROMPT_C=$PROMPT_B'${vcs_info_msg_0_}'$'\n''%{$fg[magenta]%}%#%{$reset_color%} '
	PROMPT=$PROMPT_C
	
	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line


############################################################
## https://original-game.com/terminal-zsh2/
# タブ補完
autoload -Uz compinit
compinit
 
zstyle ':completion:*' menu select

############################################################
## https://original-game.com/terminal-zsh2/
# オートコレクト
setopt correct

# 大文字小文字を補完で無視
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

############################################################
# history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt share_history
setopt hist_ignore_dups

############################################################
# alias
alias ls='ls --color -F'

