ctrl-z
bg

touch /tmp/stdout
touch /tmp/stderr
gdb -p $!

# In GDB
p dup2(open("/tmp/stdout", 1), 1)
p dup2(open("/tmp/stderr", 1), 2)
detach
quit

# Back in shell
disown
logout
