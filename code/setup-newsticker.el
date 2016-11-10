;; -*- lexical-binding: t -*-

(require 'newsticker)

(setf newsticker-url-list
      '(("Emacs Wiki" "http://www.emacswiki.org/cgi-bin/wiki.pl?action=rss" nil
         3600)
        ("Endless parentheses" "http://endlessparentheses.com/atom.xml")
        ("(or Emacs" "http://oremacs.com/atom.xml")
        ("Emacs Redux" "http://emacsredux.com/atom.xml")
        ("bitsuppe" "http://bitstacker.soup.io/rss")
        ("Copenhagenize.com - Bicycle Culture by Design"
         "http://www.copenhagenize.com/feeds/posts/default")
        ("Der postillion" "https://feeds.feedburner.com/blogspot/rkEL")
        ("Eine Zeitung" "https://www.eine-zeitung.net/feed/")
        ("german-bash.org" "https://feeds2.feedburner.com/gbo-zitate")
        ("ibash.de" "http://ibash.de/neueste-zitate.xml")
        ("It started with a fight" "http://itstartedwithafight.de/feed/")
        ("Irreal" "http://irreal.org/blog/?feed=rss2")
        ("heise developer" "https://www.heise.de/developer/rss/news-atom.xml")
        ("heise netze" "https://www.heise.de/netze/rss/netze-atom.xml")
        ("heise security" "https://www.heise.de/security/news/news-atom.xml")
        ("Telepolis" "https://www.heise.de/tp/news-atom.xml")
        ("CRE: Technik, Kultur, Gesellschaft" "http://cre.fm/feed/opus/")
        ("xkcd.com" "https://xkcd.com/rss.xml")
        ("tagesschau.de - Die Nachrichten der ARD"
         "https://www.tagesschau.de/xml/rss2")
        ("wingolog" "https://wingolog.org/feed/atom")
        ("Howardism" "http://howardism.org/index.xml")))

(provide 'setup-newsticker)
