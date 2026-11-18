local map = vim.keymap.set

local last_file_buf = nil
local last_file_pos = nil

-- filetypes we don't want to track
local ignored_filetypes = {
    netrw = true,
    dashboard = true,
    alpha = true,
    snacks_dashboard = true,
}

-- check if this is a real file we care about
local function is_real_file_buffer(buf)
    if not vim.api.nvim_buf_is_valid(buf) then return false end
    if ignored_filetypes[vim.bo[buf].filetype] then return false end
    if vim.bo[buf].buftype ~= "" then return false end
    if vim.api.nvim_buf_get_name(buf) == "" then return false end
    return true
end

-- keep track of the last real file we were in
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(args)
        if is_real_file_buffer(args.buf) then
            last_file_buf = args.buf
        end
    end,
})

-- space e opens netrw, space e again takes you back
map("n", "<leader>e", function()
    if vim.bo.filetype == "netrw" then
        -- go back to the file
        if not (
            last_file_buf
            and vim.api.nvim_buf_is_valid(last_file_buf)
            and vim.api.nvim_buf_is_loaded(last_file_buf)
        ) then
            return
        end
        local pos = last_file_pos
        vim.api.nvim_set_current_buf(last_file_buf)
        if pos then
            vim.schedule(function()
                pcall(vim.fn.setpos, ".", pos)
            end)
        end
        return
    end

    -- save where we are before opening netrw
    local current_buf = vim.api.nvim_get_current_buf()
    if is_real_file_buffer(current_buf) then
        last_file_buf = current_buf
        last_file_pos = vim.fn.getcurpos()
    end

    local file = vim.api.nvim_buf_get_name(current_buf)

    -- no file open, just open netrw
    if file == "" then
        vim.cmd("Ex")
        return
    end

    local dir = vim.fn.fnamemodify(file, ":h")
    local filename = vim.fn.fnamemodify(file, ":t")

    if vim.fn.isdirectory(dir) == 0 then
        vim.cmd("Ex")
        return
    end

    vim.cmd("Ex " .. vim.fn.fnameescape(dir))

    -- wait for netrw to load then put cursor on the file
    vim.defer_fn(function()
        if vim.bo.filetype ~= "netrw" then return end
        local escaped = vim.fn.escape(filename, [[\.^$~[]*]])
        pcall(vim.fn.search, "^" .. escaped .. "$", "cw")
    end, 20)
end)
