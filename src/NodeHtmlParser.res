%%raw(`
const parser = require('node-html-parser');
`)

type htmlElement

type where = [
  | #beforebegin
  | #afterbegin
  | #beforeend
  | #afterend
]

let parse: string => htmlElement = %raw(`
function (str) {
  return parser.parse(str);
}
`)

let trimRightMut: htmlElement => htmlElement = %raw(`
function (htmlEl) {
  return htmlEl.trimRight();
}
`)

let removeWhitespaceMut: htmlElement => htmlElement = %raw(`
function (htmlEl) {
  return htmlEl.removeWhitespace();
}
`)

let querySelectorAll = (htmlElement: htmlElement, selector: string): result<
  array<htmlElement>,
  string,
> =>
  try {
    let qsa: (htmlElement, string) => array<htmlElement> = %raw(`
    function (htmlEl, selector) {
      const res = htmlEl.querySelectorAll(selector);
      if(!Array.isArray(res)) {
        return [res];
      }
      return res;
    }
  `)
    Ok(qsa(htmlElement, selector))
  } catch {
  | Js.Exn.Error(e) =>
    switch Js.Exn.message(e) {
    | Some(s) => Error(s)
    | None => Error("")
    }
  | _ => Error("Unknown error")
  }

let getElementsByTagName = (htmlElement: htmlElement, selector: string): array<htmlElement> => {
  let qsa: (htmlElement, string) => array<htmlElement> = %raw(`
    function (htmlEl, selector) {
      const res = htmlEl.getElementsByTagName(selector);
      if(!Array.isArray(res)) {
        return [res];
      }
      return res;
    }
  `)
  qsa(htmlElement, selector)
}

let querySelector = (htmlElement: htmlElement, selector: string): result<
  option<htmlElement>,
  string,
> =>
  try {
    let qsa: (htmlElement, string) => option<htmlElement> = %raw(`
    function (htmlEl, selector) {
      const res = htmlEl.querySelector(selector);
      return res;
    }
  `)
    Ok(qsa(htmlElement, selector))
  } catch {
  | Js.Exn.Error(e) =>
    switch Js.Exn.message(e) {
    | Some(s) => Error(s)
    | None => Error("")
    }
  | _ => Error("Unknown error")
  }

let closest = (htmlElement: htmlElement, selector: string): result<option<htmlElement>, string> =>
  try {
    let qsa: (htmlElement, string) => option<htmlElement> = %raw(`
    function (htmlEl, selector) {
      const res = htmlEl.closest(selector);
      return res;
    }
  `)
    Ok(qsa(htmlElement, selector))
  } catch {
  | Js.Exn.Error(e) =>
    switch Js.Exn.message(e) {
    | Some(s) => Error(s)
    | None => Error("")
    }
  | _ => Error("Unknown error")
  }

let toString: htmlElement => string = %raw(`
function(htmlEl) {
  return htmlEl.toString();
}
`)

let insertAdjacentHtmlMut = (htmlElement: htmlElement, where: where, html: string): result<
  htmlElement,
  string,
> =>
  try {
    let res: (htmlElement, where, string) => htmlElement = %raw(`
    function (htmlEl, where, html) {
      return htmlEl.insertAdjacentHTML(where, html);
    }
    `)
    Ok(res(htmlElement, where, html))
  } catch {
  | Js.Exn.Error(e) =>
    switch Js.Exn.message(e) {
    | Some(s) => Error(s)
    | None => Error("")
    }
  | _ => Error("Unknown error")
  }

let setAttributesMut = (htmlElement: htmlElement, attrs: array<(string, string)>): htmlElement => {
  let buildAttrObj: array<(string, string)> => {..} = %raw(`
  function (attrs) {
    let res = {};
    attrs.forEach( a => {
      res[a[0]] = a[1];
    } );
    return res;
  }
  `)
  let setAttr: (htmlElement, {..}) => htmlElement = %raw(`
  function (htmlEl, attrs) {
    return htmlEl.setAttributes(attrs);
  }
  `)
  setAttr(htmlElement, buildAttrObj(attrs))
}

let replaceWithMut: (htmlElement, string) => htmlElement = %raw(`
function (htmlEl, strs) {
  return htmlEl.replaceWith(strs);
}
`)

let removeMut: htmlElement => htmlElement = %raw(`
function (htmlEl) {
  return htmlEl.remove();
}
`)

let outerHtml: htmlElement => string = %raw(`
function (htmlEl) {
  return htmlEl.outerHTML;
}
`)

let innerHtml: htmlElement => string = %raw(`
function (htmlEl) {
  return htmlEl.innerHTML;
}
`)

let tagName: htmlElement => string = %raw(`
function (htmlEl) {
  return htmlEl.tagName;
}
`)

let attributes: htmlElement => {..} = %raw(`
function (htmlEl) {
  return {...htmlEl.attributes};
}
`)