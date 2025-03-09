(define-module (esp32)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages)
  #:use-module (gnu packages cross-base)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages embedded)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages bash)
  #:use-module ((guix licenses) #:prefix license:)) ; Adicionado módulo de licenças

(define-public xtensa-esp32-elf-gcc
  (package
    (name "xtensa-esp32-elf-gcc")
    (version "12.2.0")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/espressif/crosstool-NG/releases/download/xtensa-esp32-elf-gcc-" version "/xtensa-esp32-elf-gcc" version "-linux-x86_64.tar.gz"))
              (sha256 (base32 "1zrhca90c7hqnjz3jgr1vl675q3h5lrd92b5ggi00jjryffcyjg5"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let ((source (assoc-ref %build-inputs "source")))
           (invoke "tar" "xvf" source)
           (mkdir-p (string-append %output "/bin"))
           (for-each (lambda (file)
                       (copy-file file (string-append %output "/bin/" (basename file))))
                     (find-files "." "xtensa-esp32-elf-.*"))))))
    (native-search-paths
     (list (search-path-specification
            (variable "PATH")
            (files (list "bin"))))
    (synopsis "GCC for the Xtensa ESP32 architecture")
    (description "This package provides the GCC compiler for the Xtensa ESP32 architecture.")
    (home-page "https://github.com/espressif/crosstool-NG")
    (license license:gpl3+))) ; Agora license:gpl3+ está disponível

(define-public esp32-toolchain
  (package
    (name "esp32-toolchain")
    (version "1.0")
    (source #f)
    (build-system trivial-build-system)
    (arguments
     `(#:builder (begin
                   (mkdir %output))))
    (propagated-inputs
     `(("xtensa-esp32-elf-gcc" ,xtensa-esp32-elf-gcc)))
    (synopsis "Toolchain for ESP32 development")
    (description "This package provides the GCC for the Xtensa ESP32 architecture.")
    (home-page "https://github.com/espressif/crosstool-NG")
    (license license:gpl3+))) ; Agora license:gpl3+ está disponível
