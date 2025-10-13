{...} :
{
  services.kanshi = {
    enable = true;
    settings = [ 
      {
        profile.name = "normal";
        profile.outputs = [
          {criteria = "HDMI-A-2"; status = "enable"; position = "0,0"; transform = "90";}
          {criteria = "HDMI-A-1"; status = "enable"; position = "3640,0"; transform = "90";}
          {criteria = "DP-2"; status = "enable"; position = "1080,0"; transform = "normal";}
        ];
      }
    ];
  };
}
