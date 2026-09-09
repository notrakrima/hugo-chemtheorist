---
title: "CTK-DB hosting test"
date: 2026-09-10T12:00:00+10:00
draft: false
description: "Temporary page checking that the site can serve a dashboard page with data files beside it."
---

### CTK-DB hosting test

This page checks that the site can serve a page that loads data files from its own folder,
which is how the CTK-DB dashboard will work. Three checks run automatically:

<ul id="ctk-log" style="font-family: monospace;"></ul>

<p>If all three lines are green, the site can host the dashboard as designed.</p>

<script type="text/javascript">
(function () {
  var log = function (msg, ok) {
    var li = document.createElement('li');
    li.style.color = ok ? '#087a2f' : '#b3261e';
    li.textContent = (ok ? 'OK   ' : 'FAIL ') + msg;
    document.getElementById('ctk-log').appendChild(li);
  };
  (async function () {
    try {                                                   // 1. small JSON in the page folder
      var t0 = performance.now();
      var r = await fetch('test.json'); var j = await r.json();
      log('test.json fetched (' + j.message + ') in ' + (performance.now() - t0).toFixed(0) + ' ms', r.ok && !!j.message);
    } catch (e) { log('test.json: ' + e, false); }
    try {                                                   // 2. 5 MB binary file, like the future data files
      var t1 = performance.now();
      var r2 = await fetch('blob.bin'); var b = await r2.arrayBuffer();
      var view = new Int32Array(b, 0, 4);
      log('blob.bin fetched: ' + (b.byteLength / 1e6).toFixed(1) + ' MB in ' + (performance.now() - t1).toFixed(0) +
          ' ms, first values ' + Array.prototype.join.call(view, ',') + ' (expect 1,2,3,4), content-encoding: ' +
          (r2.headers.get('content-encoding') || 'none'),
          r2.ok && b.byteLength === 5000000 && view[0] === 1 && view[3] === 4);
    } catch (e) { log('blob.bin: ' + e, false); }
    try {                                                   // 3. a script library from the page folder
      await new Promise(function (res, rej) {
        var s = document.createElement('script'); s.src = 'lib.js';
        s.onload = res; s.onerror = function () { rej(new Error('script did not load')); };
        document.head.appendChild(s);
      });
      log('lib.js loaded and ran: ' + window.CTKDB_LIB_OK, window.CTKDB_LIB_OK === 'yes');
    } catch (e) { log('lib.js: ' + e, false); }
  })();
})();
</script>
