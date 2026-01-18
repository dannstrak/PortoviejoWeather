(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'htmlize)
  (package-install 'htmlize))

(require 'ox-publish)

;; Forzar la ruta base al directorio del script
(setq default-directory (file-name-directory (or load-file-name default-directory)))

;; PERSONALIZACIÓN: 
(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-head "
<style>
  @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono&family=Inter:wght@400;700;900&display=swap');

  /* CONFIGURACIÓN DE PÁGINA Y ESTRUCTURA */
  body {
    background-color: #000000;
    color: #ffffff;
    font-family: 'Inter', sans-serif;
    margin: 0;
    line-height: 1.6;
  }

  /* SIDEBAR IZQUIERDO (ÍNDICE) */
  #table-of-contents {
    width: 280px;
    height: 100vh;
    position: fixed;
    left: 0;
    top: 0;
    background: #050505;
    border-right: 1px solid #1a1a1a;
    padding: 40px 20px;
    overflow-y: auto;
    z-index: 100;
  }

  #table-of-contents h2 {
    font-size: 0.8em;
    text-transform: uppercase;
    letter-spacing: 3px;
    color: #444;
    margin-bottom: 20px;
    border: none;
  }

  #table-of-contents ul { list-style: none; padding: 0; }
  #table-of-contents li { margin: 15px 0; }
  
  #table-of-contents a {
    color: #666;
    text-decoration: none;
    font-size: 0.9em;
    transition: all 0.3s ease;
    display: block;
  }

  #table-of-contents a:hover {
    color: #ffffff;
    padding-left: 10px;
    text-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
  }

  /* CONTENIDO PRINCIPAL */
  #content {
    margin-left: 320px; 
    padding: 60px 40px;
    max-width: 900px;
    display: block; /* Asegura que el flujo sea vertical */
  }

  /* TÍTULOS */
  h1, h2, h3 {
    font-weight: 900;
    text-transform: uppercase;
    letter-spacing: 4px;
    border-bottom: 1px solid #111;
    padding-bottom: 10px;
    margin-top: 60px;
  }

  /* CÓDIGO CON GLOW BLANCO */
  pre.src, pre.example {
    background-color: #000000 !important;
    font-family: 'JetBrains Mono', monospace;
    border: 1px solid #222;
    border-radius: 12px;
    padding: 30px;
    margin: 30px 0;
    transition: all 0.5s cubic-bezier(0.23, 1, 0.32, 1);
  }

  pre.src:hover, pre.example:hover {
    border-color: #ffffff;
    box-shadow: 0 0 80px 20px rgba(255, 255, 255, 0.25);
    transform: translateY(-5px);
  }

  /* TABLAS */
  table {
    width: 100%;
    border-collapse: separate;
    margin: 40px 0;
    border: 1px solid #222;
    border-radius: 15px;
    overflow: hidden;
  }

  th {
    background-color: #ffffff;
    color: #000;
    padding: 18px;
    font-size: 0.7em;
    text-transform: uppercase;
    letter-spacing: 2px;
  }

  td { padding: 15px; border-bottom: 1px solid #111; color: #666; }

  /* IMÁGENES CON GLOW ROJO */
  img {
    width: 100%;
    border-radius: 20px;
    border: 1px solid #222;
    margin: 40px 0;
    transition: all 0.6s cubic-bezier(0.23, 1, 0.32, 1);
  }

  img:hover {
    border-color: #ff0000;
    box-shadow: 0 0 100px 30px rgba(255, 0, 0, 0.45);
    transform: scale(1.03) rotate(0.5deg);
  }

  /* PIE DE PÁGINA AL FINAL */
  #postamble {
    margin-left: 320px; /* Alineado con el contenido */
    margin-top: 50px;
    padding: 40px;
    border-top: 1px solid #111;
    text-align: center;
    color: #444;
    text-transform: uppercase;
    font-size: 0.7em;
    clear: both;
    display: block;
  }

  /* SCROLLBAR BLANCO */
  ::-webkit-scrollbar { width: 5px; }
  ::-webkit-scrollbar-track { background: #000; }
  ::-webkit-scrollbar-thumb { background: #444; border-radius: 10px; }
  ::-webkit-scrollbar-thumb:hover { background: #ffffff; box-shadow: 0 0 10px #ffffff; }

</style>")

;; --- DEFINICIÓN DEL PROYECTO ---
(setq org-publish-project-alist
      (list
       (list "weather-site"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author t
             :with-creator t
             :with-toc t
             :section-numbers nil
             :time-stamp-file nil)))

(setq org-publish-use-timestamps-flag nil)
(org-publish-all t)

(message "--- GENERACIÓN COMPLETADA  ---")