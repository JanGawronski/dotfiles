{
  programs.yt-dlp = {
    enable = true;
    settings = {
      audio-format = "mp3";
      audio-quality = 0;
      remux-video = "mp4>mkv";
      sponsorblock-remove = "all";
      ppa = "\"ThumbnailsConvertor+FFmpeg_o:-c:v mjpeg -vf crop='min(iw\,ih)':min'(iw\,ih)',scale=w=500:h=500:force_original_aspect_ratio=decrease,setsar=1\"";
      embed-thumbnail = true;
      embed-metadata = true;
      output = "%(title)s.%(ext)s";
    };
    extraConfig = ''
    --replace-in-metadata artist " " ""
    --replace-in-metadata title " " ""
    '';
  };
}
