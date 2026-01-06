pragma Singleton

import QtQuick
import Quickshell

Singleton {
  id: root

  signal showCustomText(string text, string icon)
}
