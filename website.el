(require 'org)

(setq
 org-publish-project-alist
 '(("home"
    :base-directory "src"
    :base-extension "org"
    :publishing-directory "public"
    :recursive nil
    :publishing-function org-html-publish-to-html)

   ("static"
    :base-directory "src"
    :base-extension "css\\|js\\|png\\|svg"
    :publishing-directory "public"
    :publishing-function org-publish-attachment
    :recursive t)

   ("blog"
    :base-directory "src/blog"
    :base-extension "org"
    :publishing-directory "public/blog"
    :recursive t
    :publishing-function org-html-publish-to-html

    :section-numbers nil
    :with-creator t
    :with-date t
    :with-toc nil

    :html-head nil
    :html-head-include-default-style nil
    :html-head-extra "<link rel='stylesheet' href='../static/index.css' />"
    :html-doctype "html5"

    :auto-sitemap t
    :sitemap-title "keshab paudel's blog"
    :sitemap-filename "index.org"
    :sitemap-style list
    :sitemap-sort-files anti-chronologically
    )

   ("website"
    :components ("blog" "home" "static"))
   ))
