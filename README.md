# suuid

short uuid. convert uuid into base 64 string, with following characters:

`
   123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-_
`

In other words, `[1-9a-zA-Z+-_]`.
  


## Usage

    <script src="<path-to>/suuid.bundle.min.js"></script>
    <script>
      var id = suuid();
    </script>
