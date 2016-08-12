#unbind-key -n C-a
#set -g prefix ^A
#set -g prefix2 ^A


# mouse works as expected     
bind m \
	set -g mode-mouse on \;\
	set -g mouse-select-pane on \;\
	set -g mouse-resize-pane on  \;\
	set -g mouse-select-window on   \;\
	display 'Mouse: ON'

bind M \
	set -g mode-mouse off \;\
	set -g mouse-select-pane off \;\
	set -g mouse-resize-pane off  \;\
	set -g mouse-select-window off   \;\
	display 'Mouse: OFF'
unbind-key -n C-a
set -g prefix ^A
set -g prefix2 ^A
bind a send-prefix
