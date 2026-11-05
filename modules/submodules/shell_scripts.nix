{ pkgs }:

{
  tms = pkgs.writeShellScriptBin "tms" ''
        set -euo pipefail

        export PATH=${
          pkgs.lib.makeBinPath [
            pkgs.fzf
            pkgs.fd
            pkgs.tmux
            pkgs.gnused
            pkgs.coreutils
          ]
        }:$PATH

    DIRS=(
            "$HOME/projects/personal"
            "$HOME/projects/work"
            "$HOME/projects/clone"
            "$HOME/projects/meta"
         )

        if [[ $# -eq 1 ]]; then
            selected=$(realpath "$1" 2>/dev/null) || exit 1
        else
            selected=$(
                    fd . "''${DIRS[@]}" --type d --max-depth 1 \
                    | sed "s|^$HOME/||" \
                    | fzf
                    )

                [[ -z $selected ]] && exit 0
                selected="$HOME/$selected"
                    fi

                    [[ ! -d $selected ]] && exit 1


                    selected_name=$(basename "$selected" | tr -cd '[:alnum:]_-')

                        if ! tmux has-session -t "$selected_name" &>/dev/null; then
                            tmux new-session -ds "$selected_name" -c "$selected"
                                fi

                                if [[ -z ''${TMUX-} ]]; then
                                    tmux attach -t "$selected_name"
                                else
                                    tmux switch-client -t "$selected_name"
                                        fi
  '';
  tmux-resurrect-pwd = pkgs.writeShellScriptBin "tmux-resurrect-pwd" ''
    set -euo pipefail

    export PATH=${
      pkgs.lib.makeBinPath [
        pkgs.coreutils
        pkgs.gnugrep
        pkgs.findutils
      ]
    }:$PATH

    resurrect_dir="$HOME/.tmux/resurrect"
    target="$resurrect_dir/last"
    selected_path=$(realpath "''${1:?Missing project path}")

    [[ -d "$resurrect_dir" ]] || exit 0

    newest_file=$(
      find "$resurrect_dir" -maxdepth 1 -type f -name 'tmux_resurrect_*.txt' \
        -exec grep -lF -- "$selected_path" {} + |
        xargs -r ls -t |
        head -n1
    ) || true

    if [[ -z "$newest_file" ]]; then
      echo "No matching Resurrect save found for: $selected_path" >&2
      exit 1
    fi

    ln -sfn "$newest_file" "$target"
  '';
}
