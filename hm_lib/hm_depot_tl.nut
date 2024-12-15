include("hm_lib/hm_global")

class hm_depot_tl extends hm_base_tl {
  desc = null
  desc_name = null
  pos = null
  constructor(sta_name, p) {
    desc_name = sta_name
    pos = coord3d(p[0],p[1],p[2])
    // find descriptor
    foreach (d in building_desc_x.get_building_list(building_desc_x.depot)) {
      if(d.get_name()==desc_name) {
        desc = d
        break
      }
    }
    hm_commands.append(this)
  }

  // returns [error_message, desc]
  function _get_desc(){
    if(desc_name.slice(0,2)=="?f") {
      local key_str = "d" + desc_name.slice(2)
      local d = hm_found_desc.get(key_str)
      if(d==null) {
        return ["Depot key " + desc_name.slice(2) + " is not defined.", null]
      } else if(d[0]==null) {
        return ["No depot was detected between " + hm_found_desc.get_pos_str(key_str), null]
      }
      return [null, d[0]]
    } else if(desc_name.slice(0,2)=="?s") {
      local idx = desc_name.slice(2).tointeger()
      local d = hm_depot_selector().get_desc(idx)
      if(d==null) {
        return ["Selected depot "+desc_name.slice(2)+" is not available.", null]
      }
      return [null, d]
    } else {
      foreach (d in building_desc_x.get_building_list(building_desc_x.depot)) {
        if(d.get_name()==desc_name) {
          return [null, d]
        }
      }
      return ["Depot " + desc_name + " is not found!", null]
    }
  }

  function exec(player, origin) {
    local dr = _get_desc()
    if(dr[0]!=null) {
      return dr[0] // there was a error in obtaining the desc
    }
    local desc = dr[1]
    return command_x.build_depot(player, origin+pos, desc);
  }
}
