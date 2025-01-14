vim.keymap.set("n", "<leader>t", function()
	vim.api.nvim_command("echo nvim_get_current_win()")
	-- if not is_no_name_buffer() then
	-- 	new_window_bottom(15)
	-- end
	--
	-- start_terminal_window()
end)

function valueInArray(array, value) 
	for _, v in ipairs(array) do 
		if v == value then 
			return true 
		end 
	end 
	return false 
end

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>:wincmd p<CR>", { desc = "Exit terminal mode" })

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
})

local function is_no_name_buffer()
	local buf_name = vim.api.nvim_buf_get_name(0)
	return buf_name == ""
end

local terminal_window = nil
local previous_window = nil

local function new_window_bottom(height)
	vim.cmd.new()
	vim.api.nvim_command("botright wincmd J")
	vim.api.nvim_win_set_height(0, height)
end

local function start_terminal_window()
	vim.api.nvim_command("terminal")
	vim.api.nvim_command("startinsert")

	terminal_window = vim.api.nvim_get_current_win()
end

vim.keymap.set({"n", "t"}, "<c-\\>", function()
	if vim.api.nvim_get_current_win() == terminal_window then
		if previous_window then
			vim.api.nvim_set_current_win(previous_window)
			return
		end

		vim.api.nvim_command("wincmd p")
		return
	end

	if not valueInArray(vim.api.nvim_list_wins(), terminal_window) then
		terminal_window = nil
	end
	
	previous_window = vim.api.nvim_get_current_win()

	if terminal_window then
		vim.api.nvim_set_current_win(terminal_window)
	else
		new_window_bottom(15)

		start_terminal_window()
	end

	vim.api.nvim_command("startinsert")
end)
