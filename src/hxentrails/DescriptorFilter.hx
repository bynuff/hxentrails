package hxentrails;

@:forward
abstract DescriptorFilter(Int) from Int to Int {

    inline public function new() {
        this = 0;
    }

    @:op(A += B)
    inline public function add(flags:Array<DescriptorFlag>) {
        for (flag in flags) {
            this |= flag;
        }
    }

    @:op(A -= B)
    inline public function remove(flags:Array<DescriptorFlag>) {
        for (flag in flags) {
            this &= flag;
        }
    }

    @:op(A == B)
    inline public function contains(mode:DescriptorFlag):Bool {
        return (this & mode) == mode;
    }

}
