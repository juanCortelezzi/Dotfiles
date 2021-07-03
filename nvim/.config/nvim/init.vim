" let g:tokyonight_style = "night"
" let g:tokyonight_italic_functions = 1
" let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
" let g:tokyonight_transparent = "true"
" colorscheme tokionight

colorscheme nord

" require all lua configs 
lua require('wiz')

function! Wiki()
    colorscheme gruvbox
    set tw=60
    set colorcolumn=61
endfunction
