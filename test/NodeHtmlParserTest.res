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
        let result = removeWhitespaceMut(given)->toString
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
          ->querySelectorAll("div")
          ->Result.map(r => r->Array.map(r => r->toString))
          ->Result.getExn
        let nominal = [`<div> dsak0d</div>`, `<div>d09asm0mds0</div>`]
        Assert.deep_equal(nominal, result)
      },
    )

    it(
      "test 2",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result = given->querySelectorAll("!das?")
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
          given->querySelector("div")->Result.map(r => r->Option.getExn->toString)->Result.getExn
        let nominal = `<div> dsak0d</div>`
        Assert.equal(nominal, result)
      },
    )

    it(
      "test 2",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result = given->querySelector("a")->Result.getExn
        let nominal = None
        Assert.equal(nominal, result)
      },
    )

    it(
      "test 3",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result = given->querySelector("!das?")
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
          ->querySelectorAll("div")
          ->Result.map(r => r->Array.map(r => r->toString))
          ->Result.getExn
        let nominal = [`<div> dsak0d</div>`, `<div>d09asm0mds0</div>`]
        Assert.deep_equal(nominal, result)
      },
    )

    it(
      "test 2",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result = given->getElementsByTagName("")
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
        let given = root->querySelector("a")->Result.getExn->Option.getExn
        let result = given->closest("body")->Result.getExn->Option.getExn->toString
        let nominal = `<body>   <div> dsak0d</div> <div>d09asm0mds0<a>Hello</a></div>  </body>`
        Assert.equal(nominal, result)
      },
    )

    it(
      "test 2",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result = given->querySelector("a")->Result.getExn
        let nominal = None
        Assert.equal(nominal, result)
      },
    )

    it(
      "test 3",
      () => {
        let given = parse(`   <div> dsak0d</div> <div>d09asm0mds0</div>  `)
        let result = given->querySelector("!das?")
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
          given->insertAdjacentHtmlMut(#afterbegin, `<b>sadas</b>`)->Result.getExn->toString
        let nominal = `<b>sadas</b> <div> <div>  8hsad</div><div>mda0s</div> </div>`
        Assert.equal(nominal, result)
      },
    )
  })

  describe("test setAttributesMut", () => {
    it(
      "test 1",
      () => {
        let given = parse(` <div> <div>  8hsad</div><div>mda0s</div> </div>`)
        let result =
          given
          ->querySelector("div")
          ->Result.getExn
          ->Option.getExn
          ->setAttributesMut([("a1", "v1"), ("a2", "val2")])
          ->toString
        let nominal = `<div a1="v1" a2="val2"> <div>  8hsad</div><div>mda0s</div> </div>`
        Assert.equal(nominal, result)
      },
    )
  })

  describe("test replaceWithMut", () => {
    it(
      "test 1",
      () => {
        let given = parse(` <div> <div id="idEl">  8hsad</div><div>mda0s</div> </div>`)
        let proc =
          given
          ->querySelector("#idEl")
          ->Result.getExn
          ->Option.getExn
          ->replaceWithMut("<a>Hello</a>")
        let result = given->toString
        let nominal = ` <div> <a>Hello</a><div>mda0s</div> </div>`
        Assert.equal(nominal, result)
      },
    )
  })

  describe("test removeMut", () => {
    it(
      "test 1",
      () => {
        let given = parse(` <div> <div id="idEl">  8hsad</div><div>mda0s</div> </div>`)
        let proc = given->querySelector("#idEl")->Result.getExn->Option.getExn->removeMut
        let result = given->toString
        let nominal = ` <div> <div>mda0s</div> </div>`
        Assert.equal(nominal, result)
      },
    )
  })
})
