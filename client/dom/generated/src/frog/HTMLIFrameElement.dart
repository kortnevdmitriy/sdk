// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class _HTMLIFrameElementJs extends _HTMLElementJs implements HTMLIFrameElement native "*HTMLIFrameElement" {

  String align;

  String frameBorder;

  String height;

  String longDesc;

  String marginHeight;

  String marginWidth;

  String name;

  String sandbox;

  String scrolling;

  String src;

  String width;

  _SVGDocumentJs getSVGDocument() native;


  Window get _contentWindow() native "return this.contentWindow;";

  // Override contentWindow to return secure wrapper.
  Window get contentWindow() {
    return _DOMWindowCrossFrameImpl._createSafe(_contentWindow);
  }
}

// TODO(vsm): Unify with Dartium version.
class _DOMWindowCrossFrameImpl implements DOMType, DOMWindow {
  // Private window.
  _DOMWindowJs _window;

  // DOMType
  var dartObjectLocalStorage;
  String get typeName() => "DOMWindow";

  // Fields.
  // TODO(vsm): Wrap these two.
  History get history() => _window.history;
  Location get location() => _window.location;

  bool get closed() => _window.closed;
  int get length() => _window.length;
  DOMWindow get opener() => _createDOMWindowCrossFrame(_window.opener);
  DOMWindow get parent() => _createDOMWindowCrossFrame(_window.parent);
  DOMWindow get top() => _createDOMWindowCrossFrame(_window.top);

  // Methods.
  void focus() {
    _window.focus();
  }

  void blur() {
    _window.blur();
  }

  void close() {
    _window.close();
  }

  void postMessage(Dynamic message,
                   String targetOrigin,
                   [List messagePorts = null]) {
    if (messagePorts == null) {
      _window.postMessage(message, targetOrigin);
    } else {
      _window.postMessage(message, targetOrigin, messagePorts);
    }
  }

  // Implementation support.
  _DOMWindowCrossFrameImpl(this._window);

  static DOMWindow _createSafe(w) {
    // TODO(vsm): Check if it's the top-level window.  Return unwrapped.

    // TODO(vsm): Cache or implement equality.
    return new _DOMWindowCrossFrameImpl(w);
  }
}
