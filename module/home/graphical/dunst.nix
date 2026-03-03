{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        timeout = 0;
        set_transient = "no";
        ignore_dbusclose = true;
      };
      urgency_low.timeout = 0;
      urgency_normal.timeout = 0;
      urgency_critical.timeout = 0;
    };
  };
}
