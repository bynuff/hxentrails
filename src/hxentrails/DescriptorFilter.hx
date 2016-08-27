package hxentrails;

@:forward
abstract DescriptorFilter(Int) from Int to Int {

    inline public function new(?value:Null<Int>) {
        this = value != null ? value : 0;
    }

    @:op(A += B)
    inline public function add(flags:Array<Int>):DescriptorFilter {
        for (flag in flags) {
            this |= flag;
        }
        return this;
    }

    @:op(A -= B)
    inline public function remove(flags:Array<Int>):DescriptorFilter {
        for (flag in flags) {
            this &= flag;
        }
        return this;
    }

    @:op(A == B)
    inline public function contains(mode:Int):Bool {
        return (this & mode) == mode;
    }

}
