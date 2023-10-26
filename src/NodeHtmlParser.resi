type htmlElement

type where = [
  | #beforebegin
  | #afterbegin
  | #beforeend
  | #afterend
]

let parse: string => htmlElement

let trimRightMut: htmlElement => htmlElement

let removeWhitespaceMut: htmlElement => htmlElement

let querySelectorAll: (htmlElement, string) => result<array<htmlElement>, exn>

let getElementsByTagName: (htmlElement, string) => array<htmlElement>

let querySelector: (htmlElement, string) => result<option<htmlElement>, exn>

let closest: (htmlElement, string) => result<option<htmlElement>, exn>

let toString: htmlElement => string

let insertAdjacentHtmlMut: (htmlElement, where, string) => result<htmlElement, exn>

let setAttributesMut: (htmlElement, array<(string, string)>) => htmlElement

let replaceWithMut: (htmlElement, string) => htmlElement

let removeMut: htmlElement => htmlElement

let outerHtml: htmlElement => string

let innerHtml: htmlElement => string

let tagName: htmlElement => string

let attributes: htmlElement => {..}
