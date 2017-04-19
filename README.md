# Blog source

The site is generated with [Hugo](https://gohugo.io).

The source is in branch 'source' and the generated result (that is served by github pages) is in 'master' branch.

# Generate

Running hugo will put content in the 'public' folder.

    $ hugo

# Branch setup

 1. Clone repository and checkout branch 'source'
 2. Map 'public' folder to the 'master' branch:
    git worktree add -B master public origin/master
