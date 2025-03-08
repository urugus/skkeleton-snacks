-- skkeleton-snacks.nvim
-- snacks.nvim の picker で skkeleton による日本語入力を可能にするプラグイン

local M = {}

-- デフォルト設定
M.default_config = {
  -- skkeleton のトグルキー（デフォルトは <C-j>）
  toggle_key = "<C-j>",

  -- デバッグモード（デフォルトは false）
  debug = false,
}

-- ユーザー設定
M.config = {}

-- プラグインの初期化
function M.setup(opts)
  -- デフォルト設定とユーザー設定をマージ
  M.config = vim.tbl_deep_extend("force", M.default_config, opts or {})

  -- 依存関係のチェックを行わない
  -- 代わりに、必要なときに動的に読み込む

  -- 自動コマンドグループを作成
  local group = vim.api.nvim_create_augroup("SkkeletonSnacks", { clear = true })

  -- snacks の picker の input ウィンドウが開かれたときに実行される関数
  local function enable_skkeleton_in_snacks()
    -- バッファのタイプやウィンドウの特性を確認
    local buf = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()

    -- snacks の picker の input ウィンドウかどうかを確認
    -- ウィンドウの名前や特性で判断
    local win_config = vim.api.nvim_win_get_config(win)
    if win_config.relative ~= "" then -- フローティングウィンドウの場合
      -- skkeleton プラグインが利用可能かどうかを確認
      local has_skkeleton = pcall(function() return vim.fn["skkeleton#is_enabled"] end)
      if not has_skkeleton then
        if M.config.debug then
          vim.notify("skkeleton is not available, skipping", vim.log.levels.DEBUG)
        end
        return
      end

      -- バッファローカルなキーマッピングを設定
      vim.api.nvim_buf_set_keymap(buf, "i", M.config.toggle_key, "<Plug>(skkeleton-toggle)", { silent = true, noremap = false })

      -- skkeleton を有効にする
      vim.b[buf].skkeleton = true

      -- デバッグ用のメッセージ
      if M.config.debug then
        vim.notify("skkeleton enabled in snacks picker", vim.log.levels.INFO)
      end
    end
  end

  -- WinEnter イベントで自動コマンドを設定
  vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    callback = enable_skkeleton_in_snacks,
  })

  -- BufEnter イベントでも自動コマンドを設定
  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    callback = enable_skkeleton_in_snacks,
  })

  -- 特にフローティングウィンドウが作成されたときのイベント
  vim.api.nvim_create_autocmd("WinNew", {
    group = group,
    callback = function()
      -- 少し遅延させて実行
      vim.defer_fn(enable_skkeleton_in_snacks, 10)
    end,
  })

  -- デバッグメッセージ
  if M.config.debug then
    vim.notify("skkeleton-snacks.nvim loaded", vim.log.levels.INFO)
  end
end

return M