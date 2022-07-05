syntax on

set path+=**

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

set exrc
set number
set mouse=a
set numberwidth=1
set ignorecase
set hidden
set clipboard=unnamedplus
set ruler
set encoding=utf-8
set showmatch
set sw=2
set relativenumber
set nohlsearch
set noerrorbells
set laststatus=2
set autoindent
set smartindent
set tabstop=2 shiftwidth=2 softtabstop=2
set expandtab
set nowrap
set smartcase
set nobackup
set undodir=~/.vim/undo
set undofile
set incsearch
set noswapfile
set scrolloff=8
set signcolumn=yes
set noshowmode
set ruler
set colorcolumn=80
set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set wrap
set linebreak

" let g:loaded_node_provider = 0
let g:ale_disable_lsp = 1

call plug#begin('~/.vim/plugged')
" Themes
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Git
Plug 'tpope/vim-fugitive'
Plug 'idanarye/vim-merginal'

" Utils
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'jiangmiao/auto-pairs'

" Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" API REST client
Plug 'NTBBloodbath/rest.nvim'

" File explorer
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" LSP
Plug 'neovim/nvim-lspconfig'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Formating and Linters
Plug 'dense-analysis/ale'

" Debugger
" Plug 'mfussenegger/nvim-dap'

call plug#end()


let mapleader=" "
inoremap jj <Esc>
cnoremap jj <C-C>
nnoremap <leader>w :w<CR>
nnoremap <leader>wa :wa<CR>
nnoremap Y y$
map <C-l> 20zl
map <C-h> 20zh
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>
" yank all the buffer
nnoremap <leader>y gg"+yG<C-o>
" select the entire buffer
nnoremap <leader>v ggVG
nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<CR>
nnoremap <C-Right> :vertical resize +5<CR>
nnoremap <C-Left> :vertical resize -5<CR>
nnoremap <C-Down> :resize -5<CR>
nnoremap <C-Up> :resize +5<CR>

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

" Gruvbox
" let g:gruvbox_contrast_dark = 'soft'
" let g:gruvbox_invert_selection = 0
" let g:gruvbox_bold = 0
" " let g:gruvbox_bold = 0
" if exists('+termguicolors')
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" endif
" colorscheme gruvbox

" Gruvbox-material
" Important!!
if has('termguicolors')
  set termguicolors
endif
" For dark version.
set background=dark
" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'soft'
" For better performance
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

" airline
let g:airline_theme='gruvbox_material'
let g:airline_powerline_fonts = 1

" Ranger
let g:ranger_map_keys = 0
map <leader>r :Ranger<CR>

" vim-fugitive
nnoremap <leader>gs <cmd>Git<cr>
nnoremap <leader>gm <cmd>MerginalToggle<cr>

" ALE
let js_fixers = ['prettier', 'eslint']
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': js_fixers,
\   'typescript': js_fixers,
\   'typescriptreact': js_fixers,
\   'css': ['prettier'],
\   'json': ['prettier'],
\}
let g:ale_fix_on_save = 1



" Treeesitter
lua << EOF
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = "all",

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    ident = {
      enable = true,
    },

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      disable = { "" },

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }
EOF

" rest.nvim
lua << EOF
require'rest-nvim'.setup {
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Keep the http file buffer above|left when split horizontal|vertical
      result_split_in_place = true,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        show_http_info = true,
        show_headers = true,
      },
      -- Jump to request line on run
      jump_to_request = true,
      env_file = '.env',
      custom_dynamic_variables = {},
      yank_dry_run = true,
    }

    vim.api.nvim_set_keymap('n', '<Leader>ar', [[<cmd>lua require'rest-nvim'.run()<cr>]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<Leader>al', [[<cmd>lua require'rest-nvim'.last()<cr>]], {noremap = true, silent = true})
EOF

" Telescope
lua << EOF
require('telescope').setup {
  defaults = {
    file_sorter = require'telescope.sorters'.get_fzy_sorter,
    prompt_prefix = ' >',
    color_devicons = true,
    layout_strategy = "vertical",
    hidden = true,

    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}
require'telescope'.load_extension('fzy_native')
EOF

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>p <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ") })<cr>
nnoremap <leader>fl <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>e <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_branches()<cr>

" LSP Config
lua << EOF
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<leader>di', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>', opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    vim.keymap.set('n', 'gT', '<cmd>Telescope lsp_type_definitions<cr>', bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', bufopts)
    vim.keymap.set('n', '<space>fa', '<cmd>ALEFix<cr>', bufopts)
  end

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'tsserver', 'eslint', 'gopls', 'pyright' }
  -- Setup cmp autocompletion.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        -- This will be the default in neovim 0.7+
        debounce_text_changes = 150,
      }
    }
  end
EOF

" eslint format all on save
" autocmd BufWritePost *.tsx EslintFixAll
" autocmd BufWritePost *.ts EslintFixAll
" autocmd BufWritePost *.js EslintFixAll
" autocmd BufWritePost *.jsx EslintFixAll

" Autocompletion cmp
set completeopt=menu,menuone,noselect
lua << EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

EOF
