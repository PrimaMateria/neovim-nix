# vim: ft=lua
{ extraPackages, ... }: ''
  vim.g["plantuml_previewer#plantuml_jar_path"] = "${extraPackages.plantuml-jar}/share/java/plantuml.jar"
  vim.g["plantuml_previewer#viewer_path"] = "/mnt/c/Users/matus.benko/Downloads/plantumlPreviewer"

  local wk = require("which-key")
  local puml_preview_file = "/tmp/nvim-puml-preview.puml"
  local puml_buf = nil

  local function extract_puml_block()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]

    local start_line = nil
    for i = cursor_line, 1, -1 do
      if lines[i]:match("^```plantuml") then
        start_line = i
        break
      end
    end

    if not start_line then
      vim.notify("No plantuml block under cursor", vim.log.levels.WARN)
      return nil
    end

    local end_line = nil
    for i = start_line + 1, #lines do
      if lines[i]:match("^```%s*$") then
        end_line = i
        break
      end
    end

    if not end_line then
      vim.notify("Plantuml block not closed", vim.log.levels.WARN)
      return nil
    end

    local content = {}
    for i = start_line + 1, end_line - 1 do
      table.insert(content, lines[i])
    end
    return content
  end

  local function preview_puml()
    local content = extract_puml_block()
    if not content then return end

    local orig_win = vim.api.nvim_get_current_win()

    if not puml_buf or not vim.api.nvim_buf_is_valid(puml_buf) then
      vim.cmd("botright 5split " .. puml_preview_file)
      puml_buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_lines(puml_buf, 0, -1, false, content)
      vim.cmd("write")
      vim.cmd("PlantumlOpen")
      vim.cmd("close")
      vim.api.nvim_set_current_win(orig_win)
    else
      vim.api.nvim_buf_call(puml_buf, function()
        vim.api.nvim_buf_set_lines(0, 0, -1, false, content)
        vim.cmd("write")
      end)
    end

    vim.notify("PlantUML updated", vim.log.levels.INFO)
  end

  vim.keymap.set("n", ",p", preview_puml, { silent = true })

  wk.add({
    { ",p", desc = "Preview plantuml block" },
  })
''
