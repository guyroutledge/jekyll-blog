---
layout: post
title: "Sublime Text 2 package installer"
date: 2012-03-05
tags: Apps
categories: blog
---

Having heard a lot of good things about Sublime Text 2 I've started
using it exclusively as my code editor of choice.  For such a simple
looking app it is feature rich but one of the most powerful things about
it is the ability to install helper packages for everything from error
highlighting to making ASCII art. To enable package installing open the
command line by pressing Ctrl+' and paste this which I found
at http://wbond.net/ 

    import urllib2,os; pf='Package Control.sublime-package'; ipp=sublime.installed_packages_path(); os.makedirs(ipp) if not os.path.exists(ipp) else None; urllib2.install_opener(urllib2.build_opener(urllib2.ProxyHandler())); open(os.path.join(ipp,pf),'wb').write(urllib2.urlopen('http://sublime.wbond.net/'+pf.replace(' ','%20')).read()); print 'Please restart Sublime Text to finish installation' 
	
Restart and you're good to go. Press Cmd+Shift+P to bring up the command
pallet, type 'install', hit enter and browse the list of packages and
play to your heart's content. To remove installed packages Hit
Cmd+Shift+P, type 'remove', hit enter and chose the package to remove.

### Update

For the necessary snippet when using Sublime Text 3, you can grab it from the same URL as above. But here it is for reference

	import urllib.request,os; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); open(os.path.join(ipp, pf), 'wb').write(urllib.request.urlopen( 'http://sublime.wbond.net/' + pf.replace(' ','%20')).read())
