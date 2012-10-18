
"Superscript, subscript in visual mode(selected text)
vmap su "zdi^{<C-R>z}<ESC>
vmap sl "zdi_{<C-R>z}<ESC>

"Superscript, subscript in normal mode
nmap sl i_{<ESC>la}<ESC>
nmap su i^{<ESC>la}<ESC>

"Math mode
vmap sm "zdi$<C-R>z$<ESC>

"fraction
vmap sf "zdi\frac{<C-R>z}<ESC>a{}<ESC>

"To put & instead of all spaces (while preparing a tabular)
vmap st :s/ \+/ \& /g<CR>


" {\em }
vmap se "zdi{\em <C-R>z}<ESC>

" \enquote{ }
vmap sq "zdi\enquote{ <C-R>z}<ESC>
