return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.1.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 12,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "defense_tileset",
      firstgid = 1,
      filename = "defense_tileset.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "../img/towerDefense_tilesheet.png",
      imagewidth = 736,
      imageheight = 416,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 299,
      tiles = {
        {
          id = 29,
          properties = {
            ["path"] = "true"
          }
        },
        {
          id = 98,
          properties = {
            ["path"] = "true"
          }
        },
        {
          id = 160,
          properties = {
            ["path"] = "true"
          }
        },
        {
          id = 241,
          properties = {
            ["path"] = "true"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "grid",
      x = 0,
      y = 0,
      width = 20,
      height = 12,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        130, 75, 76, 76, 76, 76, 77, 130, 130, 130, 130, 130, 130, 75, 76, 76, 76, 76, 77, 130,
        130, 98, 242, 99, 99, 99, 100, 130, 130, 130, 130, 130, 130, 98, 99, 99, 99, 99, 100, 130,
        130, 98, 99, 78, 79, 99, 100, 75, 76, 76, 76, 76, 77, 98, 99, 78, 79, 99, 100, 130,
        130, 98, 99, 100, 98, 99, 100, 98, 99, 99, 99, 99, 100, 98, 99, 100, 98, 99, 100, 130,
        130, 98, 99, 100, 98, 99, 100, 98, 99, 78, 79, 99, 100, 98, 99, 100, 98, 99, 100, 130,
        76, 102, 99, 100, 98, 99, 100, 98, 99, 100, 98, 99, 100, 98, 99, 100, 98, 99, 101, 76,
        99, 99, 99, 100, 98, 99, 100, 98, 99, 100, 98, 99, 100, 98, 99, 100, 98, 99, 99, 99,
        122, 122, 122, 123, 98, 99, 100, 98, 99, 100, 98, 99, 100, 98, 99, 100, 121, 122, 122, 122,
        130, 130, 130, 130, 98, 99, 100, 98, 99, 100, 98, 99, 100, 98, 99, 100, 130, 130, 130, 130,
        130, 130, 130, 130, 98, 99, 101, 102, 99, 100, 98, 99, 101, 102, 99, 100, 130, 130, 130, 130,
        130, 130, 130, 130, 98, 99, 99, 99, 99, 100, 98, 99, 99, 99, 99, 100, 130, 130, 130, 130,
        130, 130, 130, 130, 121, 122, 122, 122, 122, 123, 121, 122, 122, 122, 122, 123, 130, 130, 130, 130
      }
    }
  }
}
