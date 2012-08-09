## Tmux

### Movements
- start copy mode

    ^B,

- paste

    ^B.

### Selection
- use ' ' to start visual selection, enter to stop

### Split
#### Vertical

    ^B""

#### Horizontal:

    ^B%

### Pane Movements
  
    ^B{ } swaps
    ^B up,down,left,right
    ^B 0 - first window

### Pane management

    ^B! -> make a pane into a window
    ^B alt up,down,left,right pane resize

### Kill
  
    ^B &

### Info

    ^B :info

### new

    tmux new -s session
    tmux attach -t session
    tmux switch -t session
    tmux list-sessions
