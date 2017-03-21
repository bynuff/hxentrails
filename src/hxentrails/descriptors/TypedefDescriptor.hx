package hxentrails.descriptors;

#if macro

import haxe.macro.Type;
import haxe.macro.Expr;

import hxentrails.common.BinaryFilter;
import hxentrails.descriptions.TypedefDescription;

using hxentrails.utils.DescriptorExtensions;

class TypedefDescriptor extends ClassFieldDescriptor<DefType> {

    public function new(typeExpr:Expr, filter:BinaryFilter, useCache:Bool) {
        // TODO: remove cast
        super(cast typeExpr.getBaseType(), typeExpr, filter, TypedefDescription, useCache);
    }

    override function getClassFields():Array<ClassField> {
        try {
            return switch (_type.type) {
                case TAnonymous(a):
                    a.get().fields;
                case _:
                    throw "Type has no fields.";
            }
        } catch (e:Dynamic) {
            throw e;
        }
    }

}

#end
