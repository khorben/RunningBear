SUBDIRS	= System
PREFIX	= /usr/local
DESTDIR	= 
RM	= rm -f
MKDIR	= mkdir -m 755 -p
INSTALL	= install
INCLUDEDIR= $(PREFIX)/include


all: subdirs

subdirs:
	@for i in $(SUBDIRS); do (cd $$i && $(MAKE)) || exit; done

clean:
	@for i in $(SUBDIRS); do (cd $$i && $(MAKE) clean) || exit; done

distclean:
	@for i in $(SUBDIRS); do (cd $$i && $(MAKE) distclean) || exit; done

install: all
	@for i in $(SUBDIRS); do (cd $$i && $(MAKE) install) || exit; done
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)
	$(INSTALL) -m 0644 System.h $(DESTDIR)$(INCLUDEDIR)/System.h

uninstall:
	@for i in $(SUBDIRS); do (cd $$i && $(MAKE) uninstall) || exit; done
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System.h

.PHONY: all subdirs clean distclean install uninstall
