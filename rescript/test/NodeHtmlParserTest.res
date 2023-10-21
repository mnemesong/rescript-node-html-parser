open RescriptMocha
open NodeHtmlParser
open Mocha
open Belt

describe("test HtmlElement", () => {
  describe("test removeWhitespace", () => {
    it(
      "test 1",
      () => {
        let given = parse(`   <div> dsak0d</div>   `)
        let result = HtmlElement.removeWhitespace(given)->HtmlElement.toString
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
  })
})
