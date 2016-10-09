package hxentrails.descriptions;

import hxentrails.descriptions.TypeInfo.TypeKind;

class BaseDescription {

    public var typeInfo(default, null):TypeInfo;

    public function new(typeKind:TypeKind) {
        typeInfo = new TypeInfo();
        @:privateAccess typeInfo.kind = typeKind;
    }

}
