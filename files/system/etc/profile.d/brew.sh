# Homebrew PATH for the ublue-qtile image (extracted by brew-setup.service).
# Deliberately not gated on interactive shells: the qtile session and
# launcher-spawned terminals need brew on PATH too.
if [ -d /home/linuxbrew/.linuxbrew ]; then
    case ":$PATH:" in
        *:/home/linuxbrew/.linuxbrew/bin:*) ;;
        *) export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH" ;;
    esac
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
    export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
    export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH:+:$MANPATH}"
    export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}"
fi
