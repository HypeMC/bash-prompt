# Simple bash prompt

Clone the repo to your home folder:

```shell
cd ~
git clone https://github.com/HypeMC/bash-prompt.git .bash_prompt
```

Add the following to your `.bashrc`:

```shell
. ~/.bash_prompt/prompt.sh

PROMPT_COMMAND="__prompt $color_prompt"
```

![Without the hostname](screen1.png)

With the hostname displayed:

```shell
. ~/.bash_prompt/prompt.sh

PROMPT_COMMAND="__prompt $color_prompt yes"
```

![With the hostname](screen2.png)

When the user is root:

![When root](screen3.png)

When the last exit status iz not zero:

![Non-zero exit status](screen4.png)
