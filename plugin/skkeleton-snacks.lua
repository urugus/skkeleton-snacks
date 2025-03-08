-- skkeleton-snacks.nvim
-- snacks.nvim の picker で skkeleton による日本語入力を可能にするプラグイン

-- プラグインが既に読み込まれている場合は終了
if vim.g.loaded_skkeleton_snacks then
  return
end
vim.g.loaded_skkeleton_snacks = true

-- Neovim 0.7.0 以上が必要
if vim.fn.has("nvim-0.7.0") == 0 then
  vim.api.nvim_err_writeln("skkeleton-snacks.nvim requires at least Neovim 0.7.0")
  return
end

-- プラグインの初期化は lazy.nvim などのプラグインマネージャーに任せる
-- 明示的に setup() を呼び出す必要がある場合は以下のコメントを解除する
-- require("skkeleton_snacks").setup()