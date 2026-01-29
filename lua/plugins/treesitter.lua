return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup {
      -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
      install_dir = vim.fn.stdpath('data') .. '/site',
    }

    -- Install commonly used parsers
    -- This runs asynchronously. For synchronous installation, add :wait()
    require('nvim-treesitter').install {
      'lua',
      'vim',
      'vimdoc',
      'query',
      'javascript',
      'typescript',
      'json',
      'markdown',
      'markdown_inline',
      'bash',
      'c',
      'cpp',
      'go',
      'c_sharp',
      'zig',
      'sql',
    }

    -- Enable treesitter highlighting for specific filetypes
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'lua', 'vim', 'javascript', 'typescript', 'json',
        'markdown', 'bash', 'c', 'cpp', 'go', 'cs', 'zig', 'sql'
      },
      callback = function()
        vim.treesitter.start()
      end,
    })

    -- Enable treesitter-based folding (optional)
    --[[vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'lua', 'vim', 'javascript', 'typescript', 'json',
        'markdown', 'bash', 'c', 'cpp', 'go', 'cs', 'zig', 'sql'
      },
      callback = function()
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
      end,
    })]]

    -- Enable treesitter-based indentation (experimental)
    -- Uncomment the following to enable:
    --[[ vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'lua', 'vim', 'javascript', 'typescript', 'json',
        'markdown', 'bash', 'c', 'cpp', 'go', 'cs', 'zig', 'sql'
      },
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    }) ]]
  end,
}
