package hxentrails.descriptors;

#if macro

import haxe.macro.Type;
import haxe.macro.Expr;

import hxentrails.common.BinaryFilter;
import hxentrails.descriptions.ClassDescription;

class ClassDescriptor extends FieldsDescriptor<ClassType> {

    public function new(typeExpr:Expr, filter:BinaryFilter, useCache:Bool) {
        super(typeExpr, filter, ClassDescription, useCache);
    }

    // TODO: implement
    override function parseType() {
        super.parseType();

        addRangeToInitializeBlock([
            //
        ]);

    }

    override function getFields():Array<ClassField> {
        try {
            return _type.fields.get();
        } catch (e:Dynamic) {
            throw e;
        }
    }

}

#end
