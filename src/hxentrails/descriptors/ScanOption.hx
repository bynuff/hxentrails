package hxentrails.descriptors;

#if macro

@:enum
abstract ScanOption(Int) from Int to Int {

    var Constructor:Int = 1 << 0;
    var Variables:Int = 1 << 1;
    var Properties:Int = 1 << 2;
    var Implementations:Int = 1 << 3;
    var Functions:Int = 1 << 4;
    var Meta:Int = 1 << 5;

    public static var All:Int =
        Constructor | Variables | Properties
        | Implementations | Functions
        | Meta;

}

#end
