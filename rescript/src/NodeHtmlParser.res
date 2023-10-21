%%raw(`
const parser = require('node-html-parser');
`)

type htmlElement

let parse: string => htmlElement = %raw(`
function (str) {
  return parser.parse(str);
}
`)

module HtmlElement = {
  let trimRight: htmlElement => htmlElement = %raw(`
  function (htmlEl) {
    return parser.parse(htmlEl.toString()).trimRight();
  }
  `)

  let removeWhitespace: htmlElement => htmlElement = %raw(`
  function (htmlEl) {
    return parser.parse(htmlEl.toString()).removeWhitespace();
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
}
