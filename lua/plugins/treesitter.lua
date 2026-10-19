return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup {
      -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
      install_dir = vim.fn.stdpath('data') .. '/site',
    }

    -- nvim-treesitter (main) needs Nvim 0.12+; on older versions install() errors,
    -- so guard it and rely on parsers that are already installed.
    if vim.fn.has('nvim-0.12') == 1 then
      require('nvim-treesitter').install({
        'lua', 'vim', 'vimdoc', 'query', 'javascript', 'typescript', 'json',
        'markdown', 'markdown_inline', 'bash', 'c', 'cpp', 'go', 'c_sharp',
        'yaml', 'zig', 'sql',
      }):wait(300000) -- block so the first buffer never loses highlighting
    else
      vim.notify('nvim-treesitter requires Neovim 0.12+ (running ' ..
        tostring(vim.version()) .. '); skipping parser install', vim.log.levels.WARN)
    end

    -- Enable treesitter highlighting for specific filetypes
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'lua', 'vim', 'javascript', 'typescript', 'json',
        'markdown', 'bash', 'c', 'cpp', 'go', 'cs', 'zig', 'sql'
      },
      callback = function(args)
        -- Disable legacy regex syntax so it can't fight treesitter
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].syntax = 'off'
        end
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
