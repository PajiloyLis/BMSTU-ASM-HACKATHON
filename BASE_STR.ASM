.model small

public EXIT_SUCCESS
public ALLOCATION_ERROR
public INDEX_OUT_OF_RANGE

EXIT_SUCCESS = 0
ALLOCATION_ERROR = 10
INDEX_OUT_OF_RANGE = 30

.data
    vector struc
        len dw 1 dup(?)
        arr dw 1 dup(?)
    vector ends
end
