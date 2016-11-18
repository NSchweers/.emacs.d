;; -*- lexical-binding: t -*-

(pc elfeed
  (:post-install
   (setf elfeed-feeds
         '(("http://endlessparentheses.com/atom.xml" endlessparentheses blog emacs)
           ("http://oremacs.com/atom.xml" oremacs blog emacs)
           ("http://emacsredux.com/atom.xml" emacsredux blog emacs)
           ("http://bitstacker.soup.io/rss" bitstacker)
           ("http://www.copenhagenize.com/feeds/posts/default" copenhagenize)
           ("https://feeds.feedburner.com/blogspot/rkEL" der-postillon)
           ("https://www.eine-zeitung.net/feed/" eine-zeitung)
           ("https://feeds2.feedburner.com/gbo-zitate" gbo)
           ("http://ibash.de/neueste-zitate.xml" ibash)
           ("http://itstartedwithafight.de/feed/" itstartedwithafight blog)
           ("http://irreal.org/blog/?feed=rss2" irreal blog emacs)
           ("https://www.heise.de/developer/rss/news-atom.xml" heise-developer
            heise)
           ("https://www.heise.de/netze/rss/netze-atom.xml" heise-netze heise)
           ("https://www.heise.de/security/news/news-atom.xml" heise-security
            heise)
           ("https://www.heise.de/tp/news-atom.xml" telepolis heise)
           ("http://cre.fm/feed/opus/" cre podcast)
           ("https://xkcd.com/rss.xml" xkcd webcomic)
           ("https://www.tagesschau.de/xml/rss2" tagesschau news)
           ("https://wingolog.org/feed/atom" wingolog blog)
           ("http://howardism.org/index.xml" howardism blog emacs)
           ("http://nullprogram.com/feed/" nullprogram blog emacs)))))

(provide 'setup-elfeed)
