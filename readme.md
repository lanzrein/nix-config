# nix config

This repository contains my nix config.


# How to get started

- Install nix 
  
```
bash <(curl -L https://nixos.org/nix/install) --daemon
```
- Install nix-darwin 

```
nix run nix-darwin/master#darwin-rebuild -- switch
```

Then you can reconfigure everytime : 
```
sudo darwin-rebuild switch --flake .
```

## Set up github token 
Get a github token for you account 

```
cat <<EOF
access-tokens = github.com=ghp_XXXX
EOF > ~/.config/nix.conf
```

# Secrets 

You want to be able to set secrets ? there is two ways. 

- SOPS : good for secrets in environment variables, scripts etc. but does not work for secrets in the config
- git-agecrypt : encrypts entire file. its only for the case where I want to put something in the config that is sensitive

## SOPS
### Set up sops 

See https://github.com/Mic92/sops-nix

```sh 
# This is to create your age key
mkdir -p ~/.config/sops/age
nix-shell -p age --run "age-keygen -o ~/.config/sops/age/keys.txt"
nix-shell -p age --run "age-keygen -y ~/.config/sops/age/keys.txt"
# Save this key somewhere safe.
# If you have it already just put it in ~/.config/sops/age/keys.txt...

## --- Now we can encrypt our data 
nix-shell -p sops --run "sops modules/home-manager/secrets/secrets.yaml"
# And you should be good to use it
```

The current secrets that are used are : 
- gitlab_token : a token for Gitlab API 
- gihub_token : a token for Github 
- gitlab_base_url : the url for the gitlab of the company

#### Example usage 

```nix
{
  # Define the secret 
  sops.secrets.github_token = {};
  # Define a file where you put the content of the secret 
  sops.templates.github_token.content = ''${config.sops.placeholder.github_token}'';
  home.sessionVariables = {
    # Output the file content to the shell
    GH_TOKEN="$(cat ${config.sops.templates.github_token.path})";
  };
}
```

### git-agecrypt 

I use git-agecrypt for configuration that needs to be encrypted before activation. 
For instance a nix file with sensitive data. 
One time setup : 
```bash 
git-agecrypt init
git-agecrypt config add -i ~/.ssh/id_ed25519
```
To set it up for a file : 
```bash
git-agecrypt config add -r "$(cat ~/.ssh/id_ed25519.pub)" -p modules/home-manager/sensitive.nix
echo "modules/home-manager/sensitive.nix filter=git-agecrypt diff=git-agecrypt" >> .gitattributes
git-agecrypt config add -i ~/.ssh/id_ed25519
```

You can add any file to be encrypted with the same way 

And now you are all good. 

**I did not find a way to make git-agecrypt compatible with jj :( https://github.com/jj-vcs/jj/issues/53 **


# Relevant links : 

- Home manager parameters : https://nix-community.github.io/home-manager/options.xhtml
- An example nix config that I based myself off https://github.com/abeguin/osx-nix 
- Good article to begin with : https://nixcademy.com/posts/nix-on-macos/ 

