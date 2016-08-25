package hxentrails.descriptors;

import hxentrails.data.BaseDescription;

interface IDescriptor<T:BaseDescription> {
    var result(default, null):T;
    function analyze():Void;
    function store():Void;
}
