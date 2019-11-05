" Author: Tim <tim@inept.tech>
" Description: Lint Ada files with the Ada Language Server

call ale#Set('ada_ls_executable', 'ada_language_server')
call ale#Set('ada_ls_project', 'default.gpr')
call ale#Set('ada_ls_encoding', 'utf-8')

function! ada_ls#GetRootDir(buffer) abort
    let l:ada_gpr = ale#path#FindNearestFile(a:buffer, '*.gpr')

    return expand('#' . a:buffer . ':p:h')
endfunction

function! ada_ls#GetInitializationOptions(buffer) abort
    return {
    \   'ada.projectFile': ale#Var(a:buffer, 'ada_ls_project'),
    \   'ada.defaultCharset': ale#Var(a:buffer, 'ada_ls_encoding')
    \}
endfunction

call ale#linter#Define('ada', {
\   'name': 'ada_ls',
\   'lsp': 'stdio',
\   'executable': {b -> ale#Var(b, 'ada_ls_executable')},
\   'command': '%e',
\   'project_root': function('ada_ls#GetRootDir'),
\   'initialization_options': function('ada_ls#GetInitializationOptions')
\})
