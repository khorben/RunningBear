PREFIX	= /usr/local
DESTDIR	= 
RM	= rm -f
MKDIR	= mkdir -m 755 -p
INSTALL	= install
INCLUDEDIR= $(PREFIX)/include


all:

clean:

distclean: clean

install: all
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 appclient.h $(DESTDIR)$(INCLUDEDIR)/System/appclient.h
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 appserver.h $(DESTDIR)$(INCLUDEDIR)/System/appserver.h
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 array.h $(DESTDIR)$(INCLUDEDIR)/System/array.h
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 buffer.h $(DESTDIR)$(INCLUDEDIR)/System/buffer.h
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 config.h $(DESTDIR)$(INCLUDEDIR)/System/config.h
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 error.h $(DESTDIR)$(INCLUDEDIR)/System/error.h
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 event.h $(DESTDIR)$(INCLUDEDIR)/System/event.h
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 file.h $(DESTDIR)$(INCLUDEDIR)/System/file.h
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 hash.h $(DESTDIR)$(INCLUDEDIR)/System/hash.h
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 object.h $(DESTDIR)$(INCLUDEDIR)/System/object.h
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 parser.h $(DESTDIR)$(INCLUDEDIR)/System/parser.h
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 plugin.h $(DESTDIR)$(INCLUDEDIR)/System/plugin.h
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 string.h $(DESTDIR)$(INCLUDEDIR)/System/string.h
	$(MKDIR) $(DESTDIR)$(INCLUDEDIR)/System
	$(INSTALL) -m 0644 token.h $(DESTDIR)$(INCLUDEDIR)/System/token.h

uninstall:
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/appclient.h
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/appserver.h
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/array.h
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/buffer.h
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/config.h
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/error.h
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/event.h
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/file.h
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/hash.h
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/object.h
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/parser.h
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/plugin.h
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/string.h
	$(RM) $(DESTDIR)$(INCLUDEDIR)/System/token.h

.PHONY: all clean distclean install uninstall
