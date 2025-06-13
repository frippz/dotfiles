#compdef moon

autoload -U is-at-least

_moon() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_moon_commands" \
"*::: :->moon" \
&& ret=0
    case $state in
    (moon)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:moon-command-$line[1]:"
        case $line[1] in
            (completions)
_arguments "${_arguments_options[@]}" : \
'--shell=[Shell to generate for]:SHELL:_default' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" : \
'--to=[Destination to initialize into]:DEST:_default' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--force[Overwrite existing configurations]' \
'--minimal[Initialize with minimal configuration and prompts]' \
'--yes[Skip prompts and use default values]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'::toolchain -- Specific toolchain to initialize:_default' \
'::plugin -- Plugin locator for the toolchain:_default' \
&& ret=0
;;
(debug)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_moon__debug_commands" \
"*::: :->debug" \
&& ret=0

    case $state in
    (debug)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:moon-debug-command-$line[1]:"
        case $line[1] in
            (config)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(vcs)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(bin)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
':tool -- The tool to query:_default' \
&& ret=0
;;
(node)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_moon__node_commands" \
"*::: :->node" \
&& ret=0

    case $state in
    (node)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:moon-node-command-$line[1]:"
        case $line[1] in
            (run-script)
_arguments "${_arguments_options[@]}" : \
'--project=[ID of project to run in]:PROJECT:_default' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
':name -- Name of the script:_default' \
&& ret=0
;;
        esac
    ;;
