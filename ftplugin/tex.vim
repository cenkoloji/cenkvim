function CR()
    if searchpair('\\begin{itemize}', '', '\\end{itemize}', '')
        return "\r\\item"
    endif
    return "\r"
endfunction
inoremap <expr><buffer> <CR> CR()
