#!/usr/bin/env lua

--------------
-- Settings --
--------------

-- Set this to true to use a better compression algorithm for the DAC driver.
-- Having this set to false will use an inferior compression algorithm that
-- results in an accurate ROM being produced.
local improved_dac_driver_compression = true

---------------------
-- End of settings --
---------------------

-------------------------------------
-- Actual build script begins here --
-------------------------------------

-- Usage:
--   lua build.lua            asks what to build
--   lua build.lua 1|2|3      skips the question (1 = Normal, 2 = Widescreen, 3 = Both)
--   lua build.lua 3 nopause  also skips the "press Enter" pause at the end

local common = require "build_tools.lua.common"

----------------------------------------------------------------------------
-- Command-line arguments
----------------------------------------------------------------------------

local preselected_choice = nil
local do_pause = true

for _, a in ipairs(arg or {}) do
	if a == "nopause" then
		do_pause = false
	elseif a == "1" or a == "2" or a == "3" then
		preselected_choice = tonumber(a)
	end
end

----------------------------------------------------------------------------
-- build_mode.asm is included by settings.asm and holds WidescreenSupport.
-- It is rewritten before every build, and reset to 0 (Normal) when the
-- script ends, so a manual assemble outside this script gives a Normal ROM.
----------------------------------------------------------------------------

local function write_build_mode(widescreen)
	local f = assert(io.open("build_mode.asm", "w"))
	f:write("WidescreenSupport = 1")
	f:write("\nWidescreenType = " .. (widescreen and 1 or 0) .. "\n")
	f:close()
end

----------------------------------------------------------------------------
-- Pause before the script ends, so the result can be read before the window
-- closes. This hooks os.exit, which common.exit() uses, so the pause also
-- happens when a build fails and the error needs to be read.
-- (If there is no input to wait on, e.g. piped input, it continues at once.)
----------------------------------------------------------------------------

local real_exit = os.exit

os.exit = function(...)
	pcall(write_build_mode, false)

	if do_pause then
		io.write("\nPress Enter to close...")
		io.flush()
		io.read("*l")
	end

	real_exit(...)
end

----------------------------------------------------------------------------
-- Ask what to build
----------------------------------------------------------------------------

local function ask_mode()
	local choice = preselected_choice

	while choice ~= 1 and choice ~= 2 and choice ~= 3 do
		print("")
		print("What do you want to build?")
		print("Normal = [1], Widescreen = [2], Both = [3]")
		io.write("Put your number here: ")
		io.flush()

		local line = io.read("*l")
		if line == nil then
			-- No input available (e.g. run from a script), so build everything
			print("")
			return 3
		end

		choice = tonumber(line)
		if choice ~= 1 and choice ~= 2 and choice ~= 3 then
			print("Please type 1, 2 or 3.")
		end
	end

	return choice
end

local choice = ask_mode()

----------------------------------------------------------------------------
-- Build
----------------------------------------------------------------------------


local built = {}

local function build(widescreen, rom_name)
	local label = widescreen and "WIDESCREEN" or "NORMAL"

	print("")
	print("Building " .. rom_name .. ".bin (" .. label .. ")...")

	write_build_mode(widescreen)

	common.build_rom_and_handle_failure("sonic", rom_name, "", "-p=FF", false, "https://github.com/sonicretro/s1disasm")

	-- Correct the ROM's header with a proper checksum and end-of-ROM value.
	common.fix_header(rom_name .. ".bin")

	common.show_flashy_message("Finished building " .. rom_name .. ".bin (" .. label .. ")")
	built[#built + 1] = rom_name .. ".bin (" .. label .. ")"
end

if choice == 1 or choice == 3 then
	build(false, "s1built")
end
if choice == 2 or choice == 3 then
	build(true, "s1built-wide")
end

print("")
print("All done. Built:")
for _, name in ipairs(built) do
	print("  " .. name)
end

-- A successful build; we can quit now. (This pauses first, via the os.exit hook above.)
common.exit()