esac
;;
(setup)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(teardown)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(action-graph)
_arguments "${_arguments_options[@]}" : \
'--host=[The host address]:HOST:_default' \
'--port=[The port to bind to]:PORT:_default' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--dependents[Include dependents of the focused target(s)]' \
'--dot[Print the graph in DOT format]' \
'--json[Print the graph in JSON format]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'*::targets -- Targets to *only* graph:_default' \
&& ret=0
;;
(project)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--json[Print in JSON format]' \
'--no-tasks[Do not include tasks in output]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
':id -- ID of project to display:_default' \
&& ret=0
;;
(project-graph)
_arguments "${_arguments_options[@]}" : \
'--host=[The host address]:HOST:_default' \
'--port=[The port to bind to]:PORT:_default' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--dependents[Include direct dependents of the focused project]' \
'--dot[Print the graph in DOT format]' \
'--json[Print the graph in JSON format]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'::id -- ID of project to *only* graph:_default' \
&& ret=0
;;
(task-graph)
_arguments "${_arguments_options[@]}" : \
'--host=[The host address]:HOST:_default' \
'--port=[The port to bind to]:PORT:_default' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--dependents[Include direct dependents of the focused target]' \
'--dot[Print the graph in DOT format]' \
'--json[Print the graph in JSON format]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'::target -- Target of task to *only* graph:_default' \
&& ret=0
;;
(sync)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_moon__sync_commands" \
"*::: :->sync" \
&& ret=0

    case $state in
    (sync)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:moon-sync-command-$line[1]:"
        case $line[1] in
            (codeowners)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--clean[Clean and remove previously generated file]' \
'--force[Bypass cache and force create file]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(config-schemas)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--force[Bypass cache and force create schemas]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(hooks)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--clean[Clean and remove previously generated hooks]' \
'--force[Bypass cache and force create hooks]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(projects)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(task)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--json[Print in JSON format]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
':target -- Target of task to display:_default' \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--defaults[Use the default value of all variables instead of prompting]' \
'--dryRun[Run entire generator process without writing files]' \
'--force[Force overwrite any existing files at the destination]' \
'--template[Create a new template]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
':name -- Name of template to generate:_default' \
'::dest -- Destination path, relative from workspace root or working directory:_default' \
'*::vars -- Arguments to define as variable values:_default' \
&& ret=0
;;
(templates)
_arguments "${_arguments_options[@]}" : \
'--filter=[Filter the templates based on this pattern]:FILTER:_default' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--json[Print in JSON format]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(check)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--all[Run check for all projects in the workspace]' \
'-s[Include a summary of all actions that were processed in the pipeline]' \
'--summary[Include a summary of all actions that were processed in the pipeline]' \
'-u[Bypass cache and force update any existing items]' \
'--updateCache[Bypass cache and force update any existing items]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'*::ids -- List of project IDs to explicitly check:_default' \
&& ret=0
;;
(ci)
_arguments "${_arguments_options[@]}" : \
'--base=[Base branch, commit, or revision to compare against]:BASE:_default' \
'--head=[Current branch, commit, or revision to compare with]:HEAD:_default' \
'--job=[Index of the current job]:JOB:_default' \
'--jobTotal=[Total amount of jobs to run]:JOB_TOTAL:_default' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--stdin[Accept touched files from stdin for affected checks]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'*::targets -- List of targets to run:_default' \
&& ret=0
;;
(run)
_arguments "${_arguments_options[@]}" : \
'--query=[Focus target(s) based on the result of a query]:QUERY:_default' \
'--profile=[Record and generate a profile for ran tasks]:PROFILE:(cpu heap)' \
'*--status=[Filter affected files based on a touched status]:STATUS:_default' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--dependents[Run dependents of the primary targets]' \
'-f[Force run and ignore touched files and affected status]' \
'--force[Force run and ignore touched files and affected status]' \
'-i[Run the target interactively]' \
'--interactive[Run the target interactively]' \
'-s[Include a summary of all actions that were processed in the pipeline]' \
'--summary[Include a summary of all actions that were processed in the pipeline]' \
'-u[Bypass cache and force update any existing items]' \
'--updateCache[Bypass cache and force update any existing items]' \
'--no-actions[Run the task without including sync and setup related actions in the graph]' \
'-n[When a task fails, continue executing other tasks instead of aborting immediately]' \
'--no-bail[When a task fails, continue executing other tasks instead of aborting immediately]' \
'--affected[Only run target if affected by touched files or the environment]' \
'--remote[Determine affected against remote by comparing against a base revision]' \
'--stdin[Accept touched files from stdin for affected checks]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'*::targets -- List of targets to run:_default' \
&& ret=0
;;
(ext)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
':id -- ID of the extension to execute:_default' \
'*::passthrough -- Arguments to pass through to the extension:_default' \
&& ret=0
;;
(toolchain)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_moon__toolchain_commands" \
"*::: :->toolchain" \
&& ret=0

    case $state in
    (toolchain)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:moon-toolchain-command-$line[1]:"
        case $line[1] in
            (info)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
':id -- ID of the toolchain to inspect:_default' \
&& ret=0
;;
        esac
    ;;
esac
;;
(clean)
_arguments "${_arguments_options[@]}" : \
'--lifetime=[Lifetime of cached artifacts]:LIFETIME:_default' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(docker)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_moon__docker_commands" \
"*::: :->docker" \
&& ret=0

    case $state in
    (docker)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:moon-docker-command-$line[1]:"
        case $line[1] in
            (file)
_arguments "${_arguments_options[@]}" : \
'--buildTask=[ID of a task to build the project]:BUILD_TASK:_default' \
'--image=[Base Docker image to use]:IMAGE:_default' \
'--startTask=[ID of a task to run the project]:START_TASK:_default' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--defaults[Use default options instead of prompting]' \
'--no-prune[Do not prune the workspace in the build stage]' \
'--no-toolchain[Do not use the toolchain and instead use system binaries]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
':id -- ID of project to create a Dockerfile for:_default' \
'::dest -- Destination path, relative from the project root:_default' \
&& ret=0
;;
(prune)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(scaffold)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'*::ids -- List of project IDs to copy sources for:_default' \
&& ret=0
;;
(setup)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(mcp)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(migrate)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--skipTouchedFilesCheck[Disable the check for touched/dirty files]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_moon__migrate_commands" \
"*::: :->migrate" \
&& ret=0

    case $state in
    (migrate)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:moon-migrate-command-$line[1]:"
        case $line[1] in
            (from-package-json)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--skip-touched-files-check[]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
