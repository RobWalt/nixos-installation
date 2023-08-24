{ inputs, ... }:
let inherit (inputs) adminName; in
{
  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * *   ${adminName}  DISPLAY=:0 feh --bg-max /home/${adminName}/wallpaper/bg/ -z --image-bg \"#345\""
    ];
  };
}
