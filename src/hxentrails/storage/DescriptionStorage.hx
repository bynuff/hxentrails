package hxentrails.storage;

import hxentrails.data.BaseDescription;

@:final
class DescriptionStorage {

    static var _descriptionStorage:Array<BaseDescription> = [];

    public static function tryGetOrCreate<T:BaseDescription>(
        resultType:Class<T>,
        id:String,
        filter:DescriptorFilter,
        activator:Void -> T
    ):T {
        for (item in _descriptionStorage) {
            if (item.id == id && item.filter == filter) {
                return Std.instance(item, resultType);
            }
        }
        var newDescription = activator();
        _descriptionStorage.push(newDescription);
        return newDescription;
    }

}
