# skkeleton-snacks.nvim

Neovim プラグイン: snacks.nvim の picker で skkeleton による日本語入力を可能にします。

## 概要

[snacks.nvim](https://github.com/folke/snacks.nvim) の picker (検索ウィンドウ) で [skkeleton](https://github.com/vim-skk/skkeleton) による日本語入力を可能にするプラグインです。

snacks.nvim の picker は通常、日本語入力に対応していませんが、このプラグインを使用することで、picker のフローティングウィンドウで skkeleton を使った日本語入力が可能になります。

## インストール

### lazy.nvim を使用する場合

```lua
{
  "urugus/skkeleton-snacks.nvim",
  dependencies = {
    "vim-skk/skkeleton",
    "folke/snacks.nvim",
  },
  config = true,
}
```

### packer.nvim を使用する場合

```lua
use {
  "urugus/skkeleton-snacks.nvim",
  requires = {
    "vim-skk/skkeleton",
    "folke/snacks.nvim",
  },
  config = function()
    require("skkeleton-snacks").setup()
  end
}
```

## 使い方

インストールするだけで、snacks.nvim の picker で skkeleton による日本語入力が可能になります。

picker のフローティングウィンドウ内で、通常の skkeleton のトグルキー（デフォルトでは `<C-j>`）を使用して日本語入力モードを切り替えることができます。

## 設定

デフォルトの設定で動作しますが、必要に応じてカスタマイズすることもできます。

```lua
require("skkeleton-snacks").setup({
  -- skkeleton のトグルキー（デフォルトは <C-j>）
  toggle_key = "<C-j>",

  -- デバッグモード（デフォルトは false）
  debug = false,
})
```

## ライセンス

MIT

## 作者

[urugus](https://github.com/urugus)