{
  env = {
    "TERM" = "xterm-256color";
  };

  background_opacity = 1;

  window = {
    padding.x = 17;
    padding.y = 10;
    # decorations = "buttonless";
  };

  font = {
    size = 8.0;
    use_thin_strokes = true;

    normal.family = "Iosevka Nerd Font";
    bold.family =   "Iosevka Nerd Font";
    italic.family = "Iosevka Nerd Font";
  };


  cursor.style = "Beam";

  shell = {
    program = "nu";
  };

  colors = {
    # Default colors
    primary = {
      background = "#1E2029";
      foreground = "#f8f8f2";
    };

  normal = {
    black =   "#6272a4";
    red =     "#ff5c57";
    green =   "#5af78e";
    yellow =  "#f3f99d";
    blue =    "#57c7ff";
    magenta = "#ff6ac1";
    cyan =    "#9aedfe";
    white =   "#f1f1f0";
};
  bright = {
    black =   "#6272a4";
    red =     "#ff5c57";
    green =   "#5af78e";
    yellow =  "#f3f99d";
    blue =    "#57c7ff";
    magenta = "#ff6ac1";
    cyan =    "#9aedfe";
    white =   "#eff0eb";
};
  };
}
