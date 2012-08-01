## CPIO

### create

    ls | cpio -ov | gzip > lst.cpio.gz

### list

Only perl files.

    gzcat lst.cpio.gz | cpio -tiv "*.pl"

### extract
  
Only perl files.

    gzcat lst.cpio.gz | cpio -div "*.pl"

### except

    gzcat lst.cpio.gz | cpio -fiv "*.pl"

### no absolute filenames

    cpio --no-absolute-filenames

### example usage

    find $HOME -print | cpio -ovBH newc > me.cpio
    cpio -itBH newc < me.cpio

