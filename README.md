# Documentary

A simple tool that will allow you to generate API runnable documentation quickly.

> If you want them to RTFM, make a better FM.
>
> -- <cite>Kathy Sierra</cite>

[Example of the documentation generated](https://gist.github.com/bangline/edeb0201b13b2721be3764f5fa0c76d5)

## Installation

```
gem install documentary
```

Or in your Gemfile:

```
gem 'documentary'
```

## Usage

Documentary ships with a command line runner

```
Usage: documentary [options]
    -v, --version                    Print version number
    -d, --directory glob             Set directory to search for docblocks
    -p, --project project            Set project name
    -o, --output output              Set the output file
```

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

### Resources

Resource blocks let you describe the domain of your API. They are formed as follows:

```
# --- documentary
# type: resource
# title: The Resource Name
# description: >
#   A description of the resource would go in here
# attributes:
#   - string_attribute:
#     required: true
#     type: string
# --- end
```

Attributes are formed using the attribute name as the key and specifing if they are required (validation present) and the type to be passed.

### Endpoints

Endpoint blocks specify the public endpoints of your API. They are formed as follows:

```
# --- documentary
# type: endpoint
# title: List users
# notes: >
#  This enpoint will list all the users.
# verb: GET
# endpoint: '/users'
# example_response:
#   page: 1
#   total_pages: 1
#   count: 1
#   users:
#     - id: 1
#       name: Testy McTesterson
#       email: test@email.com
# --- end
```

Of course not all enpoints are this simple, for `GET` requests especially you may wish to pass in extra parameters for things like pagination of filtering. This is accomplished using the `params` key. Parameters take on the structure of the param name, whether it is required and any notes (example below). Better still you can provide an example request using the `example_request` key.

```
# --- documentary
# type: endpoint
# title: List users
# verb: GET
# endpoint: '/users'
# params:
#   - page:
#     required: false
#     notes: >
#       The page desired from the set
#   - count:
#     required: false
#     notes: >
#       The number of results to return
#   - filter:
#     required: false
#     notes: >
#       The filter for a specific user to find for example: `filter=Testy`
# example_request: >
#   /users?filter=Testy&page=1&count=3
# example_response:
#   page: 1
#   total_pages: 1
#   count: 1
#   users:
#     - id: 1
#       name: Testy McTesterson
#       email: test@email.com
# --- end
```

There is a common practice on create and update (`POST` and `PUT`/`PATCH`) to return an empty response body and provide the `location` (the cannonical URL) in the response header. If no `example_response` is provided documentary will simply not generate documentation for it. We do suggest for clarity you mention this in the endpoint notes.

```
# --- documentary
# type: endpoint
# title: Create a user
# notes: >
#   The body of this response will be empty.
# information:
#   authenticated: true
#   response_formats: JSON, XML
# verb: POST
# endpoint: '/users'
# params:
#   - name:
#     required: true
#     notes: >
#       The name of the user
#   - email:
#     required: true
#     notes: >
#       The email of the user
# example_request: >
#   /users?name=Testy%20McTesterson&email=test%40email.com
# --- end
```
