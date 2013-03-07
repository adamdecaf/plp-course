# Region

Scoping works as you should expect..

```scheme
(let ((var val)
  ...
  ) exp)
```

(example from c)

```c
{
    int x = 4,
        y = 0,
        {
            int x = 3,
            z = 87
            printf(x + " " + z); // 3 4
            printf(x + " " + y); // 3 0
        }
        y = x + 1
        printf(x + " " + y); // 4 5
}
```