':id -- ID of project to migrate:_default' \
&& ret=0
;;
(from-turborepo)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--skipTouchedFilesCheck[Disable the check for touched/dirty files]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(query)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_moon__query_commands" \
"*::: :->query" \
&& ret=0

    case $state in
    (query)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:moon-query-command-$line[1]:"
        case $line[1] in
            (hash)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--json[Print the manifest in JSON format]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
':hash -- Hash to inspect:_default' \
&& ret=0
;;
(hash-diff)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--json[Print the diff in JSON format]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
':left -- Base hash to compare against:_default' \
':right -- Other hash to compare with:_default' \
&& ret=0
;;
(projects)
_arguments "${_arguments_options[@]}" : \
'--alias=[Filter projects that match this alias]:ALIAS:_default' \
'--downstream=[Include downstream dependents of queried projects]:DOWNSTREAM:(none direct deep)' \
'--id=[Filter projects that match this ID]:ID:_default' \
'--language=[Filter projects of this programming language]:LANGUAGE:_default' \
'--stack=[Filter projects that match this source path]:STACK:_default' \
'--source=[Filter projects of this tech stack]:SOURCE:_default' \
'--tags=[Filter projects that have the following tags]:TAGS:_default' \
'--tasks=[Filter projects that have the following tasks]:TASKS:_default' \
'--type=[Filter projects of this type]:TYPE_OF:_default' \
'--upstream=[Include upstream dependencies of queried projects]:UPSTREAM:(none direct deep)' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--affected[Filter projects that are affected based on touched files]' \
'--dependents[Include direct dependents of queried projects]' \
'--json[Print the projects in JSON format]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'::query -- Filter projects using a query (takes precedence over options):_default' \
&& ret=0
;;
(tasks)
_arguments "${_arguments_options[@]}" : \
'--downstream=[Include downstream dependents of queried tasks]:DOWNSTREAM:(none direct deep)' \
'--upstream=[Include upstream dependencies of queried tasks]:UPSTREAM:(none direct deep)' \
'--id=[Filter tasks that match this ID]:ID:_default' \
'--command=[Filter tasks with the provided command]:COMMAND:_default' \
'--platform=[Filter tasks that belong to a platform]:PLATFORM:_default' \
'--project=[Filter tasks that belong to a project]:PROJECT:_default' \
'--script=[Filter tasks with the provided script]:SCRIPT:_default' \
'--toolchain=[Filter tasks that belong to a toolchain]:TOOLCHAIN:_default' \
'--type=[Filter projects of this type]:TYPE_OF:_default' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--affected[Filter tasks that are affected based on touched files]' \
'--json[Print the tasks in JSON format]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'::query -- Filter tasks using a query (takes precedence over options):_default' \
&& ret=0
;;
(touched-files)
_arguments "${_arguments_options[@]}" : \
'--base=[Base branch, commit, or revision to compare against]:BASE:_default' \
'--defaultBranch=[When on the default branch, compare against the previous revision]:DEFAULT_BRANCH:(true false)' \
'--head=[Current branch, commit, or revision to compare with]:HEAD:_default' \
'*--status=[Filter files based on a touched status]:STATUS:_default' \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--json[Print the files in JSON format]' \
'--local[Gather files from you local state instead of the remote]' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(upgrade)
_arguments "${_arguments_options[@]}" : \
'--cache=[Mode for cache operations]:CACHE:_default' \
'-c+[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--concurrency=[Maximum number of threads to utilize]:CONCURRENCY:_default' \
'--log=[Lowest log level to output]:LOG:(off error warn info debug trace verbose)' \
'--logFile=[Path to a file to write logs to]:LOG_FILE:_files' \
'--theme=[Terminal theme to print with]:THEME:(dark light)' \
'--color[Force colored output]' \
'--dump[Dump a trace profile to the working directory]' \
'-q[Hide all non-important terminal output]' \
'--quiet[Hide all non-important terminal output]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
        esac
    ;;
