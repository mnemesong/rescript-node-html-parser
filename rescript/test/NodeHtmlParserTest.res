open RescriptMocha
open NodeHtmlParser
open Mocha
open Belt

describe("test HtmlElement", () => {
  describe("test removeWhitespaceMut", () => {
    it(
      "test 1",
      () => {
        let given = parse(`   <div> dsak0d</div>   `)
        let result = HtmlElement.removeWhitespaceMut(given)->HtmlElement.toString
        let nominal = `<div> dsak0d</div>`
        Assert.equal(nominal, result)
      },
    )
  })

  describe("test quarySelectorAll", () => {
    it(
      "test 1",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result =
          given
          ->HtmlElement.querySelectorAll("div")
          ->Result.map(r => r->Array.map(r => r->HtmlElement.toString))
          ->Result.getExn
        let nominal = [`<div> dsak0d</div>`, `<div>d09asm0mds0</div>`]
        Assert.deep_equal(nominal, result)
      },
    )

    it(
      "test 2",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result = given->HtmlElement.querySelectorAll("!das?")
        let nominal = Error("Unmatched selector: ?")
        Assert.deep_equal(nominal, result)
      },
    )
  })

  describe("test quarySelector", () => {
    it(
      "test 1",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result =
          given
          ->HtmlElement.querySelector("div")
          ->Result.map(r => r->Option.getExn->HtmlElement.toString)
          ->Result.getExn
        let nominal = `<div> dsak0d</div>`
        Assert.equal(nominal, result)
      },
    )

    it(
      "test 2",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result = given->HtmlElement.querySelector("a")->Result.getExn
        let nominal = None
        Assert.equal(nominal, result)
      },
    )

    it(
      "test 3",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result = given->HtmlElement.querySelector("!das?")
        let nominal = Error("Unmatched selector: ?")
        Assert.deep_equal(nominal, result)
      },
    )
  })

  describe("test getElementsByTagName", () => {
    it(
      "test 1",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result =
          given
          ->HtmlElement.querySelectorAll("div")
          ->Result.map(r => r->Array.map(r => r->HtmlElement.toString))
          ->Result.getExn
        let nominal = [`<div> dsak0d</div>`, `<div>d09asm0mds0</div>`]
        Assert.deep_equal(nominal, result)
      },
    )

    it(
      "test 2",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result = given->HtmlElement.getElementsByTagName("")
        let nominal = []
        Assert.deep_equal(nominal, result)
      },
    )
  })

  describe("test closest", () => {
    it(
      "test 1",
      () => {
        let root = parse(`<body>   <div> dsak0d</div> <div>d09asm0mds0<a>Hello</a></div>  </body>`)
        let given = root->HtmlElement.querySelector("a")->Result.getExn->Option.getExn
        let result =
          given->HtmlElement.closest("body")->Result.getExn->Option.getExn->HtmlElement.toString
        let nominal = `<body>   <div> dsak0d</div> <div>d09asm0mds0<a>Hello</a></div>  </body>`
        Assert.equal(nominal, result)
      },
    )

    it(
      "test 2",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result = given->HtmlElement.querySelector("a")->Result.getExn
        let nominal = None
        Assert.equal(nominal, result)
      },
    )

    it(
      "test 3",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result = given->HtmlElement.querySelector("!das?")
        let nominal = Error("Unmatched selector: ?")
        Assert.deep_equal(nominal, result)
      },
    )
  })

  describe("test insertAdjacentHtmlMut", () => {
    it(
      "test 1",
      () => {
        let given = parse(` <div> <div>  8hsad</div><div>mda0s</div> </div>`)
        let result =
          given
          ->HtmlElement.insertAdjacentHtmlMut(#afterbegin, `<b>sadas</b>`)
          ->Result.getExn
          ->HtmlElement.toString
        let nominal = `<b>sadas</b> <div> <div>  8hsad</div><div>mda0s</div> </div>`
        Assert.equal(nominal, result)
      },
    )
  })
})
