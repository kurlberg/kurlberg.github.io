(function (js, css) {
  if (window.frameElement) {
    return;
  }
  var cr = (t) => document.createElement(t),
    ap = (n) => document.head.appendChild(n);

  // Create "<div id='kpm-6cf53' class='kth-kpm'>"
  let root = document.querySelector(".kth-kpm");

  if (!root) {
    root = cr("div");
    document.body.style.setProperty("--kpm-bar-height", "2.5rem");
    document.body.prepend(root);
    document.body.classList.add("use-personal-menu");
  }

  root.classList.remove("kth-kpm");
  root.style.position = "fixed";
  root.id = "kpm-6cf53";
  let sc = cr("script");
  sc.defer = true;
  sc.src = js;
  ap(sc);
  let st = cr("link");
  st.rel = "stylesheet";
  st.href = css;
  ap(st);

  // NOTE: This global variable is read in kpm-backend/src/panes/utils.ts
  window.__kpmPublicUriBase__ = "https://app.kth.se/kpm";
  // Inject some user data to allow rendering the menu properly.
  window.__kpmCurrentUser__ = {"kthid":"u1ufnfxc","display_name":"Pär","email":"kurlberg@kth.se","username":"kurlberg","hasEduCourses":true,"hasLadokCourses":true,"expires":1774281825590,"staff":true,"student":false,"numNewNotifications":0};
  window.__kpmSettings__ = {"lang":"sv"};
})("https://app.kth.se/kpm/assets/index.b11eec61.js", "https://app.kth.se/kpm/assets/index.0265186b.css");
