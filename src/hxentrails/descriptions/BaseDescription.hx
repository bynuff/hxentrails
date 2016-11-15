package hxentrails.descriptions;

import hxentrails.descriptions.TypeInfo.TypeKind;

class BaseDescription extends TypeInfo {

    public function new(typeKind:TypeKind) {
        super();

        this.typeKind = typeKind;
    }

}
