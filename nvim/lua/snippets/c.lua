local ls = require('luasnip')
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require('luasnip.extras.fmt').fmt

local function split_to_t_nodes(multiline_str)
    local nodes = {}
    for line in string.gmatch(multiline_str, '(.-)\r?\n') do
        table.insert(nodes, line)
    end
    return t(nodes)
end

local date = function()
    return { os.date('%Y-%m-%d') }
end

-- ls.add_snippets('lua', {
--     s('todos', {
--         t('-- TODO('),
--         i(1, 'p1'), -- placeholder 1
--         t('): '),
--         i(2, 'p2'), -- placeholder 2
--         t(' ['),
--         f(date, {}), -- insert date, call lua function date
--         t(']'),
--     }),
-- })

return {
    s('todo', {
        t([[
// TODO
        ]]),
    }),
    s(
        'pattern_polymorphism_tagged_union',
        split_to_t_nodes([[
// 1. 定义类型标签
typedef enum {
    TYPE_INT,
    TYPE_FLOAT,
    TYPE_STRING
} DataType;

// 2. 定义 Tagged Union 结构
typedef struct {
    DataType type; // 标签：记录当前存的是哪种类型
    union {        // 联合体：所有成员共用同一块内存
        int i_val;
        float f_val;
        char* s_val;
    } data;
} Variant;

// 3. 多态处理函数：根据标签执行不同逻辑
void printVariant(Variant v) {
    switch (v.type) {
        case TYPE_INT:
            printf("It's an int: %d\n", v.data.i_val);
            break;
        case TYPE_FLOAT:
            printf("It's a float: %.2f\n", v.data.f_val);
            break;
        case TYPE_STRING:
            printf("It's a string: %s\n", v.data.s_val);
            break;
    }
}
    ]])
    ),
    s(
        'pattern_polymorphism_generic',
        split_to_t_nodes([[
void print_int(int x) { printf("Integer: %d\n", x); }
void print_float(float x) { printf("Float: %f\n", x); }

// 定义一个泛型宏
#define print(x) _Generic((x), \
    int: print_int,            \
    float: print_float         \
)(x)
    ]])
    ),
    s(
        'pattern_polymorphism_vtable',
        split_to_t_nodes([[
// 模拟父类接口
typedef struct Shape {
    void (*draw)(void* self); // 函数指针实现“虚函数”
} Shape;

// 子类 1：Circle
typedef struct {
    Shape base; // 必须放在首位
    int radius;
} Circle;

void drawCircle(void* self) {
    Circle* c = (Circle*)self;
    printf("Drawing a circle with radius %d\n", c->radius);
}

// 子类 2：Square
typedef struct {
    Shape base;
    int side;
} Square;

void drawSquare(void* self) {
    Square* s = (Square*)self;
    printf("Drawing a square with side %d\n", s->side);
}

int main() {
    Circle c = {{drawCircle}, 5};
    Square s = {{drawSquare}, 10};

    // 统一用 Shape 指针处理（多态）
    Shape* shapes[] = {(Shape*)&c, (Shape*)&s};
    for (int i = 0; i < 2; i++) {
        shapes[i]->draw(shapes[i]); // 同一调用方式，表现不同行为
    }
    return 0;
}
    ]])
    ),
}
