# rescript-node-html-parser
rescript api for node-html-parser package


## Example of usage
```rescript
let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
let result =
  given->querySelector("div")->Result.map(r => r->Option.getExn->toString)->Result.getExn
let nominal = `<div> dsak0d</div>`
Assert.equal(nominal, result)
```


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