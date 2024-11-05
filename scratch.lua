local function read_file_with_system(filename)
  local pipe = vim.system({"cat", filename})
  local content = pipe:wait().stdout
  local lines = vim.split(content, "\n", { trimempty = true })
  return lines
end

local api = vim.api
local buf = api.nvim_create_buf(false, true)
local win = api.nvim_open_win(buf, false, {
    relative="editor",
    width=80,
    height=24,
    row=0,
    col=0,
})
api.nvim_buf_set_lines(buf, 0, -1, false, read_file_with_system("./package.json"))

vim.defer_fn(function()
    api.nvim_win_close(win, true)
end, 5000)


