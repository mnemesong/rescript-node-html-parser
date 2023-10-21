// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Js_exn = require("rescript/lib/js/js_exn.js");
var Caml_js_exceptions = require("rescript/lib/js/caml_js_exceptions.js");

const parser = require('node-html-parser');
;

var parse = (function (str) {
  return parser.parse(str);
});

var trimRight = (function (htmlEl) {
    return parser.parse(htmlEl.toString()).trimRight();
  });

var removeWhitespace = (function (htmlEl) {
    return parser.parse(htmlEl.toString()).removeWhitespace();
  });

function querySelectorAll(htmlElement, selector) {
  try {
    var qsa = (function (htmlEl, selector) {
        const res = htmlEl.querySelectorAll(selector);
        if(!Array.isArray(res)) {
          return [res];
        }
        return res;
      });
    return {
            TAG: /* Ok */0,
            _0: qsa(htmlElement, selector)
          };
  }
  catch (raw_e){
    var e = Caml_js_exceptions.internalToOCamlException(raw_e);
    if (e.RE_EXN_ID !== Js_exn.$$Error) {
      return {
              TAG: /* Error */1,
              _0: "Unknown error"
            };
    }
    var s = e._1.message;
    if (s !== undefined) {
      return {
              TAG: /* Error */1,
              _0: s
            };
    } else {
      return {
              TAG: /* Error */1,
              _0: ""
            };
    }
  }
}

function getElementsByTagName(htmlElement, selector) {
  var qsa = (function (htmlEl, selector) {
        const res = htmlEl.getElementsByTagName(selector);
        if(!Array.isArray(res)) {
          return [res];
        }
        return res;
      });
  return qsa(htmlElement, selector);
}

function querySelector(htmlElement, selector) {
  try {
    var qsa = (function (htmlEl, selector) {
        const res = htmlEl.querySelector(selector);
        return res;
      });
    return {
            TAG: /* Ok */0,
            _0: qsa(htmlElement, selector)
          };
  }
  catch (raw_e){
    var e = Caml_js_exceptions.internalToOCamlException(raw_e);
    if (e.RE_EXN_ID !== Js_exn.$$Error) {
      return {
              TAG: /* Error */1,
              _0: "Unknown error"
            };
    }
    var s = e._1.message;
    if (s !== undefined) {
      return {
              TAG: /* Error */1,
              _0: s
            };
    } else {
      return {
              TAG: /* Error */1,
              _0: ""
            };
    }
  }
}

var toString = (function(htmlEl) {
    return htmlEl.toString();
  });

var HtmlElement = {
  trimRight: trimRight,
  removeWhitespace: removeWhitespace,
  querySelectorAll: querySelectorAll,
  getElementsByTagName: getElementsByTagName,
  querySelector: querySelector,
  toString: toString
};

exports.parse = parse;
exports.HtmlElement = HtmlElement;
/*  Not a pure module */