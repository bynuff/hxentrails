package hxentrails.data;

class BaseDescription {

    public var id(default, null):String;
    public var filter(default, null):DescriptorFilter;

    public var typeName(default, null):String;

    public function new(typeName:String) {
        this.typeName = typeName;
    }

}
