# Documentary

A simple tool that will allow you to generate API runnable documentation quickly.

> If you want them to RTFM, make a better FM.
>
> -- <cite>Kathy Sierra</cite>

## Todos

[X] Build the parser
[X] Integration Test
[X] Title Blocks
[ ] Ordering
[ ] Resource Blocks
[ ] Endpoint Blocks
[ ] Generation config
[ ] CLI design
[ ] TOC for documentation
[ ] Create testing suite

## Specification

Documentary works using good old fashioned docblocks. I believe documentation for APIs should live with the code they document. Creating a documentary docblock is as simple as

```
# --- documentary
# Docblock content in here
# --- end
```

The contents of a documentary docblock is YAML which will generate markdown documentation.

All docblocks take an order attribute. Without it documentary will build teh documentation as it finds it in the file hierarchy.

### Title Blocks

Title blocks are to provide important supplamentary information about the API. They are formed as follows:

```
# --- documentary
# type: title_block
# title: The Heading for the Title Block
# content: >
#   Here is the example content, using the YAML escaping character '>'.
# --- end
```
