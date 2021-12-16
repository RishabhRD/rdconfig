local has_harpoon, harpoon = pcall(require, "harpoon")
if not has_harpoon then
  return
end

harpoon.setup {
  global_settings = {
    enter_on_sendcmd = true,
    excluded_filetypes = { "harpoon" },
  },
}
