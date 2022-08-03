;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS

section .text
    global load

section .data
    tag dd 0 ; the tag of the address
    offset dd 0 ; the offset of the address
    numberTags dd 0 ; total number of tags from the tags array
    currentTag dd 0 ; the current tag in the tags array
    counter dd 0 ; counter used when generating the 8 bytes from a line

searchTags:
    ; We are starting from the first tag
    mov esi, dword[currentTag]
    push edx

    ; Comparing the current tag from the array
    ; with the calculated one
    mov edx, dword[ebx]
    cmp edx, dword[tag]

    ; If the tag was found
    je found

    ; If not, we are going to the next address
    ; and searching until the array is over
    pop edx
    add ebx, 4
    add dword[currentTag], 1
    cmp esi, CACHE_LINES
    jnz searchTags

    ; If the tag does not exist in the tag array
    push edx
    mov edx, dword[tag]
    jmp notFound
    ret

found:
    push ebx
    push eax

    ; If the tag was found, just loading the
    ; wanted byte from the address in the reg
    ; and returning from the function
    mov eax, dword[offset]
    add eax, ecx
    xor ebx, ebx
    mov bl, byte[eax + esi * CACHE_LINE_SIZE]
    pop eax
    mov byte[eax], bl
    pop ebx
    pop edx
    ret

notFound:
    
    ; Generating the 8 consecutive bytes from
    ; the matrix starting from the tag at the
    ; to_replace line
    push eax
    xor eax, eax
    mov al, byte[edx]
    mov byte[ecx + CACHE_LINE_SIZE * edi], al
    pop eax
    inc ecx
    inc edx
    add dword[counter], 1
    cmp dword[counter], CACHE_LINE_SIZE
    jnz notFound

    sub ecx, 8
    sub edx, 8
    sub ebx, 4

    ; Adding the tag in the tag array at the
    ; to_replace position
    mov ebx, [ebp + 12]
    mov dword[ebx + 4 * edi], edx

    ; Loading the wanted value from the address
    ; at the to_replace line with the coresponded
    ; offset
    mov edx, dword[offset]
    add edx, ecx
    push ebx
    xor ebx, ebx
    mov bl, byte[edx + edi * CACHE_LINE_SIZE]
    mov byte[eax], bl
    pop ebx
    pop edx
    ret

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE
    mov dword[currentTag], 0
    mov dword[counter], 0
    mov dword[numberTags], 0

    ; Calculating the tag and the offset of the
    ; address
    mov dword[tag], edx
    shr dword[tag], OFFSET_BITS
    shl dword[tag], OFFSET_BITS
    mov dword[offset], edx
    shl dword[offset], TAG_BITS
    shr dword[offset], TAG_BITS

    ; Calling the function that is searching for the previously
    ; calculated tag if it exists in the tags array and loadin
    ; the wanted byte
    call searchTags

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


