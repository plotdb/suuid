# suuid

short, sortable uuid. convert uuid into base 64 string along with coded timestamp.



## Usage

    <script src="<path-to>/suuid.bundle.min.js"></script>
    <script>
      var id = suuid();
      var ts = suuid.timestamp(id);
    </script>


## Spec

`suuid` does following things:

 - prefix uuid(v4) with epoch unix timestamp 
 - remove separator ( dash ) in uuid.
 - encodes values from hexadecimal to 64-based string with following charmap:

    123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0+-

while length of codes corresponding to uuid part are fixed, length of the timestamp code varys. The timestamp bits will be:

 - 7 bytes long before 2109AD
 - 8 bytes long before 10895AD
 - 9 bytes long before 573202AD

and the length of remaining part ( coded uuid, for randomness ) will be always 23 bytes long. thus, to sort suuid before 573202AD, simply add padding zeros before id to make it 32 bytes long.


## License

MIT
