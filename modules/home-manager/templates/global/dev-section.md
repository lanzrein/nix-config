## Development

### Nix

The repository provides a flake-based development environment for your convenience.

To get started with nix you have to : 
- Install nix package manager [here](https://nixos.org/download/)
- Install direnv with your preferred method see [here](https://direnv.net/docs/installation.html)



#### Usage

##### direnv

To use nix with direnv, rename \`.envrc.recommended\` files into \`.envrc\` then navigate to each techonoly folder and run \`direnv allow .\`

##### nix develop

\`\`\`
nix develop
\`\`\`

### xc 

You can use the task manager \`xc\` to quickly start some scripts. All the scripts available (if any) are written at the [tasks](#tasks) section.