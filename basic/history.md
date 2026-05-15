# history command tutorial

I. history basic command <br>

```bash
history
```

II. bang command with the number

    !\<nro of the history command\>

III. to make a sudo command with a history
    
    sudo !\<nro\>

IV. include the date and time to the history command in .bashrc

```bash
# Set history format to include timestamps
HISTTIMEFORMAT="%Y-%m-%d %T " 
```
V. to ignore a space in the history command

```bash
# ignore a space in the history command
HISTCONTROL=ignoreboth
```
VI. history nro (to get the last nro command)

```bash
history | grep <padrao_de_procura>
```

[back to main](../main.md)