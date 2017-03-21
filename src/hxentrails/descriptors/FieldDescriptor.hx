package hxentrails.descriptors;

#if macro

import haxe.macro.Type;
import haxe.macro.Expr;

class FieldDescriptor<T:BaseType> extends BaseDescriptor<T> {

    override function parseType() {
        super.parseType();

        addRangeToInitializeBlock([for (cf in getFields()) parseClassField(cf)]);
    }

    function parseClassField(field:ClassField):Expr {

        trace(field);

        return macro {
            var fieldInfo = {
                name: $v{field.name},
                type: null, // TODO
                isPublic: $v{field.isPublic},
                isOverride: false, // TODO
                readAccess: hxentrails.descriptions.FieldAccess.Normal, // TODO
                writeAccess: hxentrails.descriptions.FieldAccess.Normal, // TODO
                params: $v{getParams(field.params)},
                platforms: null, // TODO
                meta: [],
                line: 0, // TODO
                overloads: [], // TODO
                isFunction: false // TODO
            };
            $b{getMetadata(field.meta, macro fieldInfo.meta)};
            fields.push(fieldInfo);
        };
    }

    function getFields():Array<ClassField> {
        throw "Abstract method getFields at FieldDescriptor must be implemented.";
    }

}

#end
