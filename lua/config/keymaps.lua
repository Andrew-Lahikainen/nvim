-- Yank into system clipboard:
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y') -- Yank motion
vim.keymap.set({'n', 'v'}, '<leader>yy', '"+yy') -- Yank line

-- Delete into system clipboard:
vim.keymap.set({'n', 'v'}, '<leader>d', '"+d') -- Delete motion
vim.keymap.set({'n', 'v'}, '<leader>dd', '"+d') -- Delete line

-- Paste from system clipboard:
vim.keymap.set('n', '<leader>P', '"+P') -- Paste before cursor
vim.keymap.set('n', '<leader>p', '"+p') -- Paste after cursor
