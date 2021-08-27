# dotfiles

This is my dotfiles repo. There are many like it, but this one is mine.

It doesn't try to do much aside from managing actual dotfiles and a few extra files that make the 
prompt work.

## Usage

1. Download/clone this repo to "~/dotfiles"
2. Run `~/dotfiles/install.sh`

### With curl and tar

```shell
sh -c "$(curl -L https://raw.githubusercontent.com/WillAbides/dotfiles/main/download.sh)" \
&& ~/dotfiles/install.sh
```

### With wget and tar

```shell
sh -c "$(wget -O - https://raw.githubusercontent.com/WillAbides/dotfiles/main/download.sh)" \
&& ~/dotfiles/install.sh
```

### With git

```shell
start_dir="$(pwd)" \
&& cd ~ \
&& git clone https://github.com/WillAbides/dotfiles.git \
&& cd dotfiles \
&& git remote set-url --push origin git@github.com:WillAbides/dotfiles.git \
&& ./install.sh \
&& cd "$start_dir"
```
