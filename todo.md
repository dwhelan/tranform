## General
* do safe to_atom/1 calls
* support func transforms
* support module transforms
* support inherited transforms?
* use field strings as well as atoms
* support transforms that don't take args
    * field :x, :downcase, :upcase
    * field :y, date: "YYYY", string: "YY", lowercase :_
* handle errors - always return tuples
* remove need for primitive? call
* refactor tranform/2 functions to Ecto casting (will enable auto transformations to/from databases)
* documentation
    * process/app config for locale
    * available locales see Timex/priv/translations
    * document built-in transformations
    * write guides for the transformations?
* consider lossy conversions as errors?

## Numbers
* support format/parse options
* handle decimal errors - will error when there is a loss of precision

## Dates & Times
* support timezones (already handled I think - add tests)
    * provide timezone when converting to DateTime

## Maps & Structs 
* remove custom struct and map modules? have them recurse? 

## Locale 
* error handling 
    * nothing entered 
    * string is not a valid locale 
    * field is not in the struct being transformed 
    * keys in locale map are not valid fields 
    * values in locale map are not valid locales 
    * field value is not a valid locale 
    * perhaps default to "en" on error (configurable) 
