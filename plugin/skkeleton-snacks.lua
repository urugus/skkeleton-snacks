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

-- 依存プラグインのチェックは行わない
-- lazy.nvim などのプラグインマネージャーが依存関係を処理するため

-- プラグインの初期化を VimEnter イベント後に遅延させる
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- さらに遅延させて、確実に依存プラグインが読み込まれた後に実行されるようにする
    vim.defer_fn(function()
      require("skkeleton_snacks").setup()
    end, 500)
  end,
  once = true,
})