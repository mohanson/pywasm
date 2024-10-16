import typing

from . import core


class Context:
    def __init__(
        self,
        type_list: typing.List[core.FuncType],
        function_list: typing.List[core.FuncType],
        table_list: typing.List[core.TableType],
        memory_list: typing.List[core.MemType],
        global_list: typing.List[core.GlobalType],
        local_list: typing.List[core.ValType],
        label_list: typing.List[core.ValType],
        return_list: typing.List[typing.List[core.ValType]],
    ):
        self.type_list = type_list
        self.function_list = function_list
        self.table_list = table_list
        self.memory_list = memory_list
        self.global_list = global_list
        self.local_list = local_list
        self.label_list = label_list
        self.return_list = return_list


def validate(module: core.Module):
    # Validation checks that a WebAssembly module is well-formed. Only valid modules can be instantiated.
    module_function_type_list = [module.type_list[e.type_index] for e in module.function_list]
    module_table_type_list = [e.type for e in module.table_list]
    module_memory_type_list = [e.type for e in module.memory_list]
    module_global_type_list = tuple(global_.type for global_ in module.globals)

    import_type_list = []
    for e in module.import_list:
        if isinstance(e.desc, core.TypeIndex):
            if e.desc >= len(module.type_list):
                raise Exception('pywasm: invalid import descriptor, type index is out of range.')
            import_type_list.append(module.type_list[e.desc])
            continue
        if isinstance(e.desc, (core.TableType, core.MemType, core.GlobalType)):
            import_type_list.append(module.type_list[e.desc])
            continue
        raise Exception('pywasm: unknown import descriptor type')

    import_function_types = [e for e in import_type_list if isinstance(e, core.FuncType)]
    import_table_types = [e for e in import_type_list if isinstance(e, core.TableType)]
    import_memory_types = [e for e in import_type_list if isinstance(e, core.MemType)]
    import_global_types = [e for e in import_type_list if isinstance(e, core.GlobalType)]

    context = Context(
        type_list=module.types,
        function_list=import_function_types + module_function_type_list,
        table_list=import_table_types + module_table_type_list,
        memory_list=import_memory_types + module_memory_type_list,
        global_list=import_global_types + module_global_type_list,
        local_list=(),
        label_list=(),
        return_list=(),
    )
    _ = context

    # [TODO]
