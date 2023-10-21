# rescript-node-html-parser
rescript api for node-html-parser package


## Api
```rescript
type htmlElement

type where = [
  | #beforebegin
  | #afterbegin
  | #beforeend
  | #afterend
]

let parse: string => htmlElement = ...

let trimRightMut: htmlElement => htmlElement = ...

let removeWhitespaceMut: htmlElement => htmlElement = ...

let querySelectorAll: (htmlElement, string): result<array<htmlElement>, string> = ...

let getElementsByTagName: (htmlElement, string) => array<htmlElement> = ...

let querySelector: (htmlElement, string) => result<option<htmlElement>, string> = ...

let closest: (htmlElement, string) => result<option<htmlElement>, string> = ...

let toString: htmlElement => string = ...

let insertAdjacentHtmlMut: (htmlElement, where, string) => result<htmlElement, string> = ...

let setAttributesMut: (htmlElement, array<(string, string)>) => htmlElement = ...

let replaceWithMut: (htmlElement, string) => htmlElement = ...

let removeMut: htmlElement => htmlElement = ...
```

## Author
Anatoly Starodubstev
tostar74@mail.ru

## License
MIT