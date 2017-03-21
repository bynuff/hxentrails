package hxentrails.descriptors;

#if macro

import haxe.macro.Type;
import haxe.macro.Expr;

import hxentrails.common.BinaryFilter;
import hxentrails.descriptions.BaseDescription;
import hxentrails.descriptions.ClassFieldDescription.ClassFieldAccess;

class ClassFieldDescriptor<T:BaseType> extends BaseDescriptor<T> {

    public function new(
        type:T,
        typeExpr:Expr,
        filter:BinaryFilter,
        descriptionBaseType:Class<BaseDescription>,
        useCache:Bool
    ) {
        super(type, typeExpr, filter, descriptionBaseType, useCache);
    }

    override function parseType() {
        super.parseType();

        addRangeToInitializeBlock([for (cf in getClassFields()) parseClassField(cf)]);
    }

    function parseClassField(field:ClassField):Expr {

        trace(field);

        return macro {
            var classField = {
                name: $v{field.name},
                type: null, // TODO
                isPublic: $v{field.isPublic},
                isOverride: false, // TODO
                readAccess: hxentrails.descriptions.ClassFieldDescription.ClassFieldAccess.Normal, // TODO
                writeAccess: hxentrails.descriptions.ClassFieldDescription.ClassFieldAccess.Normal, // TODO
                params: $v{getParams(field.params)},
                platforms: null, // TODO
                meta: [],
                line: 0, // TODO
                overloads: [], // TODO
                isFunction: false // TODO
            };
            $b{getMetadata(field.meta, macro classField.meta)};
            fields.push(classField);
        };
    }

    function getClassFields():Array<ClassField> {
        throw "Abstract method getClassFields at ClassFieldDescriptor must be implemented.";
    }

}

#end
