local ZSH_SHELL="/bin/zsh"
local MY_ZDOTDIR=~/projects/adammarsh
local DOTDIR_REPO=https://github.com/Adam2Marsh/osx-env.git

# Update this to personal github token
export HOMEBREW_GITHUB_API_TOKEN=1b150428b66d887ba07fe31f23f3f3ce209c1df8

source /etc/zshenv

echo "Checking sudo priviledges."
echo "${USERNAME}             ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/${USERNAME}.sudo >> /dev/null


if [ "${SHELL}" != "${ZSH_SHELL}" ]; then
    sudo chsh -s ${ZSH_SHELL} ${USERNAME}
fi

rm -rf ~/.profile ~/.bashrc ~/.zshrc ~/.zshrc-e ~/.zcompdump*

if [ -z "${ZDOTDIR}" ]; then
    echo "Adding ZDOTDIR to /etc/zshenv"
    echo "export ZDOTDIR=${MY_ZDOTDIR}" | sudo tee -a /etc/zshenv >> /dev/null
fi

# if [ ! -f /usr/local/bin/brew ]; then
#     ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# fi

# echo "Updating brew and forumulae."
# brew update && brew upgrade

# brew install git

if [ ! -d ${MY_ZDOTDIR} ]; then
    echo "Cloning osx-env to ${MY_ZDOTDIR}"
    local repo_dir
    if [[ "${DOTDIR_REPO}" =~ "http.*" ]]; then
        repo_dir=`echo ${DOTDIR_REPO} | sed  "s+^.*//\(.*\)\.git$+${HOME}/projects/src/\1+"`
    else
        repo_dir=`echo ${DOTDIR_REPO} | sed  "s+^git@\(.*\)\:\(.*\)\.git$+${HOME}/projects/src/\1/\2+"`
    fi
    git -c http.sslVerify=false clone --recurse-submodules -j8 ${DOTDIR_REPO} ${repo_dir} -b ${DOTDIR_BRANCH:-m1}
    ln -s ${repo_dir} ${MY_ZDOTDIR}
fi

# brew tap Homebrew/bundle
# brew bundle --verbose --file=${MY_ZDOTDIR}/Brewfile
