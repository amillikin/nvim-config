local keymap = vim.keymap
local api = vim.api
local uv = vim.loop

-- Insert a blank line below or above current line (do not move the cursor),
-- see https://stackoverflow.com/a/16136133/6064933
keymap.set("n", "<space>o", "printf('m`%so<ESC>``', v:count1)", {
  expr = true,
  desc = "insert line below",
})

keymap.set("n", "<space>O", "printf('m`%sO<ESC>``', v:count1)", {
  expr = true,
  desc = "insert line above",
})

-- Remove trailing whitespace characters
keymap.set("n", "<leader><space>", "<cmd>StripTrailingWhitespace<cr>", { desc = "remove trailing space" })


-- Insert a space after current character
keymap.set("n", "<space><space>", "a<Space><ESC>h")
