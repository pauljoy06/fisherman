#Git related comments
alias ga='git add .'
alias gc='git commit'
alias gs='git status'
alias gp='git push'
alias gpl='git pull'
alias gcd='git checkout demo'
alias gcmaster='git checkout master'
alias gcm='git checkout main'

function gac
	git add .
	git commit
end

function res
	flask rebuild
	python3 run.py
end

#Navigation
alias postnav='cd ~/Repos/posterious/'
alias adnav='cd ~/Repos/advisorscoop/'
alias dianav='cd ~/Repos/diagonalley/'
alias azaadnav='cd ~/Repos/azaad/'
alias wynav='cd ~/Repos/wysible/'
alias shnav='cd ~/Repos/shloak/'

#For editing fish config file
alias edit='vim ~/.config/fish/config.fish'

#For reloading fish config file
alias reload='source ~/.config/fish/config.fish'

#Android Studio settings
#export ANDROID_HOME=$HOME/Library/Android/sdk
#export PATH=$PATH:$ANDROID_HOME/emulator
#export PATH=$PATH:$ANDROID_HOME/tools
#export PATH=$PATH:$ANDROID_HOME/tools/bin
#export PATH=$PATH:$ANDROID_HOME/platform-tools


#Android Studio settings (fish shell)
set -gx ANDROID_SDK_ROOT $HOME/Library/Android/sdk
set -gx PATH $PATH:$ANDROID_SDK_ROOT/emulator
set -gx PATH $PATH:$ANDROID_SDK_ROOT/platform-tools
#set --export ANDROID $HOME/Library/Android;
#set --export ANDROID_HOME $ANDROID/sdk;
#set -gx PATH $ANDROID_HOME/tools $PATH;
#set -gx PATH $ANDROID_HOME/tools/bin $PATH;
#set -gx PATH $ANDROID_HOME/platform-tools $PATH;
#set -gx PATH $ANDROID_HOME/emulator $PATH

#set --export JAVA_HOME /Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home;
#set -gx PATH $JAVA_HOME/bin $PATH
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home


#For styling fish terminal

#below command is for disabling python default virtual environment
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
#For displaying names default git branches like main, master
set -g theme_display_git_default_branch yes


#For buidling APK for shloak project
function buildshloak
    cd /Users/paulpadamadan/Repos/ShloakMobile/Shloak 
    npx react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res/
    cd android/
    ./gradlew assembleDebug
    cd ..
end

function buildconsumertranslations
    cd /Users/paulpadamadan/Repos/Shloak 
    flask translations-rebuild && flask export-translations-json consumer && cp data/consumerTranslations.json /Users/paulpadamadan/Repos/ShloakMobile/Shloak/data/translations.json
end

function buildvendortranslations
    cd /Users/paulpadamadan/Repos/Shloak 
    flask translations-rebuild && flask export-translations-json vendor && cp data/vendorTranslations.json static/js/react/data/translations.json
end

# Load fishmarks (http://github.com/techwizrd/fishmarks)
. $HOME/.fishmarks/marks.fish

# NVM settings
function nvm
   bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end

set -x NVM_DIR ~/.nvm
nvm use default --silent

#pyenv config
alias brew="env PATH=(string replace (pyenv root)/shims '' \"\$PATH\") brew"
pyenv init - | source

#Fuck
alias fuck='sudo (history -p \!\!)'

#Server login commands
alias sunassist_login_live='ssh ubuntu@13.237.51.141'
alias sunassist_login_demo='ssh ubuntu@3.105.221.33'
alias newfaces_login_live='ssh paul@crm.nfsacademy.it'

#Code for auto node version change (below functions - nvm, nvm_find_nvmrc, load_nvm)
# ~/.config/fish/functions/nvm.fish
function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# ~/.config/fish/functions/nvm_find_nvmrc.fish
function nvm_find_nvmrc
  bass source ~/.nvm/nvm.sh --no-use ';' nvm_find_nvmrc
end

# ~/.config/fish/functions/load_nvm.fish
function load_nvm --on-variable="PWD"
  # Check if the current directory is within /Users/paulpadamadan/Repos or its subdirectories
  # if not string match -q "/Users/paulpadamadan/Repos*" $PWD
    # If not, return early
    # return
  # end
  
  # Updated logic
  # Check if the current directory is a first-level subdirectory of /Users/paulpadamadan/Repos
  set -l parent_dir /Users/paulpadamadan/Repos
  set -l subdir_count (string split -r -m 1 / $PWD | string split -m 1 / | count)
  if test $subdir_count -ne 2; or not string match -q "$parent_dir*" $PWD
    # If not, return early
    return
  end

  set -l default_node_version (nvm version default)
  set -l node_version (nvm version)
  set -l nvmrc_path (nvm_find_nvmrc)
  if test -n "$nvmrc_path"
    set -l nvmrc_node_version (nvm version (cat $nvmrc_path))
    if test "$nvmrc_node_version" = "N/A"
      nvm install (cat $nvmrc_path)
    else if test "$nvmrc_node_version" != "$node_version"
      nvm use $nvmrc_node_version
    end
  else if test "$node_version" != "$default_node_version"
    echo "Reverting to default Node version"
    nvm use default
  end
end

# ~/.config/fish/config.fish
# You must call it on initialization or listening to directory switching won't work
load_nvm > /dev/stderr

function q -d 'Alias for custom request response program'
    python3 ~/Repos/q/q.py $argv
end

set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
status --is-interactive; and pyenv init - | source

