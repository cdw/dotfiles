# Dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io) and [age](https://age-encryption.org) encryption.

Includes dev tools, macOS setup via Homebrew, weird DWM config for Linux, and more! Secrets are age-encrypted with `~/.age/key.txt`. The public key is embedded in `.chezmoi.toml.tmpl`.

## Setup

1) Install chezmoi (via brew or from [get.chezmoi.io]()).
2) Get the age private key (Password Safe) and install it:
   ```sh
   mkdir ~/.age && chmod 700 ~/.age
   # Paste key into:
   vim ~/.age/key.txt
   chmod 600 ~/.age/key.txt
   ```

3) Bootstrap, cloning repo to `~/.local/share/chezmoi`:
  ```sh
  chezmoi init github.com/cdw/dotfiles
  chezmoi apply
  ```

4) This will generate `~/.config/chezmoi/chezmoi.toml` from the template and prompt for:

- Email address — used in `.gitconfig` (asked once, cached)
- Minimal install? — Linux only; `true` for servers/NAS/SSH/devcontainers, `false` for full installs
- Hobby Linux desktop? — Linux non-minimal only; `true` for DWM machines

5) Install Homebrew packages (macOS): `brew bundle --global `
6) Install vim plugins: `vim +PlugInstall +qall`
7) Install tmux plugins (TPM): `~/.tmux/plugins/tpm/bin/install_plugins`

## Ongoing

- Encrypt a new secret and add it to chezmoi: `chezmoi add --encrypt ~/.secrets/my_token`
- To stop managing a file:
    ```sh
    chezmoi forget ~/.secrets/my_token
    git add -A && git commit -m "Remove my_token from chezmoi"
    ```
- Apply changes from the repo: `chezmoi update`
- Edit a managed file:
    ```sh
    chezmoi edit ~/.zshrc
    chezmoi apply ~/.zshrc
    ```
- Add a new file: `chezmoi add ~/.config/something`
- Check what would change: ` chezmoi diff `
- Update Brewfile after installing new packages:
    ```sh
    brew bundle dump --global --force
    chezmoi add ~/.Brewfile
    ```

## Local overrides

Machine-specific configs that shouldn't be committed live in unmanaged local files sourced at the end of each config:

- `~/.profile_local`
- `~/.zsh_local`
- `~/.bash_local`
- `~/.vimrc.local`
- `~/.tmux.conf.local`
- `~/.gitconfig.local`
