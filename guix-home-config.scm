(define-module (guix-home-config)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu services)
  #:use-module (gnu system shadow)
  #:use-module (gnu packages)) ;; Importação do módulo de pacotes

(define home-config
  (home-environment
    (packages (specifications->packages
               (list "emacs"
		     "libreoffice"
                      "htop"
                      "neofetch"
		      "qbittorrent"
		      
    
		      "nsxiv"
		      "pavucontrol"
		      "mypaint"
		     "qpdfview"
                      "feh"
		      "flameshot"
		      "gcc"
		      "polybar"
		      "git"
                      "pasystray"
		      "font-google-noto-serif-cjk"
		      "font-wqy-microhei"
		      "font-jigmo"
		      "texlive-wadalab"
		      "texlive-pxufont"
		      "texlive-ipaex"
		      
                      ;; "i3blocks" ;; Se desejar, pode descomentar esta linha
                )))
    ;; Uncomment the shell you wish to use for your user:
    ;(service home-bash-service-type)
    ;(service home-fish-service-type)
    ;(service home-zsh-service-type)

    (services
     (list
       (service home-files-service-type
                `((".guile" ,%default-dotguile)
                  (".Xdefaults" ,%default-xdefaults)))

       (service home-xdg-configuration-files-service-type
                `(("gdb/gdbinit" ,%default-gdbinit)
                  ("nano/nanorc" ,%default-nanorc)))))))

home-config
