function CR()
    if searchpair('\\begin{itemize}', '', '\\end{itemize}', '') || searchpair('\\begin{enumerate}', '', '\\end{enumerate}', '')
        return "\r\\item"
    endif
    return "\r"
endfunction
inoremap <expr><buffer> <CR> CR()