esac
}

(( $+functions[_moon_commands] )) ||
_moon_commands() {
    local commands; commands=(
'completions:Generate command completions for your current shell.' \
'init:Initialize a new moon repository, or a new toolchain, by scaffolding config files.' \
'debug:Debug internals.' \
'bin:Return an absolute path to a tool'\''s binary within the toolchain.' \
'node:Special Node.js commands.' \
'setup:Setup the environment by installing all tools.' \
'teardown:Teardown the environment by uninstalling all tools and deleting temp files.' \
'action-graph:Display an interactive dependency graph of all tasks and actions.' \
'project:Display information about a single project.' \
'project-graph:Display an interactive graph of projects.' \
'task-graph:Display an interactive graph of tasks.' \
'sync:Sync the workspace to a healthy state.' \
'task:Display information about a single task.' \
'generate:Generate and scaffold files from a pre-defined template.' \
'templates:List all templates that are available for code generation.' \
'check:Run all build and test related tasks for the current project.' \
'ci:Run all affected projects and tasks in a CI environment.' \
'run:Run one or many project tasks and their dependent tasks.' \
'ext:Execute an extension plugin.' \
'toolchain:Manage toolchain plugins.' \
'clean:Clean the workspace and delete any stale or invalid artifacts.' \
'docker:Operations for integrating with Docker and Dockerfile(s).' \
'mcp:Start an MCP (model context protocol) server that can respond to AI agent requests.' \
'migrate:Operations for migrating existing projects to moon.' \
'query:Query information about moon, the environment, and pipeline.' \
'upgrade:Upgrade to the latest version of moon.' \
    )
    _describe -t commands 'moon commands' commands "$@"
}
(( $+functions[_moon__action-graph_commands] )) ||
_moon__action-graph_commands() {
    local commands; commands=()
    _describe -t commands 'moon action-graph commands' commands "$@"
}
(( $+functions[_moon__bin_commands] )) ||
_moon__bin_commands() {
    local commands; commands=()
    _describe -t commands 'moon bin commands' commands "$@"
}
(( $+functions[_moon__check_commands] )) ||
_moon__check_commands() {
    local commands; commands=()
    _describe -t commands 'moon check commands' commands "$@"
}
(( $+functions[_moon__ci_commands] )) ||
_moon__ci_commands() {
    local commands; commands=()
    _describe -t commands 'moon ci commands' commands "$@"
}
(( $+functions[_moon__clean_commands] )) ||
_moon__clean_commands() {
    local commands; commands=()
    _describe -t commands 'moon clean commands' commands "$@"
}
(( $+functions[_moon__completions_commands] )) ||
_moon__completions_commands() {
    local commands; commands=()
    _describe -t commands 'moon completions commands' commands "$@"
}
(( $+functions[_moon__debug_commands] )) ||
_moon__debug_commands() {
    local commands; commands=(
'config:Debug loaded configuration.' \
'vcs:Debug the VCS.' \
    )
    _describe -t commands 'moon debug commands' commands "$@"
}
(( $+functions[_moon__debug__config_commands] )) ||
_moon__debug__config_commands() {
    local commands; commands=()
    _describe -t commands 'moon debug config commands' commands "$@"
}
(( $+functions[_moon__debug__vcs_commands] )) ||
_moon__debug__vcs_commands() {
    local commands; commands=()
    _describe -t commands 'moon debug vcs commands' commands "$@"
}
(( $+functions[_moon__docker_commands] )) ||
_moon__docker_commands() {
    local commands; commands=(
'file:Generate a default Dockerfile for a project.' \
'prune:Remove extraneous files and folders within a Dockerfile.' \
'scaffold:Scaffold a repository skeleton for use within Dockerfile(s).' \
'setup:Setup a Dockerfile by installing dependencies for necessary projects.' \
    )
    _describe -t commands 'moon docker commands' commands "$@"
}
(( $+functions[_moon__docker__file_commands] )) ||
_moon__docker__file_commands() {
    local commands; commands=()
    _describe -t commands 'moon docker file commands' commands "$@"
}
(( $+functions[_moon__docker__prune_commands] )) ||
_moon__docker__prune_commands() {
    local commands; commands=()
    _describe -t commands 'moon docker prune commands' commands "$@"
}
(( $+functions[_moon__docker__scaffold_commands] )) ||
_moon__docker__scaffold_commands() {
    local commands; commands=()
    _describe -t commands 'moon docker scaffold commands' commands "$@"
}
(( $+functions[_moon__docker__setup_commands] )) ||
_moon__docker__setup_commands() {
    local commands; commands=()
    _describe -t commands 'moon docker setup commands' commands "$@"
}
(( $+functions[_moon__ext_commands] )) ||
_moon__ext_commands() {
    local commands; commands=()
    _describe -t commands 'moon ext commands' commands "$@"
}
(( $+functions[_moon__generate_commands] )) ||
_moon__generate_commands() {
    local commands; commands=()
    _describe -t commands 'moon generate commands' commands "$@"
}
(( $+functions[_moon__init_commands] )) ||
_moon__init_commands() {
    local commands; commands=()
    _describe -t commands 'moon init commands' commands "$@"
}
(( $+functions[_moon__mcp_commands] )) ||
_moon__mcp_commands() {
    local commands; commands=()
    _describe -t commands 'moon mcp commands' commands "$@"
}
(( $+functions[_moon__migrate_commands] )) ||
_moon__migrate_commands() {
    local commands; commands=(
'from-package-json:Migrate \`package.json\` scripts and dependencies to \`moon.*\`.' \
'from-turborepo:Migrate \`turbo.json\` to moon configuration files.' \
    )
    _describe -t commands 'moon migrate commands' commands "$@"
}
(( $+functions[_moon__migrate__from-package-json_commands] )) ||
_moon__migrate__from-package-json_commands() {
    local commands; commands=()
    _describe -t commands 'moon migrate from-package-json commands' commands "$@"
}
(( $+functions[_moon__migrate__from-turborepo_commands] )) ||
_moon__migrate__from-turborepo_commands() {
    local commands; commands=()
    _describe -t commands 'moon migrate from-turborepo commands' commands "$@"
}
(( $+functions[_moon__node_commands] )) ||
_moon__node_commands() {
    local commands; commands=(
'run-script:Run a \`package.json\` script within a project.' \
    )
    _describe -t commands 'moon node commands' commands "$@"
}
(( $+functions[_moon__node__run-script_commands] )) ||
_moon__node__run-script_commands() {
    local commands; commands=()
    _describe -t commands 'moon node run-script commands' commands "$@"
}
(( $+functions[_moon__project_commands] )) ||
_moon__project_commands() {
    local commands; commands=()
    _describe -t commands 'moon project commands' commands "$@"
}
(( $+functions[_moon__project-graph_commands] )) ||
_moon__project-graph_commands() {
    local commands; commands=()
    _describe -t commands 'moon project-graph commands' commands "$@"
}
(( $+functions[_moon__query_commands] )) ||
_moon__query_commands() {
    local commands; commands=(
'hash:Inspect the contents of a generated hash.' \
'hash-diff:Query the difference between two hashes.' \
'projects:Query for projects within the project graph.' \
'tasks:List all available tasks, grouped by project.' \
'touched-files:Query for touched files between revisions.' \
    )
    _describe -t commands 'moon query commands' commands "$@"
}
(( $+functions[_moon__query__hash_commands] )) ||
_moon__query__hash_commands() {
    local commands; commands=()
    _describe -t commands 'moon query hash commands' commands "$@"
}
(( $+functions[_moon__query__hash-diff_commands] )) ||
_moon__query__hash-diff_commands() {
    local commands; commands=()
    _describe -t commands 'moon query hash-diff commands' commands "$@"
}
(( $+functions[_moon__query__projects_commands] )) ||
_moon__query__projects_commands() {
    local commands; commands=()
    _describe -t commands 'moon query projects commands' commands "$@"
}
(( $+functions[_moon__query__tasks_commands] )) ||
_moon__query__tasks_commands() {
    local commands; commands=()
    _describe -t commands 'moon query tasks commands' commands "$@"
}
(( $+functions[_moon__query__touched-files_commands] )) ||
_moon__query__touched-files_commands() {
    local commands; commands=()
    _describe -t commands 'moon query touched-files commands' commands "$@"
}
(( $+functions[_moon__run_commands] )) ||
_moon__run_commands() {
    local commands; commands=()
    _describe -t commands 'moon run commands' commands "$@"
}
(( $+functions[_moon__setup_commands] )) ||
_moon__setup_commands() {
    local commands; commands=()
    _describe -t commands 'moon setup commands' commands "$@"
}
(( $+functions[_moon__sync_commands] )) ||
_moon__sync_commands() {
    local commands; commands=(
'codeowners:Aggregate and sync code owners to a \`CODEOWNERS\` file.' \
'config-schemas:Generate and sync configuration JSON schemas for use within editors.' \
'hooks:Generate and sync hook scripts for the workspace configured VCS.' \
'projects:Sync all projects and configs in the workspace.' \
    )
    _describe -t commands 'moon sync commands' commands "$@"
}
(( $+functions[_moon__sync__codeowners_commands] )) ||
_moon__sync__codeowners_commands() {
    local commands; commands=()
    _describe -t commands 'moon sync codeowners commands' commands "$@"
}
(( $+functions[_moon__sync__config-schemas_commands] )) ||
_moon__sync__config-schemas_commands() {
    local commands; commands=()
    _describe -t commands 'moon sync config-schemas commands' commands "$@"
}
(( $+functions[_moon__sync__hooks_commands] )) ||
_moon__sync__hooks_commands() {
    local commands; commands=()
    _describe -t commands 'moon sync hooks commands' commands "$@"
}
(( $+functions[_moon__sync__projects_commands] )) ||
_moon__sync__projects_commands() {
    local commands; commands=()
    _describe -t commands 'moon sync projects commands' commands "$@"
}
(( $+functions[_moon__task_commands] )) ||
_moon__task_commands() {
    local commands; commands=()
    _describe -t commands 'moon task commands' commands "$@"
}
(( $+functions[_moon__task-graph_commands] )) ||
_moon__task-graph_commands() {
    local commands; commands=()
    _describe -t commands 'moon task-graph commands' commands "$@"
}
(( $+functions[_moon__teardown_commands] )) ||
_moon__teardown_commands() {
    local commands; commands=()
    _describe -t commands 'moon teardown commands' commands "$@"
}
(( $+functions[_moon__templates_commands] )) ||
_moon__templates_commands() {
    local commands; commands=()
    _describe -t commands 'moon templates commands' commands "$@"
}
(( $+functions[_moon__toolchain_commands] )) ||
_moon__toolchain_commands() {
    local commands; commands=(
'info:Show detailed information about a toolchain plugin.' \
    )
    _describe -t commands 'moon toolchain commands' commands "$@"
}
(( $+functions[_moon__toolchain__info_commands] )) ||
_moon__toolchain__info_commands() {
    local commands; commands=()
    _describe -t commands 'moon toolchain info commands' commands "$@"
}
(( $+functions[_moon__upgrade_commands] )) ||
_moon__upgrade_commands() {
    local commands; commands=()
    _describe -t commands 'moon upgrade commands' commands "$@"
}

if [ "$funcstack[1]" = "_moon" ]; then
    _moon "$@"
else
    compdef _moon moon
fi
