;; -*- lexical-binding: t -*-

(require 'emms-setup)
(emms-all)
(emms-default-players)

(require 'emms-player-simple)
(require 'emms-source-file)
(require 'emms-source-playlist)
(require 'emms-volume)
(setq emms-player-list '(emms-player-vlc
                         emms-player-mplayer
                         emms-player-ogg123
                         emms-player-mpg321))
(setq emms-info-asynchronously t)
(setq emms-source-file-directory-tree-function
      'emms-source-file-directory-tree-find)
(setq emms-source-file-default-directory "/mnt/data/music/")

(provide 'setup-emms)
