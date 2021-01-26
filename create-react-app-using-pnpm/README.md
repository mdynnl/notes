## Using `pnpm` as package manager when `create-react-app`-ing

1. `ln -sf $(which pnpm) ~/.local/bin/npm`
2. `pnpx create-react-app awesome-react-app --typescript --use-npm`

As the time of writing, `pnpm -v` = `5.15.3` and `npm -v` = `6.14.11`


### `cra` warns
#### before boostrapping

```
You are using npm 5.15.3 so the project will be bootstrapped with an old unsupported version of tools.

Please update to npm 6 or higher for a better, fully supported experience.
```


#### after boostrapping

```
Note: the project was bootstrapped with an old unsupported version of tools.
Please update to Node >=10 and npm >=6 to get supported tools in new projects.
```

### Solution 1
- Replace `pnpm` version with `npm -v` in `package.json`

1. `PACKAGE_JSON=$(dirname $(which pnpm))/$(dirname $(readlink $(which pnpm)))/../package.json` \
2. `sudo sed -i s/$(pnpm -v)/$(/bin/npm -v)/ $PACKAGE_JSON`


`pnpm` lives in system lib as it was installed from `AUR`, so `sudo` is needed

This wouldn't be a problem if it was installed `locally`
or if it lives in user writable dir

### Solution 2
1. `me=$(whoami); sudo setfacl -m u:"$me":rw $PACKAGE_JSON` or `sudo chmod o+rw $PACKAGE_JSON`
2. `sed s/$(pnpm -v)/$(/bin/npm -v)/ $PACKAGE_JSON > /tmp/r`
3. `cat /tmp/r > $PACKAGE_JSON; rm /tmp/r`
4. `sudo setfacl -b $PACKAGE_JSON` or `sudo chmod o-rw $PACKAGE_JSON`

~~This also uses `sudo` but not as scary as **Solution 1**~~
After fixing error, there are now more `sudo`s. Not good.

### Solution 3
install `pnpm` locally ¯\\_(ツ)_/¯

### Solution 4
...


## STILL CAN'T FIND A WAY TO USE `PNPM` GLOBALLY
