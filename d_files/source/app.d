import node_dlang;
import std.typecons;
extern (C):

// Global so that we can use a function pointer instead of delegate.
// Delegates are supported but need to be sent as delegate *, this is easier.
JSVar electron;

void setup (napi_env env) {
  electron = env.global (`process`) [`mainModule`].require (`electron`);
  electron [`app`].whenReady ().then (() {
    auto win = electron [`BrowserWindow`]
      .constructor (tuple!
        (`width`, `height`, `backgroundColor`)
        (800, 600, `#cce7e8`)
      );
    win.loadFile (`index.html`);
    win.openDevTools ();
  });
}

mixin exportToJs! (
  MainFunction!setup
);
