## git

### diff between remote and current

    | git remote -v
    my      git@github.com:vrthra/facter.git
    o       git@github.com:puppetlabs/facter.git
 
    git diff --color o/master ticket/2.x/1424_zone_facts
    git diff --color --stat

    git log --color o/master..ticket/2.x/1424_zone_facts
    git log --color o/master..
    git log --color ..o/master

invert sequence to get incoming.

### diff between cached and committed

    | git diff --cached

###  restore git pristine

  git reset --hard

### unstage a file

  git rm --cahced <file>

###  checkout a particular commit that started with message
  git checkout :/"Msg"

###  undo a commit
  git revert <hash>

###  Create changelog
  git log > Changelog

###  diff and apply
  git diff | git apply

###  Cherry picking
  Get the checksum out of git : git log 
  git branch -a
  #git checkout --track origin/el6
  git pull origin origin/el6
  git checkout -b < new_branch > origin/< new_branch >
  git branch -a #verify
  git cherry-pick <chksum>
  #verify git log | more

###  Remove a commit from github
| git rebase -i HEAD~4
    and remove the commits needed.
Now verify push to git hub.
 | git log 
 | git push myremote +fixpid-suse

###  Leave the local repo intact, but undo push.
git push -f origin HEAD^:master
git push -f origin HEAD^^:master (last 2 changes)

###  or
git reset --hard hash# 
git push -f origin branch


To run puppet from source
RUBYLIB=/home/rahul/dev/facter/lib:/home/rahul/dev/hiera/lib:/home/rahul/dev/hiera-puppet/lib:/home/rahul/dev/puppet/lib bin/puppet

git clean -n -d -v .
git clean -f -d -v .

git reset --hard origin/branch


| git rename branch
git branch -m old new

To get remote branch
git fetch origin resource:resource
git checkout resoruce

view stash
git stash show -p stash@{0}

git fetch origin 
git checkout --track origin/plugin

git rebase --abort
git fetch puppet
git rebase puppet/3.x

# to diff staged with committed
git diff --cached

=========================
Split a large commit into mulitple things.
(1)  git rebase -i HEAD~10
     # interactive mode brings up an editor with a list of the last 10 commits
     # pick patch to split, tag with edit
(2)  git reset HEAD~1
(3)  git add -p some-file
     # go through hunks and select the ones you want
     # using the 'e' menu option you can edit the patch (in your editor)
(4)  git commit -m"part one"
(5)  git add -i
     # select files to operate on
(6)  git commit -m"part two"
(7)  git commit -m"part three" -a
(8)  git rebase --continue
===========================
