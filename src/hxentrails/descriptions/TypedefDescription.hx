package hxentrails.descriptions;

import hxentrails.descriptions.TypeInfo.TypeKind;

class TypedefDescription extends ClassFieldDescription {

    public function new() {
        super(TypeKind.TYPEDEF);
    }

}
