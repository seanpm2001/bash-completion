build_options()
{
    options="--target= --set: --output-dir --main-class= --debug --no-debug --test --clean --run"
    additional_options="--no-native-build --native-build-args= --run-args= --test-server-url= --test-list-file="
    compiler_options="--no-strip -O -W"
    debugging_options="--print-internals"
    opts="$projects $options $additional_options $compiler_options $debugging_options"
    echo $opts
}

suggest_project()
{
    projects=`ls *.unoproj`
    for p in $projects; do
        for w in "${COMP_WORDS[@]}"; do
            if [ "$p" == "$w" ]; then
                return
            fi
        done
    done
    echo $projects
}

_uno() 
{
    local cur command root_cmds projects opts options
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    command=${COMP_WORDS[1]}
    root_cmds="build clean create run browse update config --version --help"
    projects=`suggest_project`

    case "${command}" in
        build)
            opts=`build_options`
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            return 0
        ;;
        clean)
            COMPREPLY=( $(compgen -W "${projects}" -- ${cur}) )
            return 0
        ;;
        create)
            opts="-f --force -c --class"
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            return 0
        ;;
        run)
            COMPREPLY=( $(compgen -W "${projects}" -- ${cur}) )
            return 0
        ;;
        browse)
            opts=`build_options`
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            return 0
        ;;
        update)
            options="--defaults --strip"
            opts="$projects $options"
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            return 0
        ;;
        config)
            return 0
        ;;
    esac

    COMPREPLY=( $(compgen -W "${root_cmds}" -- ${cur}) )
}
complete -F _uno uno