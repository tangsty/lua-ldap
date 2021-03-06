T= lua_ldap
V= 1.0.0
CONFIG= ./config

include $(CONFIG)

ifeq "$(LUA_VERSION_NUM)" "500"
COMPAT_O= $(COMPAT_DIR)/compat-5.1.o
endif

OBJS= src/lua_ldap.o $(COMPAT_O)

src/$(LIBNAME): $(OBJS)
	export MACOSX_DEPLOYMENT_TARGET="10.4.0"; $(CC) $(CFLAGS) $(LIB_OPTION) -o src/$(LIBNAME) $(OBJS)

$(COMPAT_DIR)/compat-5.1.o: $(COMPAT_DIR)/compat-5.1.c
	$(CC) -c $(CFLAGS) -o $@ $(COMPAT_DIR)/compat-5.1.c

install: src/$(LIBNAME)
	mkdir -p $(DESTDIR)$(LUA_LIBDIR)
	cp src/$(LIBNAME) $(DESTDIR)$(LUA_LIBDIR)
	cd $(DESTDIR)$(LUA_LIBDIR); ln -f -s $(LIBNAME) $T.so

clean:
	rm -f $(OBJS) src/$(LIBNAME)
