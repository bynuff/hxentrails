package hxentrails.descriptors;

#if macro

import haxe.macro.Type;
import haxe.macro.Expr;

import hxentrails.common.BinaryFilter;
import hxentrails.descriptions.ClassDescription;

using hxentrails.utils.DescriptorExtensions;

class ClassDescriptor extends FieldDescriptor<ClassType> {

    public function new(typeExpr:Expr, filter:BinaryFilter, useCache:Bool) {
        // TODO: remove cast
        super(cast typeExpr.getBaseType(), typeExpr, filter, ClassDescription, useCache);
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
