
this.hm_all_waytypes <- [wt_road,wt_rail,wt_water,wt_monorail,wt_maglev,wt_tram,wt_narrowgauge,wt_air,wt_power]

function hm_get_way_desc(desc_name, wt, st) {
  local obj = null

  //gui.add_message_at(player, "hm_get_way_desc " + desc_name + " wt " + wt + " st " + st, world.get_time())
  if ( wt == null || st == null ) {
    // not set waytype and/or systemtype
    // object not found, break script
    foreach(wt in hm_all_waytypes) {
      foreach (st in [st_flat, st_elevated, st_tram, st_runway]) {
        foreach (w in way_desc_x.get_available_ways(wt, st)) {
          if(w.get_name()==desc_name) {
            obj = w
          }
        }
      }
    }

  } else {
    // set waytype and systemtype
    // object not available then replace
    local list = way_desc_x.get_available_ways(wt, st)
    foreach (w in list) {
      //gui.add_message_at(player, "w.get_name() " + w.get_name(), world.get_time())
      if(w.get_name()==desc_name) {
        obj = w
        //gui.add_message_at(player, "found desc_name " + obj.get_name(), world.get_time())
      }
      if ( obj == null ) {
        obj = w
        //gui.add_message_at(player, "fallback " + obj.get_name(), world.get_time())
      }
    }

  }

  return obj
}

function hm_get_bridge_desc(desc_name, wt) {
  local obj = null

  if ( wt == null ) {
    // not set waytype
    // object not found, break script
    foreach(wt in hm_all_waytypes) {
      foreach (b in bridge_desc_x.get_available_bridges(wt)) {
        if(b.get_name()==desc_name) {
          obj = b
        }
      }
    }
  } else {
    // set waytype and systemtype
    // object not available then replace
    local list = way_desc_x.get_available_bridges(wt)
    foreach (b in list) {
      if(b.get_name()==desc_name) {
        obj = b
      }
      if ( obj == null ) {
        obj = b
      }
    }

  }

  return obj
}

function hm_get_sign_desc(desc_name, wt) {
  local obj = null

  if ( wt == null ) {
    // not set waytype
    // object not found, break script
    foreach(wt in hm_all_waytypes) {
      foreach (s in sign_desc_x.get_available_signs(wt)) {
        if(s.get_name()==desc_name) {
          obj = s
        }
      }
    }
  } else {
    // set waytype and systemtype
    // object not available then replace
    local list = way_desc_x.get_available_signs(wt)
    foreach (s in list) {
      if(w.get_name()==desc_name) {
        obj = s
      }
      if ( obj == null ) {
        obj = s
      }
    }

  }

  return obj
}
